//
//  ApiAddAccountMock.swift
//  DataTests
//
//  Created by Denis Couras on 01/12/21.
//

import Data
import Domain
import XCTest
import Foundation

class ApiAddAccountMock: XCTestCase {
    func makeSut(url: URL = URL(string: "http://any.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let httpClient = HttpClientSpy()
        return (RemoteAddAccount(url: url, httpClient: httpClient), httpClient)
    }

    func expect(_ sut: RemoteAddAccount,
                completionWith expectedResult: Result<AccountModel, DomainError>,
                when action: () -> Void) {

        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: AddAccountModelMock.makeAddAccountModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.success(let expectedAccount), .success(let receivedAccount)):
                XCTAssertEqual(expectedAccount, receivedAccount)
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError)
            default:
                XCTFail("Expected \(expectedResult) received \(receivedResult) instead")
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }

    func makeInvalidData() -> Data {
        Data("invalid".utf8)
    }

    func makeUrl() -> URL {
        URL(string: "http://any.com")!
    }
}
