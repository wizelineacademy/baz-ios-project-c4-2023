//
//  Consts.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 04/04/23.
//

import Foundation

///
/// Variables constantes para uso global
struct Consts {
    struct END_POINTS {
        static let API_KEY = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        static let URL = "https://api.themoviedb.org/3"
        static let POSTER_PATH = "https://image.tmdb.org/t/p/w500"
        static let PARAMS_API_KEY = "?api_key=\(API_KEY)"
        static let PARAMS_DEFAULT = PARAMS_API_KEY + "&language=es&region=MX&page=1"

        static let TRENDING = URL + "/trending/movie/day" + PARAMS_DEFAULT
        static let NOW_PLAYING = URL +  "/movie/now_playing" + PARAMS_DEFAULT
        static let POPULAR = URL +  "/movie/popular" + PARAMS_DEFAULT
        static let TOO_RATED = URL +  "/movie/top_rated" + PARAMS_DEFAULT
        static let UPCOMING = URL +  "/movie/upcoming" + PARAMS_DEFAULT

        static let SIMILAR = URL + "/movie/{movieID}/similar" + PARAMS_DEFAULT
        static let RECOMMENDATIONS = URL + "/movie/{movieID}/recommendations" + PARAMS_DEFAULT

        static let MOVIE_CAST = URL +  "/movie/{movieID}/casts" + PARAMS_DEFAULT
        static let MOVIE_REVIEWS = URL + "/movie/{movieID}/reviews" + PARAMS_API_KEY

        static let SEARCH_MOVIES = URL + "/search/movie" + PARAMS_DEFAULT + "&query={keyword}"
        static let SEARCH_FOR_KEYWORD = URL + "/search/keyword" + PARAMS_DEFAULT + "&query={keyword}"
    }
}
