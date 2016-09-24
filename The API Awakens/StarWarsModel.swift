//
//  StarWarsModel.swift
//  The API Awakens
//
//  Created by Gary Luce on 17/09/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import Foundation
//Data model

enum SWAPI: String {
    case people, vehicles, starships, planet, species, films
}



class SWAPIClient: APIClient, APIEndpoint {
    var baseURL = "http://swapi.co/api/"
    var configuration: URLSessionConfiguration
    var session: URLSession {
        return URLSession(configuration: configuration)
    }
    var type: SWAPI
    
    init(type: SWAPI, configuration: URLSessionConfiguration) {
        self.type = type
        self.configuration = configuration
    }
    
    
    func fetch(completion: @escaping ([String:AnyObject]) -> Void) {
        print("Trying to fetch")
         let task = jsonRequestWith(stringURL: "\(baseURL)\(self.type.rawValue)/") { json, response, error in
            DispatchQueue.main.async {
                guard json != nil else {
                    if let error = error {
                        print("We have an error: \(error)")
                    }
                    return
                }
                completion(json!)
            }
        }
        
        task?.resume()
        
    }
    
    func fetch(stringURL: String, completion: @escaping ([String:AnyObject]) -> Void) {
        print("Trying to fetch")
        let task = jsonRequestWith(stringURL: stringURL) { json, response, error in
            DispatchQueue.main.async {
                guard json != nil else {
                    if let error = error {
                        print("We have an error: \(error)")
                    }
                    return
                }
                completion(json!)
            }
        }
        
        task?.resume()
        
    }
    
}
