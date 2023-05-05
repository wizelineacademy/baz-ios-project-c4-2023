//
//  UIImageView+.swift
//  BAZProject
//
//  Created by Manuel S on 05/05/23.
//

import UIKit

// Metodos extras para la colocacion de las imagenes
extension UIImageView {
    /// Consulta desde una url para colocar la imagen
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url){[weak self] url, response, error in
            guard let self = self else { return }
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        downloadTask.resume()
        return downloadTask
    }
}
