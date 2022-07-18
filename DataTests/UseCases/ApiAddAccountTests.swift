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
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: AddAccountModelMock.makeAddAccountModel()) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .unexpected)
            case .success:
                XCTFail("Expected error receive \(result) instead")
            }
            exp.fulfill()
        }
        httpClient.completeWithError(.noConnection)
        wait(for: [exp], timeout: 1)
    }

    func testAddShouldCompleteWithSuccess() {
        let (sut, httpClient) = ApiAddAccountMock().makeSut()
        let exp = expectation(description: "waiting")
        let expectedAccount = AddAccountModelMock.makeAccountModel()
        sut.add(addAccountModel: AddAccountModelMock.makeAddAccountModel()) { result in
            switch result {
            case .success(let receivedAccount):
                XCTAssertEqual(receivedAccount, expectedAccount)
            case .failure:
                XCTFail("Expected success received \(result) instead")
            }
            exp.fulfill()
        }
        httpClient.completeWithData(expectedAccount.toData()!)
        wait(for: [exp], timeout: 1)
    }
}


