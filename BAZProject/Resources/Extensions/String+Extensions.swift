//
//  String+Extensions.swift
//  BAZProject
//
//  Created by jmgarciaca on 20/04/23.
//

import Foundation

internal extension String {

    /// Returns a URL-encoded string representation of the current string, with special characters escaped.
    /// - Returns: An optional URL-encoded string representation of the current string.
    /// - Note: The method first applies URL encoding to characters that are allowed in a URL path segment, and then replaces the '&' character with '%26'.
    /// - Warning: This method returns nil if the encoding operation fails.
    func urlEncoded() -> String? {
        addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)?
            .replacingOccurrences(of: "&", with: "%26")
    }
    
    /// Converts an HTML string to an attributed string.
    /// - Returns: An NSAttributedString object if conversion succeeds, or nil if an error occurs during conversion.
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        
        return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}
