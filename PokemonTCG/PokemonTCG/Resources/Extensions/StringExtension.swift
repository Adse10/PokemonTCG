//
//  StringExtension.swift
//  Nerdeame-ios
//
//  Created by Adrián Bolaños Ríos on 22/04/2021.
//

import Foundation

extension String {
    
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func lowercasedLocalize() -> String {
        return localize().lowercased()
    }
    
    func uppercasedLocalize() -> String {
        return localize().uppercased()
    }
}
