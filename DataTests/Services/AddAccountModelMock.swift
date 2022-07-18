//
//  AddAccountModelMock.swift
//  DataTests
//
//  Created by Denis Couras on 01/12/21.
//

import Data
import Domain
import Foundation

class AddAccountModelMock {
    static func makeAddAccountModel() -> AddAccountModel {
        AddAccountModel(
            name: "any_name",
            email: "any@email.com",
            password: "pass",
            passwordConfirmation: "pass"
        )
    }

    static func makeAccountModel() -> AccountModel {
        AccountModel(
            id: "id",
            name: "any_name",
            email: "any@email.com",
            password: "pass"
        )
    }
}
