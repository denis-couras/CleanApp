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
        sut.add(addAccountModel: AddAccountModelMock.makeAddAccountModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    func testAddShouldCallHttpClientWithCorrectData() {
        let (sut, httpClient) = ApiAddAccountMock().makeSut()
        let addAccountModel = AddAccountModelMock.makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel) { _ in }
        XCTAssertEqual(httpClient.data, addAccountModel.toData())
    }
    func testAddShouldCompleteWithErrorIfClientFails() {
        let (sut, httpClient) = ApiAddAccountMock().makeSut()
        ApiAddAccountMock().expect(sut, completionWith: .failure(.unexpected), when: {
            httpClient.completeWithError(.noConnection)
        })
    }

    func testAddShouldCompleteWithSuccess() {
        let (sut, httpClient) = ApiAddAccountMock().makeSut()
        let expectedAccount = AddAccountModelMock.makeAccountModel()
        ApiAddAccountMock().expect(sut, completionWith: .success(expectedAccount), when: {
            httpClient.completeWithData(expectedAccount.toData()!)
        })
    }

    func testAddShouldCompleteWithErrorWithInvalidData() {
        let (sut, httpClient) = ApiAddAccountMock().makeSut()
        ApiAddAccountMock().expect(sut, completionWith: .failure(.unexpected), when: {
            httpClient.completeWithData(Data("invalid".utf8))
        })
    }
}


