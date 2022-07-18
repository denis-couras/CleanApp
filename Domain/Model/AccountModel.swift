//
//  AccountModel.swift
//  Domain
//
//  Created by Denis Couras on 22/11/21.
//

import Foundation

public struct AccountModel: Model {

    public init(id: String, name: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }

    public var id: String
    public var name: String
    public var email: String
    public var password: String
}
