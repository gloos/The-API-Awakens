//
//  SpeciesModel.swift
//  The API Awakens
//
//  Created by Gary Luce on 24/09/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import Foundation

struct Species {
    let name: String
    let classification: String
    let designation: String
    let averageHeight: String
    let averageLifeSpan: String
    let eyeColors: String
    let hairColors: String
    let skinColors: String
    let language: String
    let homeworld: String
    let people: [String]
    let films: [String]
    let url: String
    let created: String
    let edited: String
}

extension Species {
    init?(json: [String: AnyObject]) {
        guard let name = json["name"] as? String, let classification = json["classification"] as? String, let designation = json["designation"] as? String, let averageHeight = json["average_height"] as? String, let averageLifeSpan = json["average_lifespan"] as? String, let eyeColors = json["eye_colors"] as? String, let hairColors = json["hair_colors"] as? String, let skinColors = json["skin_colors"] as? String, let language = json["language"] as? String, let homeworld = json["homeworld"] as? String, let people = json["people"] as? [String], let films = json["films"] as? [String], let url = json["url"] as? String, let created = json["created"] as? String, let edited = json["edited"] as? String  else {
            return nil
        }
        
        self.name = name
        self.classification = classification
        self.designation = designation
        self.averageHeight = averageHeight
        self.averageLifeSpan = averageLifeSpan
        self.eyeColors = eyeColors
        self.hairColors = hairColors
        self.skinColors = skinColors
        self.language = language
        self.homeworld = homeworld
        self.people = people
        self.films = films
        self.url = url
        self.created = created
        self.edited = edited
    }
}
