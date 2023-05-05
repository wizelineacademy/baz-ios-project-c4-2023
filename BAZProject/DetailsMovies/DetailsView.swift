//
//  DetailsView.swift
//  BAZProject
//
//  Created by Manuel S on 26/04/23.
//

import UIKit
import MapKit
import CoreLocation

final class DetailsViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: Oulets
    
    var viewModel: DetailsViewModel
    let locationManager = CLLocationManager()
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewText: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var actorsCV: UICollectionView!
    @IBOutlet weak var similarCV: UICollectionView!
    @IBOutlet weak var recomendationsCV: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailsView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setmap()
        viewModel.bindMovie { [weak self] in
            DispatchQueue.main.async {
                self?.actorsCV.reloadData()
                self?.similarCV.reloadData()
                self?.recomendationsCV.reloadData()
            }
        }
    }

    /// Registro de los nibs para el uso de todos los CollectionViews
    func registerNibs() {
        let nib = UINib(nibName: "DetailsCollectionViewCell", bundle: nil)
        actorsCV.register(nib, forCellWithReuseIdentifier: "cell")
        similarCV.register(nib, forCellWithReuseIdentifier: "cell")
        recomendationsCV.register(nib , forCellWithReuseIdentifier: "cell")
    }
    
    /// Se setea todo lo necesario para cargar la vista
    func setView() {
        registerNibs()
        getAllInfo()
        setFavoriteButton()
        titleLabel.text = viewModel.getTitle()
        navigationItem.title = viewModel.getTitle()
        imageMovie.loadImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.getPathImage() ?? "")")!)
        overviewText.text = viewModel.getOverview()
        voteAverage.text = viewModel.getRating()
    }
    
    /// Consulta todos los servicios
    func getAllInfo() {
        viewModel.getCastMovie()
        viewModel.getSimilarMovies()
        viewModel.getRecommendationMovies()
    }
    /// Verifica si la pelicula esta en favoritos y cambia el titulo
    func setFavoriteButton() {
        let icon = viewModel.isMovieFavorite() ? Icon.heartFill : Icon.heart
        favoriteButton.setImage(icon, for: .normal)
    }
    
    // MARK: - Buttons
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        viewModel.isMovieFavorite() ? viewModel.deteleUserDefautls(key: DefaultsKey.favorites.rawValue) : viewModel.saveUserDefautls(key: DefaultsKey.favorites.rawValue)
        setFavoriteButton()
    }
}

// MARK: - Extensiones

extension DetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case actorsCV:
            return viewModel.getCastMovieMoviesCount() ?? 0
        case similarCV:
            return viewModel.getSimilarMoviesCount() ?? 0
        case recomendationsCV:
            return viewModel.getRecommendationMoviesCount() ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DetailsCollectionViewCell else { return UICollectionViewCell() }
        
        switch collectionView {
        case actorsCV:
            cell.setInfo(viewModel, indexPath: indexPath, type: .cast)
            return cell
        case similarCV:
            cell.setInfo(viewModel, indexPath: indexPath, type: .similar)
            return cell
        case recomendationsCV:
            cell.setInfo(viewModel, indexPath: indexPath, type: .recommendation)
            return cell
        default:
            return cell
        }
    }
}

// MARK: - Funciones de mapas
extension DetailsViewController {
    
    /// Configiracion del mapa para setear localicacion
    func setmap() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async { [weak self] in
             if CLLocationManager.locationServicesEnabled() {
                 self?.locationManager.delegate = self
                 self?.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                 self?.locationManager.startUpdatingLocation()
             }
        }
    }
    
    /// Agrega las Ubicaciones de los "cines" cercanos
    func addCinema(lat: CLLocationDegrees, long: CLLocationDegrees) {
        let annotation = MKPointAnnotation()
        annotation.title = "Cine"
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        mapView.addAnnotation(annotation)
    }
    
    /// Configuracion cuando se actualiza la localicacio
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            addCinema(lat: location.coordinate.latitude - 0.0005550 , long: location.coordinate.longitude - 0.00700)
            addCinema(lat: location.coordinate.latitude + 0.0008530 , long: location.coordinate.longitude + 0.002140)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    /// Configuracion de las anotaciones del mapa
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}
