//
//  ApiAddAccountMock.swift
//  DataTests
//
//  Created by Denis Couras on 01/12/21.
//

import Data
import Domain
import Foundation

class ApiAddAccountMock {
    func makeSut(url: URL = URL(string: "http://any.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let httpClient = HttpClientSpy()
        return (RemoteAddAccount(url: url, httpClient: httpClient), httpClient)
    }
}
