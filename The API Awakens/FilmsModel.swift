//
//  FilmsModel.swift
//  The API Awakens
//
//  Created by Gary on 23/09/2016.
//  Copyright © 2016 gloos. All rights reserved.
//

import Foundation

struct Films {
    let title: String
    let episodeId: Int
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: Date
    let species: [String]
    let starships: [String]
    let vehicles: [String]
    let characters: [String]
    let planets: [String]
    let url: String
    let created: String
    let edited: String
}

extension Films {
    init?(json: [String: AnyObject]) {
        guard let title = json["title"] as? String, let episodeId = json["episode_id"] as? Int, let openingCrawl = json["opening_crawl"] as? String, let director = json["director"] as? String, let producer = json["producer"] as? String, let releaseDate = json["release_date"] as? Date, let species = json["species"] as? [String], let starships = json["starships"] as? [String], let vehicles = json["vehicles"] as? [String], let characters = json["characters"] as? [String], let planets = json["planets"] as? [String], let url = json["url"] as? String, let created = json["created"] as? String, let edited = json["edited"] as? String else {
            return nil
        }
        
        self.title = title
        self.episodeId = episodeId
        self.openingCrawl = openingCrawl
        self.director = director
        self.producer = producer
        self.releaseDate = releaseDate
        self.species = species
        self.starships = starships
        self.vehicles = vehicles
        self.characters = characters
        self.planets = planets
        self.url = url
        self.created = created
        self.edited = edited
    }
}
