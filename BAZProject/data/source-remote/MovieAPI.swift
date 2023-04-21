//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    /// Servicio que consume de la API DB movie
    /// - Parameters:
    ///   - completion: El closure a llamar una vez que se completa la operación.
    ///   El closure toma un parámetro `[Movie]` que devolvera al terminar la peticion.
    func getMovies(filter: Filters, completion: @escaping ([Movie]) -> Void) {
        let url = getUrlFilter(filter).toUrl()

        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var movies: [Movie] = []
            defer {
                completion(movies)
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                  let results = json.object(forKey: "results") as? [NSDictionary]
            else { return }

            for result in results {
                if let id = result.object(forKey: "id") as? Int,
                   let title = result.object(forKey: "title") as? String,
                   let poster_path = result.object(forKey: "poster_path") as? String,
                   let overview = result.object(forKey: "overview") as? String,
                   let vote_average = result.object(forKey: "vote_average") as? Float,
                   let release_date = result.object(forKey: "release_date") as? String {
                    movies.append(Movie(id: id, title: title, poster_path: poster_path, overview: overview, vote_average: vote_average, release_date: release_date))
                }
            }
        }.resume()
    }
    
    /// Servicio que consume de la API DB movie
    func getRelatedMovies(filter: Filters, movieID: Int, completion: @escaping ([Movie]) -> Void) {
        let url = getUrlFilter(filter, movieID).toUrl()

        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var movies: [Movie] = []
            defer {
                completion(movies)
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                  let results = json.object(forKey: "results") as? [NSDictionary]
            else { return }

            for result in results {
                if let id = result.object(forKey: "id") as? Int,
                   let title = result.object(forKey: "title") as? String,
                   let poster_path = result.object(forKey: "poster_path") as? String,
                   let overview = result.object(forKey: "overview") as? String,
                   let vote_average = result.object(forKey: "vote_average") as? Float,
                   let release_date = result.object(forKey: "release_date") as? String {
                    movies.append(Movie(id: id, title: title, poster_path: poster_path, overview: overview, vote_average: vote_average, release_date: release_date))
                }
            }
        }.resume()
    }

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
    
    
    /// Servicio que consume de la API DB movie
    func getCastForMovie(movieID: Int, completion: @escaping ([Actor]) -> Void) {
        let url = Consts.END_POINTS.MOVIE_CAST.setParameters(old: "{movieID}", new: "\(movieID)").toUrl()

        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var characters: [Actor] = []
            defer {
                completion(characters)
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                  let results = json.object(forKey: "cast") as? [NSDictionary]
            else { return }

            for result in results {
                if let id = result.object(forKey: "id") as? Int,
                   let name = result.object(forKey: "name") as? String,
                   let profile_path = result.object(forKey: "profile_path") as? String,
                   let character = result.object(forKey: "character") as? String {
                    characters.append(Actor(id: id, name: name, profile_path: profile_path, character: character))
                }
            }
        }.resume()
    }
    
    /// Servicio que consume de la API DB movie
    func getReviewsForMovie(movieID: Int, completion: @escaping ([Review]) -> Void) {
        let url = Consts.END_POINTS.MOVIE_REVIEWS.setParameters(old: "{movieID}", new: "\(movieID)").toUrl()

        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var reviews: [Review] = []
            defer {
                completion(reviews)
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                  let results = json.object(forKey: "results") as? [NSDictionary]
            else { return }

            for result in results {
                if let author = result.object(forKey: "author") as? String,
                   let content = result.object(forKey: "content") as? String,
                   let authorDetails = result.object(forKey:"author_details") as? [String: Any],
                   let rating = authorDetails["rating"] as? Int,
                   let created_at = result.object(forKey: "created_at") as? String {
                    reviews.append(Review(author: author, content: content, rating: rating, created_at: created_at))
                }
            }
        }.resume()
    }
}
