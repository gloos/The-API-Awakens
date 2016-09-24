//
//  PlanetModel.swift
//  The API Awakens
//
//  Created by Gary on 23/09/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import Foundation

struct Planet {
    let name: String
    let diameter: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let gravity: String
    let population: String
    let climate: String
    let terrain: String
    let surfaceWater: String
    let residents: [String]
    let films: [String]
    let url: String
    let created: String
    let edited: String
}

extension Planet {
    init?(json: [String: AnyObject]) {
        guard let name = json["name"] as? String, let diameter = json["diameter"] as? String, let rotationPeriod = json["rotation_period"] as? String, let orbitalPeriod = json["orbital_period"] as? String, let gravity = json["gravity"] as? String, let population = json["population"] as? String, let climate = json["climate"] as? String, let terrain = json["terrain"] as? String, let surfaceWater = json["surface_water"] as? String, let residents = json["residents"] as? [String], let films = json["films"] as? [String], let url = json["url"] as? String, let created = json["created"] as? String, let edited = json["edited"] as? String else {
            return nil
        }
        self.name = name
        self.diameter = diameter
        self.rotationPeriod = rotationPeriod
        self.orbitalPeriod = orbitalPeriod
        self.gravity = gravity
        self.population = population
        self.climate = climate
        self.terrain = terrain
        self.surfaceWater = surfaceWater
        self.residents = residents
        self.films = films
        self.url = url
        self.created = created
        self.edited = edited
}
}
