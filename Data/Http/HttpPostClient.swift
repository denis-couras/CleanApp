//
//  HttpPostClient.swift
//  Data
//
//  Created by Denis Couras on 29/11/21.
//

import Foundation
import Domain

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?, completion: @escaping (HttpError) -> Void)
}
