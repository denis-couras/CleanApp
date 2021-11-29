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
        let data = try? JSONEncoder().encode(addAccountModel)
        httpClient.post(to: url, with: data)
    }
}


protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}
class ApiAddAccountTests: XCTestCase {
    func testAddShouldCallHttpClientWithCorrectUrl() {
        let url = URL(string: "http://any.com")!
        let httpClient = HttpClientSpy()
        let sut = ApiAddAccount(url: url, httpClient: httpClient)
        let addAccountModel = AddAccountModel(name: "any_name", email: "any@email.com", password: "pass", passwordConfirmation: "pass")
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClient.url, url)
    }
    func testAddShouldCallHttpClientWithCorrectData() {
        let httpClient = HttpClientSpy()
        let sut = ApiAddAccount(url: URL(string: "http://any.com")!, httpClient: httpClient)
        let addAccountModel = AddAccountModel(name: "any_name", email: "any@email.com", password: "pass", passwordConfirmation: "pass")
        sut.add(addAccountModel: addAccountModel)
        let data = try? JSONEncoder().encode(addAccountModel)
        XCTAssertEqual(httpClient.data, data)
    }
    class HttpClientSpy: HttpPostClient {
        var url: URL?
        var data: Data?
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
