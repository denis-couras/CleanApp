//
//  HttpPostClient.swift
//  Data
//
//  Created by Denis Couras on 29/11/21.
//

import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}
