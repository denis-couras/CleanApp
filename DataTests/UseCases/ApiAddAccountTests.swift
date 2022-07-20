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

    let apiMock = ApiAddAccountMock()

    func testAddShouldCallHttpClientWithCorrectUrl() {
        let url = apiMock.makeUrl()
        let (sut, httpClientSpy) = apiMock.makeSut()
        sut.add(addAccountModel: AddAccountModelMock.makeAddAccountModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    func testAddShouldCallHttpClientWithCorrectData() {
        let (sut, httpClient) = apiMock.makeSut()
        let addAccountModel = AddAccountModelMock.makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel) { _ in }
        XCTAssertEqual(httpClient.data, addAccountModel.toData())
    }
    func testAddShouldCompleteWithErrorIfClientFails() {
        let (sut, httpClient) = apiMock.makeSut()
        apiMock.expect(sut, completionWith: .failure(.unexpected), when: {
            httpClient.completeWithError(.noConnection)
        })
    }

    func testAddShouldCompleteWithSuccess() {
        let (sut, httpClient) = apiMock.makeSut()
        let expectedAccount = AddAccountModelMock.makeAccountModel()
        apiMock.expect(sut, completionWith: .success(expectedAccount), when: {
            httpClient.completeWithData(expectedAccount.toData()!)
        })
    }

    func testAddShouldCompleteWithErrorWithInvalidData() {
        let (sut, httpClient) = apiMock.makeSut()
        apiMock.expect(sut, completionWith: .failure(.unexpected), when: {
            httpClient.completeWithData(apiMock.makeInvalidData())
        })
    }
}


