//
//  DataTests.swift
//  DataTests
//
//  Created by Denis Couras on 22/11/21.
//

import XCTest
import Domain

class ApiAddAccount {
    private let url: URL
    private let httpClient: HttpPostClient
    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add(addAccountModel: AddAccountModel) {
        httpClient.post(to: url, with: addAccountModel.toData())
    }
}


protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}
class ApiAddAccountTests: XCTestCase {
    func testAddShouldCallHttpClientWithCorrectUrl() {
        let url = URL(string: "http://any.com")!
        let (sut, httpClientSpy) = ApiAddAccountMock().makeSut()
        sut.add(addAccountModel: AddAccountModelMock().makeAddAccountModel())
        XCTAssertEqual(httpClientSpy.url, url)
    }
    func testAddShouldCallHttpClientWithCorrectData() {
        let (sut, httpClient) = ApiAddAccountMock().makeSut()
        let addAccountModel = AddAccountModelMock().makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClient.data, addAccountModel.toData())
    }
    
}

class HttpClientSpy: HttpPostClient {
    var url: URL?
    var data: Data?
    func post(to url: URL, with data: Data?) {
        self.url = url
        self.data = data
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
