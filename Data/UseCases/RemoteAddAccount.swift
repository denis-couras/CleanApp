//
//  ApiAddAccount.swift
//  Data
//
//  Created by Denis Couras on 29/11/21.
//

import Domain
import Foundation

public final class RemoteAddAccount: AddAccount {
    private let url: URL
    private let httpClient: HttpPostClient

    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        httpClient.post(to: url, with: addAccountModel.toData()) { result in
            switch result {
            case.success(let data):
                guard let model: AccountModel = data.toModel() else {
                    completion(.failure(.unexpected))
                    return
                }
                completion(.success(model))
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
