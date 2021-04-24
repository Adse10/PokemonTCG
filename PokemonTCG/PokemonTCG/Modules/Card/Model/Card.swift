//
//  Card.swift
//  PokemonTCG
//
//  Created by Adrián Bolaños Ríos on 24/04/2021.
//

import Foundation

struct Cards: Codable {
    let cards: [Card]
    
    enum CodingKeys: String, CodingKey {
        case cards = "data"
    }
}

struct CardDetail: Codable {
    let card: Card
    
    enum CodingKeys: String, CodingKey{
        case card = "data"
    }
}

struct Card: Codable {
    let idCard: String?
    let name: String?
    let supertype: String?
    let hp: String?
    let number: String?
    let artist: String?
    let rarity: String?
    let subtypes: [String]?
    let types: [String]?
    let attacks: [Attack]?
    let weaknesses: [Weakness]?
    let images: Images?
    
    enum CodingKeys: String, CodingKey {
        case idCard = "id"
        case name
        case supertype
        case hp
        case number
        case artist
        case rarity
        case subtypes
        case types
        case attacks
        case weaknesses
        case images
    }
}


struct Attack: Codable {
    let name: String?
    let cost: [String]?
    let convertedEnergyCost: Int?
    let damage: String?
    let textAttack: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case cost
        case convertedEnergyCost
        case damage
        case textAttack = "text"
    }
}

struct Weakness: Codable {
    let type: String?
    let valueType: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case valueType = "value"
    }
}

struct Images: Codable {
    let small: String
    let large: String
}
