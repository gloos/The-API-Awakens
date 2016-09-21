//
//  APIClient.swift
//  The API Awakens
//
//  Created by Gary Luce on 17/09/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import Foundation
//This should connect to any API and return JSON data
public let TRENetworkingErrorDomain = "com.gloos.swapi.NetworkingError"
public let MissingHTTPResponseError: Int = 10
public let UnexpectedResponseError: Int = 20
protocol APIEndpoint {
    var baseURL: String { get }
    var type: SWAPI { get }
}

protocol APIClient {
    var configuration: URLSessionConfiguration { get set }
    var session: URLSession { get }
    

}

extension APIClient {
    func jsonRequestWith(stringURL: String, completion: @escaping ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        if let request = URL(string: stringURL) {
            print("The request is to: \(request)")
            let task = session.dataTask(with: request) { data, response, error in
                guard let HTTPResponse = response as? HTTPURLResponse else {
                    let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")]
                    let error = NSError(domain: TRENetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                    completion(nil, nil, error)
                    return
                }
                
                if data == nil {
                    if let error = error {
                        completion(nil, HTTPResponse, error)
                    }
                } else {
                    switch HTTPResponse.statusCode {
                    case 200:
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                            print("The json res is \(json)")
                            completion(json, HTTPResponse, nil)
                        } catch let error as NSError {
                            completion(nil, HTTPResponse, error)
                        }
                    default:
                        print("Received HTTP response: \(HTTPResponse.statusCode), which was not handled")
                    }
                }
            }
            
            return task

        } else {
            return nil
        }
    }
}
