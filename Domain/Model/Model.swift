//
//  Model.swift
//  Domain
//
//  Created by Denis Couras on 29/11/21.
//

import Foundation
public protocol Model: Encodable {}

public extension Model {
    func toData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
