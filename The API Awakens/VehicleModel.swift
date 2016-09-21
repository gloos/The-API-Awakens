//
//  VehicleModel.swift
//  The API Awakens
//
//  Created by Gary Luce on 21/09/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import Foundation

struct Vehicle {
    
    let name: String
    let model: String
    let vehicleClass: String
    let manufacturer: String
    let length: String
    let costInCredits: String
    let crew: String
    let passengers: String
    let maxAtmospheringSpeed: String
    let cargoCapacity: String
    let consumables: String
    let films: [String]
    let pilots: [String]
    let url: String
    let created: String
    let edited: String
}

extension Vehicle {
    init?(json: [String: AnyObject]) {
        guard let name = json["name"] as? String, let model = json["model"] as? String, let vehicleClass = json["vehicle_class"] as? String, let manufacturer = json["manufacturer"] as? String, let length = json["length"] as? String, let costInCredits = json["cost_in_credits"] as? String, let crew = json["crew"] as? String, let passengers = json["passengers"] as? String, let maxAtmospheringSpeed = json["max_atmosphering_speed"] as? String, let cargoCapacity = json["cargo_capacity"] as? String, let consumables = json["consumables"] as? String, let url = json["url"] as? String, let created = json["created"] as? String, let edited = json["edited"] as? String, let films = json["films"] as? [String], let pilots = json["pilots"] as? [String] else {
            return nil
        }
        self.name = name
        self.model = model
        self.vehicleClass = vehicleClass
        self.manufacturer = manufacturer
        self.length  = length
        self.costInCredits = costInCredits
        self.crew = crew
        self.passengers = passengers
        self.maxAtmospheringSpeed = maxAtmospheringSpeed
        self.cargoCapacity = cargoCapacity
        self.consumables = consumables
        self.url = url
        self.created = created
        self.edited = edited
        self.films = films
        self.pilots = pilots
}
}
