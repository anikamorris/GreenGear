//
//  Post.swift
//  GreenGear
//
//  Created by Anika Morris on 6/26/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation

struct Post: Codable {
    let title: String
    let body: String
    let author: String
}

struct PostAPIResponse: Decodable {
    let success: Bool
    let result: [Post]
}

