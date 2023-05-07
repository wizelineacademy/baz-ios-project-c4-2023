//
//  DetailViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 05/05/23.
//

import UIKit

class DetailViewModel {
    
    typealias DetailSnapshot = NSDiffableDataSourceSnapshot<DetailSection, AnyHashable>
    
    private var remoteData: DetailRemoteData
    private var item: MediaItem
    private var snapshot = Box(DetailSnapshot())
    private var error: Box<Error?> = Box(nil)
    
    init(remoteData: DetailRemoteData, item: MediaItem) {
        self.item = item
        self.remoteData = remoteData
    }
    
    func bindSnapshot(_ listener: @escaping (DetailSnapshot) -> Void) {
        snapshot.bind(listener)
    }
    
    func bindError(_ listener: @escaping (Error?) -> Void) {
        error.bind(listener)
    }
    
    func getTitle() -> String? {
        return item.title
    }
    
    func getDetails() {
        guard let id = item.id, let mediaType = item.mediaType else {
            error.value = NSError(domain: "DetailModule.NoID_NoMediaType", code: -666)
            return
        }
        switch mediaType {
        case .tv:
            Task {
                do {
                    if let dataObject = try await getTVDetails(id: id) {
                        let dictionary = buildDictionary(from: dataObject)
                        setSnapshotWithDictionary(dictionary: dictionary)
                    }
                } catch {
                    self.error.value = error
                }
            }
        case .movie:
            Task {
                do {
                    if let dataObject = try await getMovieDetails(id: id) {
                        let dictionary = buildDictionary(from: dataObject)
                        setSnapshotWithDictionary(dictionary: dictionary)
                    }
                } catch {
                    self.error.value = error
                }
            }
        case .person:
            Task {
                do {
                    if let dataObject = try await getPersonDetails(id: id) {
                        let dictionary = buildDictionary(from: dataObject)
                        setSnapshotWithDictionary(dictionary: dictionary)
                    }
                } catch {
                    self.error.value = error
                }
            }
        }
    }
    
    
    func getDetailSections() -> [DetailSection]? {
        return item.mediaType?.sections
    }
    
    func getMovieDetails(id: Int) async throws -> MovieDetailDataObject? {
        return try await remoteData.getMovieDetails(id: id)
    }
    
    func getTVDetails(id: Int) async throws -> TVDetailDataObject? {
        return try await remoteData.getTVDetails(id: id)
    }
    
    func getPersonDetails(id: Int) async throws -> PersonDetailDataObject? {
        return try await remoteData.getPersonDetails(id: id)
    }
    
    func buildDictionary(from object: PersonDetailDataObject) -> [DetailSection: [AnyHashable]] {
        var ageTitle: String?
        var dictionary = [DetailSection: [AnyHashable]]()
        if let birthday = DateFormatter.getString(from: DateFormatter.getDate(from: object.birthday)) {
            ageTitle = "Birth: \(birthday)"
        }
        dictionary[.overview] = [DetailOverview(largeTitle: item.title, smallSubtitle: ageTitle, image: item.posterPath, description: object.biography)]
        if let credits = object.combinedCredits?.cast {
            dictionary[.filmography] = credits.trim(max: 20).map({ MediaItem(dataObject: $0) }).trim(max: 20)
        }
        return dictionary
    }
    
    func buildDictionary(from object: MovieDetailDataObject) -> [DetailSection: [AnyHashable]] {
        var dictionary = [DetailSection: [AnyHashable]]()
        dictionary[.overview] = [DetailOverview(largeTitle: item.title, smallSubtitle: Calendar.getString(component: .year, from: item.releaseDate), image: item.posterPath, description: object.overview, defaultImage: item.mediaType?.defaultImage)]
        dictionary[.similar] = object.similar?.results?.trim(max: 20).map({ MediaItem(dataObject: $0, mediaType: .movie) })
        dictionary[.recommended] = object.recommendations?.results?.trim(max: 20).map({ MediaItem(dataObject: $0) })
        let mainCast = object.credits?.cast?.filter({ ($0.order ?? 100) < 20 })
        dictionary[.cast] = mainCast?.trim(max: 20).map({ DetailCastMember(actor: MediaItem(id: $0.id, posterPath: $0.profilePath, title: $0.name, rating: nil, mediaType: .person, releaseDate: nil), character: $0.character) })
        dictionary[.reviews] = object.reviews?.reviews?.trim(max: 20).map({ DetailReview(from: $0) })
        return dictionary
    }
    
    func buildDictionary(from object: TVDetailDataObject) -> [DetailSection: [AnyHashable]] {
        var dictionary = [DetailSection: [AnyHashable]]()
        var timelabel: String?
        if let firstAirDate = Calendar.getString(component: .year, from: DateFormatter.getDate(from: object.firstAirDate)) {
            timelabel = String(firstAirDate)
            if object.status == "Ended", let lastAirDate = object.lastAirDate, let lastDate = Calendar.getString(component: .year, from: DateFormatter.getDate(from: lastAirDate)) {
                    timelabel?.append(" - \(lastDate)")
            }
        }
        dictionary[.overview] = [DetailOverview(largeTitle: item.title, smallSubtitle: timelabel, image: item.posterPath, description: object.overview, defaultImage: item.mediaType?.defaultImage)]
        dictionary[.similar] = object.similar?.results?.trim(max: 20).map({ MediaItem(dataObject: $0, mediaType: .tv) })
        dictionary[.recommended] = object.recommendations?.results?.trim(max: 20).map({ MediaItem(dataObject: $0) })
        let mainCast = object.credits?.cast?.filter({ ($0.order ?? 100) < 20 })
        dictionary[.cast] = mainCast?.trim(max: 20).map({ DetailCastMember(actor: MediaItem(id: $0.id, posterPath: $0.profilePath, title: $0.name, rating: nil, mediaType: .person, releaseDate: nil), character: $0.character) })
        dictionary[.reviews] = object.reviews?.reviews?.trim(max: 20).map({ DetailReview(from: $0) })
        return dictionary
    }
    
    func setSnapshotWithDictionary(dictionary: [DetailSection: [AnyHashable]]) {
        let sections = Array(dictionary.keys).sorted(by: { $0.rawValue < $1.rawValue })
        var auxSnapshot = DetailSnapshot()
        auxSnapshot.appendSections(sections)
        dictionary.forEach { key, value in
            auxSnapshot.appendItems(value, toSection: key)
        }
        snapshot.value = auxSnapshot
    }
    
}

private extension MediaType {
    
    var sections: [DetailSection] {
        switch self {
        case .tv: return [DetailSection.overview, DetailSection.cast, DetailSection.recommended, DetailSection.similar, DetailSection.reviews]
        case .movie: return [DetailSection.overview, DetailSection.cast, DetailSection.recommended, DetailSection.similar, DetailSection.reviews]
        case .person: return [DetailSection.overview, DetailSection.filmography]
        }
    }
    
}
