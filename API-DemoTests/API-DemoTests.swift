//
//  API-DemoTests.swift
//  API-DemoTests
//
//  Created by Daniel Hilton on 25/06/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import XCTest
@testable import API_Demo

class API_DemoTests: XCTestCase {

    var networkManager: NetworkManager!
    
    override func setUpWithError() throws {
        super.setUp()
        networkManager = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        networkManager = nil
        super.tearDown()
    }


    func testValidUserCount() throws {
        let url = "https://jsonplaceholder.typicode.com/users"
        networkManager.downloadData(url: url) { (result: Result<[User],CustomError>) in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 10)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    
    func testInvalidURL() throws {
        let url = "https:/jsonplaceholder.typicode.com/users"
        networkManager.downloadData(url: url) { (result: Result<[User],CustomError>) in
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTAssertTrue(error == .invalidURL)
            }
        }
    }

}
