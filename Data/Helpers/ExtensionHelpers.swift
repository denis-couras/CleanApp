//
//  ExtensionHelpers.swift
//  Data
//
//  Created by Denis Couras on 18/07/22.
//

import Foundation

extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
