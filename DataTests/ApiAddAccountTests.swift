//
//  DataTests.swift
//  DataTests
//
//  Created by Denis Couras on 22/11/21.
//

import XCTest

class ApiAddAccount {
    private let url: URL
    private let httpClient: HttpPostClient
    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add() {
        httpClient.post(url: url)
    }
}


protocol HttpPostClient {
    func post(url: URL)
}
class ApiAddAccountTests: XCTestCase {
    func testAddShouldCallHttpClientWithCorrectUrl() {
        let url = URL(string: "http://any.com")!
        let httpClient = HttpClientSpy()
        let sut = ApiAddAccount(url: url, httpClient: httpClient)
        sut.add()
        XCTAssertEqual(httpClient.url, url)
    }
    
    class HttpClientSpy: HttpPostClient {
        var url: URL?
        func post(url: URL) {
            
        }
    }
}
