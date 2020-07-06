//
//  User.swift
//  API-Demo
//
//  Created by Daniel Hilton on 25/06/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let website: String
}


struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}
