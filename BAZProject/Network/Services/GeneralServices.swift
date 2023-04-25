//
//  GeneralServices.swift
//  BAZProject
//
//  Created by Ben Frank V. on 24/04/23.
//

import Foundation
import UIKit

public class GetImage{
    static func getImage(pathPoster: String, completion: @escaping (UIImage?) -> Void){
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinator(session: session)
        coordinator.queryValue = pathPoster
                
        coordinator.fetchImageData(posterPath: pathPoster) { image in
            if let poster = image {
                let convertedImage = UIImage(data: poster)
                completion(convertedImage)
            }else{
                let defaultPoster = UIImage(named: "poster")
                completion(defaultPoster)
            }
        }
    }
}
