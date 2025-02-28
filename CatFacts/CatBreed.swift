//
//  CatBreed.swift
//  CatFacts
//
//  Created by Christian Manzaraz on 27/02/2025.
//

import Foundation

struct CatBreed: Identifiable, Codable {
    let id = UUID().uuidString
    var breed: String,
        country: String,
        origin: String,
        coat: String,
        pattern: String
    
    enum CodingKeys: CodingKey {
    case breed, country, origin, coat, pattern
    }
    
}
//breed, country, origin, coat, pattern
