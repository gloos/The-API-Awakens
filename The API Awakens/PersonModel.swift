//
//  PersonModel.swift
//  The API Awakens
//
//  Created by Gary Luce on 21/09/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import Foundation

struct Person {
    
    let name: String
    let birthYear: String
    let eyeColor: String
    let gender: String
    let hairColor: String
    let height: String
    let mass: String
    let skinColor: String
    var homeworld: String
    let url: String
    let created: String
    let edited: String
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
}

extension Person {
    init?(json: [String: AnyObject]) {
        guard let name = json["name"] as? String, let birthYear = json["birth_year"] as? String, let eyeColor = json["eye_color"] as? String, let gender = json["gender"] as? String, let hairColor = json["hair_color"] as? String, let height = json["height"] as? String, let mass = json["mass"] as? String, let skinColor = json["skin_color"] as? String, let homeworld = json["homeworld"] as? String, let url = json["url"] as? String, let created = json["created"] as? String, let edited = json["edited"] as? String, let films = json["films"] as? [String], let species = json["species"] as? [String], let vehicles = json["vehicles"] as? [String], let starships = json["starships"] as? [String] else {
            return nil
        }
        self.name = name
        self.birthYear = birthYear
        self.eyeColor = eyeColor
        self.gender = gender
        self.hairColor = hairColor
        self.height = height
        self.mass = mass
        self.skinColor = skinColor
        self.homeworld = homeworld
        self.url = url
        self.created = created
        self.edited = edited
        self.films = films
        self.species = species
        self.vehicles = vehicles
        self.starships = starships
    }
    

}
