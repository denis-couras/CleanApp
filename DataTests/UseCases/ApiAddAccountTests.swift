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
        sut.add(addAccountModel: AddAccountModelMock().makeAddAccountModel())
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    func testAddShouldCallHttpClientWithCorrectData() {
        let (sut, httpClient) = ApiAddAccountMock().makeSut()
        let addAccountModel = AddAccountModelMock().makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClient.data, addAccountModel.toData())
    }
    
}

class HttpClientSpy: HttpPostClient {
    var urls = [URL]()
    var data: Data?
    func post(to url: URL, with data: Data?) {
        self.urls.append(url)
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
