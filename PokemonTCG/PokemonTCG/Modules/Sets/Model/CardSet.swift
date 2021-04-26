//
//  CardSet.swift
//  PokemonTCG
//
//  Created by Adrián Bolaños Ríos on 26/04/2021.
//

import Foundation

struct ListSet: Codable {
    let data: [CardSet]
}

struct DetailSet: Codable {
    let data: CardSet
}

struct CardSet: Codable {
    let idSet: String?
    let name: String?
    let series: String?
    let printedTotal: Int?
    let total: Int?
    let ptcgoCode: String?
    let releaseDate: String?
    let updatedAt: String?
    let images: ImagesSet?
    
    enum CodingKeys: String, CodingKey{
        case idSet = "id"
        case name
        case series
        case printedTotal
        case total
        case ptcgoCode
        case releaseDate
        case updatedAt
        case images
    }
}

struct ImagesSet: Codable {
    let symbol: String?
    let logo: String?
}
