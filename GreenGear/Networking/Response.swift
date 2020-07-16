//
//  Response.swift
//  GreenGear
//
//  Created by Anika Morris on 7/15/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

struct Response {

    static func handleResponse(for response: HTTPURLResponse?) -> Result<String>{

        guard let res = response else { return Result.failure(NetworkError.noResponse)}
        print("status code: \(res.statusCode)")
        switch res.statusCode {
        case 200...299: return .success(NetworkError.success.rawValue)
        case 401: return .failure(NetworkError.authenticationError)
        case 400...499: return .failure(NetworkError.badRequest)
        case 500...599: return .failure(NetworkError.serverError)
        default: return .failure(NetworkError.failed)
        }
    }

}
