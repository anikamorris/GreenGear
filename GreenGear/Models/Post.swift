//
//  Post.swift
//  GreenGear
//
//  Created by Anika Morris on 6/26/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation

struct Post {
    let content: String
    let user: User
    let comments: [Comment]?
}
