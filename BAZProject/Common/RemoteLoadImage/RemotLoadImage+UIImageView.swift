//
//  RemotLoadImage+UIImageView.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 20/04/23.
//

import Foundation
import UIKit

//Protocolo que obtiene una imagen de una URL
protocol RemoteLoadImage{
    func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ())
}
// Extension de UIImageView para cargar una imagen del servidor
extension UIImage: RemoteLoadImage{
    /**
        Funcion que obtiene una imagen del servidor y regresa un`UIImage`
      - Parameters:
        - url: La URL de la .Imagen
        - completion:  Retorna un UIImage .
      - Returns: UIImage con la imagen descargada del servidor
    */
    func loadFrom(url: URL, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
