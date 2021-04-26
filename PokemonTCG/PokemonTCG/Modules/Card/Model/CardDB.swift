//
//  CardDB.swift
//  PokemonTCG
//
//  Created by Adrián Bolaños Ríos on 26/04/2021.
//

import Foundation
import RealmSwift

class CardDB: Object{
    @objc dynamic var idCard = ""
    @objc dynamic var name = ""
    
    override class func primaryKey() -> String? {
        return "idCard"
    }
    
    override class func indexedProperties() -> [String] {
        return ["name"]
    }
}
