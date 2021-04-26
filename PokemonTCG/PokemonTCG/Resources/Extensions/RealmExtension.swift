//
//  RealmExtension.swift
//  PokemonTCG
//
//  Created by Adrián Bolaños Ríos on 26/04/2021.
//

import Foundation
import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
