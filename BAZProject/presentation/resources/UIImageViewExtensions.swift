//
//  UIImageViewExtensions.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 04/04/23.
//

import Foundation
import UIKit

extension UIImageView {
    /// La extensión de UIImageView agrega una función loadAsync que puede ser utilizada en cualquier instancia de UIImageView
    ///
    /// - Parameters:
    ///   - from: un parámetro de tipo URL que indica la URL de la imagen que se va a descargar y cargar en el objeto UIImageView.
    ///   - placeHolder: un parámetro de tipo UIImage que se usara en caso de que la URL proporcionada sea erronea o no encuentre la imagen.
    ///   - completion: un parámetro opcional de tipo (() -> Void)? que representa un bloque de código que se ejecutará después de que se complete la descarga de la imagen. Este bloque no devuelve ningún valor y no toma ningún parámetro.
    func loadAsync(from url: URL, placeHolder: UIImage?, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .userInitiated).async {
            // La tarea se ejecutará en segundo plano en una cola global con una calidad de servicio de .userInitiated
            do {
                let imageData = try Data(contentsOf: url)
                // Descarga la imagen desde la URL como un objeto de datos
                DispatchQueue.main.async {
                    // Devuelve la tarea a la cola principal para actualizar la interfaz de usuario
                    self.image = UIImage(data: imageData)
                    // Muestra la imagen en el objeto UIImageView
                    completion?()
                    // Ejecuta el bloque de finalización si se proporciona
                }
            } catch {
                DispatchQueue.main.async {
                    self.image = placeHolder
                    completion?()
                    // Si hay un error al cargar la imagen, se usa el parametro placeHolder
                }
            }
        }
    }
}
