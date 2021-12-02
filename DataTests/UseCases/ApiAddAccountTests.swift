//
//  DataTests.swift
//  DataTests
//
//  Created by Denis Couras on 22/11/21.
//

import XCTest
import Domain
import Data

class ApiAddAccountTests: XCTestCase {
    func testAddShouldCallHttpClientWithCorrectUrl() {
        let url = URL(string: "http://any.com")!
        let (sut, httpClientSpy) = ApiAddAccountMock().makeSut()
        sut.add(addAccountModel: AddAccountModelMock().makeAddAccountModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    func testAddShouldCallHttpClientWithCorrectData() {
        let (sut, httpClient) = ApiAddAccountMock().makeSut()
        let addAccountModel = AddAccountModelMock().makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel) { _ in }
        XCTAssertEqual(httpClient.data, addAccountModel.toData())
    }
    func testAddShouldCompleteWithErrorIfClientFails() {
        let (sut, httpClient) = ApiAddAccountMock().makeSut()
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: AddAccountModelMock().makeAddAccountModel()) { error in
            XCTAssertEqual(error, .unexpected)
            exp.fulfill()
        }
        httpClient.completeWithError(.noConnection)
        wait(for: [exp], timeout: 1)
    }
}

class HttpClientSpy: HttpPostClient {
    var urls = [URL]()
    var data: Data?
    var completion: ((HttpError) -> Void)?
    func post(to url: URL, with data: Data?, completion: @escaping (HttpError) -> Void) {
        self.urls.append(url)
        self.data = data
        self.completion = completion
    }
    
    func completeWithError(_ error: HttpError) {
        completion?(error)
    }
}

class ApiAddAccountMock {
    func makeSut(url: URL = URL(string: "http://any.com")!) -> (sut: ApiAddAccount, httpClientSpy: HttpClientSpy) {
        let httpClient = HttpClientSpy()
        return (ApiAddAccount(url: url, httpClient: httpClient), httpClient)
    }
}

class AddAccountModelMock {
    func makeAddAccountModel() -> AddAccountModel {
        AddAccountModel(
            name: "any_name",
            email: "any@email.com",
            password: "pass",
            passwordConfirmation: "pass"
        )
    }
}
