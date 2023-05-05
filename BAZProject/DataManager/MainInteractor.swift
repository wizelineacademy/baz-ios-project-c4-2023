//
//  MainInteractor.swift
//  BAZProject
//
//  Created by jehernandezg on 04/05/23.
//

import UIKit

protocol MainInteractorProtocol {
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void)
    func saveFavorite(index: Int, onSaved: @escaping () -> Void)
    func getFavorites() -> [MovieResult]?
    var movies: [ListMovieProtocol]? { get }
}

extension MainInteractorProtocol {
    /**
     Function that returns a `UIImage` for a specific movie
     - Parameters:
        - index: The index of the url image
        - completion: Returns a UIImage
     - Returns: The image from data.
     - Version: 1.0.0
    */
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        if let path = URL(string: "\(MovieAPIConstans.baseUrlImage)\(movies?[index].posterPath ?? "")") ?? URL(string: "") {
            let imageLoader: ImageLoader = ImageLoader()
            imageLoader.loadImage(from: path) { image in
                completion(image)
            }
        }
    }
    
    ///
    func saveFavorite(index: Int, onSaved: @escaping () -> Void) {
        guard let favorite = self.movies?[index] as? MovieResult else { return }
        if let data = UserDefaults.standard.data(forKey: KUserDefaultsKeys.kFavorite.rawValue) {
            if let userDefaultsList = try? JSONDecoder().decode([MovieResult].self, from: data) {
                var updatedList = [MovieResult]()
                userDefaultsList.forEach { show in
                    updatedList.append(show)
                }
                if !updatedList.contains(where: {$0.id == favorite.id }) {
                    updatedList.append(favorite)
                }
                if let encoded = try? JSONEncoder().encode(updatedList) {
                    UserDefaults.standard.set(encoded, forKey: KUserDefaultsKeys.kFavorite.rawValue)
                    //debugPrint(updatedList)
                    onSaved()
                    return
                }
            }
        } else {
            var updatedList = [MovieResult]()
            updatedList.append(favorite)
            if let encoded = try? JSONEncoder().encode(updatedList) {
                UserDefaults.standard.set(encoded, forKey: KUserDefaultsKeys.kFavorite.rawValue)
                //debugPrint(updatedList)
                onSaved()
                return
            }
        }
    }
    
    func deleteFavorite(index: Int, onSaved: @escaping () -> Void) {
        guard let favorite = self.movies?[index] as? MovieResult else { return }
        //se obtiene data de favoritos previos
        if let data = UserDefaults.standard.data(forKey: KUserDefaultsKeys.kFavorite.rawValue) {
            //se obtiene arreglo de userDefaultsList de favoritos guardados
            if let userDefaultsList = try? JSONDecoder().decode([MovieResult].self, from: data) {
                //Se filtran movies de arreglo anterior, que no contengan la pelicula que se quiere eliminar de favoritos
                let updatedList = userDefaultsList.filter({$0.id != favorite.id})
                if let encoded = try? JSONEncoder().encode(updatedList) {
                    //se guarda el arreglo de favoritos actualizado en UserDefaults encodeado
                    UserDefaults.standard.set(encoded, forKey: KUserDefaultsKeys.kFavorite.rawValue)
                    //debugPrint(updatedList)
                    onSaved()
                    return
                }
            }
        }
        onSaved()
    }
    
    func getFavorites() -> [MovieResult]? {
        if let data = UserDefaults.standard.data(forKey: KUserDefaultsKeys.kFavorite.rawValue) {
            if let decoded = try? JSONDecoder().decode([MovieResult].self, from: data) {
                return decoded
            }
        }
        return nil
    }
    
}
