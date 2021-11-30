//
//  ApiAddAccount.swift
//  Data
//
//  Created by Denis Couras on 29/11/21.
//

import Domain
import Foundation

public final class ApiAddAccount {
    private let url: URL
    private let httpClient: HttpPostClient
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func add(addAccountModel: AddAccountModel) {
        httpClient.post(to: url, with: addAccountModel.toData())
    }
}