//
//  MockData.swift
//  BAZProject
//
//  Created by 989438 on 25/04/23.
//

import Foundation
@testable import BAZProject

struct MockData {
    static let shared = MockData()

    let summary: MovieDetailModel = {
        .summary([Movie(id: 1, title: "Nombre Apellido", posterPath: Data(), summary: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", backdropPath: "", backdropPathData: nil)])
    }()
    
    let starring: MovieDetailModel = {
        .starring([ActorModel(name: "Max", profileImage: nil)])
    }()
    
    let similar: MovieDetailModel = {
        .similar([Movie(id: 1, title: "Nombre Apellido", posterPath: Data(), summary: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", backdropPath: "", backdropPathData: nil)])
    }()
    
    let recommended: MovieDetailModel = {
        .recomended([Movie(id: 1, title: "Nombre Apellido", posterPath: Data(), summary: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", backdropPath: "", backdropPathData: nil)])
    }()
    
    let review: MovieDetailModel = {
        .reviews([ReviewModel(name: "Maximiliano Lopez", rating: 8.0, content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", avatar: nil)])
    }()
}
