//
//  Comment.swift
//  API-Demo
//
//  Created by Daniel Hilton on 25/06/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let name: String
    let email: String
    let body: String
}
