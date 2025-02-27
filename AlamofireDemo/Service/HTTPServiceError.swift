//
//  HTTPServiceError.swift
//  AlamofireDemo
//
//  Created by Huei-Der Huang on 2025/2/26.
//

import Foundation

enum HTTPServiceError: Error {
    case InvalidURL
    case InvalidWithError(Error)
}
