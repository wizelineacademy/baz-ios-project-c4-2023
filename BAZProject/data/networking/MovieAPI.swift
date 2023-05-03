//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    /**
     Servicio que consume de la API DB movie
     - Parameter filter: El enum Filters que especifica los filtros para obtener películas.
     - Parameter completion: El closure a llamar una vez que se completa la operación.
                             El closure toma un parámetro `[Movie]` que devolvera al terminar la peticion.
     */
    func getMovies(filter: Filters, completion: @escaping ([Movie]) -> Void) {
        let url = getUrlFilter(filter).toUrl()

        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var movies: [Movie] = []
            defer {
                completion(movies)
            }
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MoviesResponse.self, from: data)
                movies = response.results
            } catch {
                print("\(#function) Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    /**
     Servicio que consume de la API DB movie
     - Parameter filter: El enum Filters que especifica los filtros para obtener películas.
     - Parameter completion: El closure a llamar una vez que se completa la operación.
                             El closure toma un parámetro `[Movie]` que devolvera al terminar la peticion.
     */
    func getRelatedMovies(filter: Filters, movieID: Int, completion: @escaping ([Movie]) -> Void) {
        let url = getUrlFilter(filter, movieID).toUrl()

        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var movies: [Movie] = []
            defer {
                completion(movies)
            }
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MoviesResponse.self, from: data)
                movies = response.results
            } catch {
                print("\(#function) Error decoding JSON: \(error)")
            }
        }.resume()
    }

    /**
     Metodo para retornar el string del EndPoint de las constastes de la capa de dominio
     - Parameter filter: El enum Filters que especifica el EndPoint a usar.
     - Parameter movieID: parametro opcional para complementar el EndPoint
     */
    private func getUrlFilter(_ filter: Filters, _ movieID: Int? = nil) -> String {
        switch filter {
        case .trending:
            return Consts.END_POINTS.TRENDING
        case .nowPlaying:
            return Consts.END_POINTS.NOW_PLAYING
        case .popular:
            return Consts.END_POINTS.POPULAR
        case .topRated:
            return Consts.END_POINTS.TOO_RATED
        case .upcoming:
            return Consts.END_POINTS.UPCOMING
        case .similar:
            return Consts.END_POINTS.SIMILAR.setParameters(old: "{movieID}", new: "\(movieID ?? 0)")
        case .recommendations:
            return Consts.END_POINTS.RECOMMENDATIONS.setParameters(old: "{movieID}", new: "\(movieID ?? 0)")
        }
    }
    
    
    /**
     Servicio que consume de la API DB movie
     - Parameter movieID: El id de la pelicula
     - Parameter completion: El closure a llamar una vez que se completa la operación.
                             El closure toma un parámetro `[Actor]` que devolvera al terminar la peticion.
     */
    func getCastForMovie(movieID: Int, completion: @escaping ([Actor]) -> Void) {
        let url = Consts.END_POINTS.MOVIE_CAST.setParameters(old: "{movieID}", new: "\(movieID)").toUrl()

        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var characters: [Actor] = []
            defer {
                completion(characters)
            }
            guard let result = data else { return }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ActorResponse.self, from: result)
                characters = response.cast
            } catch {
                print("\(#function) Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    /**
     Servicio que consume de la API DB movie
     - Parameter movieID: El id de la pelicula
     - Parameter completion: El closure a llamar una vez que se completa la operación.
                             El closure toma un parámetro `[Review]` que devolvera al terminar la peticion.
     */
    func getReviewsForMovie(movieID: Int, completion: @escaping ([Review]) -> Void) {
        let url = Consts.END_POINTS.MOVIE_REVIEWS.setParameters(old: "{movieID}", new: "\(movieID)").toUrl()

        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var reviews: [Review] = []
            defer {
                completion(reviews)
            }
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ReviewResponse.self, from: data)
                reviews = response.results
            } catch {
                print("\(#function) Error decoding JSON: \(error)")
            }
        }.resume()
    }

    /**
     Servicio que consume de la API DB movie
     - Parameter query: Palabra a consultar
     - Parameter completion: El closure a llamar una vez que se completa la operación.
                             El closure toma un parámetro `[Movie]` que devolvera al terminar la peticion.
     */
    func searchMoviesForKeyword(_ query: String, completion: @escaping ([Movie]) -> Void) {
        let url = Consts.END_POINTS.SEARCH_MOVIES.setParameters(old: "{keyword}", new: query).toUrl()
        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var movies: [Movie] = []
            defer {
                completion(movies)
            }
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MoviesResponse.self, from: data)
                movies = response.results
            } catch {
                print("\(#function) Error decoding JSON: \(error)")
            }
        }.resume()
    }

    /**
     Servicio que consume de la API DB movie
     - Parameter query: Palabra a consultar
     - Parameter completion: El closure a llamar una vez que se completa la operación.
                             El closure toma un parámetro `[Movie]` que devolvera al terminar la peticion.
     */
    func searchForKeyword(_ query: String, completion: @escaping ([String]) -> Void) {
        let url = Consts.END_POINTS.SEARCH_FOR_KEYWORD.setParameters(old: "{keyword}", new: query).toUrl()
        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var keywords: [String] = []
            defer {
                completion(keywords)
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                  let results = json.object(forKey: "results") as? [NSDictionary]
            else { return }

            for result in results {
                if let name = result.object(forKey: "name") as? String {
                    keywords.append(name)
                }
            }
        }.resume()
    }

    /**
     Metodo generico para consumir peticiones
     */
    func request<T: Decodable>(url: URL, completion: @escaping ([T]) -> Void) {
        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var items: [T] = []
            defer {
                completion(items)
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            guard let results = try? decoder.decode([T].self, from: data) else { return }
            items = results
        }.resume()
    }
}
