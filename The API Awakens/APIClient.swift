//
//  APIClient.swift
//  The API Awakens
//
//  Created by Gary Luce on 17/09/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import Foundation
//This should connect to any API and return JSON data
protocol APIEndpoint {
    var baseURL: String { get }
    var components: String { get }
    var parameters: [String : AnyObject] { get }
}

extension APIEndpoint {

}
