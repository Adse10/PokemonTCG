//
//  CardManagerDB.swift
//  PokemonTCG
//
//  Created by Adrián Bolaños Ríos on 26/04/2021.
//

import Foundation
import RealmSwift

class CardManagerDB{
    
    /* Función para guardar una card en la DB */
    func saveCard(_ card: Card, success: @escaping (_ isSave: Bool) -> (), failure: @escaping (_ error: Error) -> ()){
        
        guard let idCard = card.idCard, let nameCard = card.name else {
            fatalError("Ha ocurrido un error fatal al guardar la tarjeta ")
        }
        let cardSave = CardDB()
        cardSave.idCard = idCard
        cardSave.name = nameCard
        
        do {
            
            let realm = try Realm()
            
            if let _ = realm.object(ofType: CardDB.self, forPrimaryKey: idCard){
                // Ya existe, por lo que vamos a para la escritura
               success(false)
            }else{
                
                try realm.write {
                    realm.add(cardSave)
                }
                success(true)
            }

        } catch let error {
            print("Ha ocurrido un error: \(error.localizedDescription)")
            failure(error)
        }
    }
    
    /* Función para obtener uan card de la DB */
    func getCard(_ idCard: String, success: @escaping (_ card: CardDB) -> (), failure: @escaping (_ error: Error) -> ()){
        
        do {
            
            let realm = try Realm()
            let predicate = NSPredicate(format: "idCard = %@", idCard)
            let results = realm.objects(CardDB.self).filter(predicate)
            if let firstObject = results.first{
                success(firstObject)
            }
            
        } catch let error {
            print("Ha ocurrido un error: \(error.localizedDescription)")
        }
        
    }
    
    /* Función para eliminar una card de la DB */
    func deleteCard(_ idCard: String, success: @escaping (_ isDelete: Bool) -> (), failure: @escaping (_ error: Error) -> ()){
        
        do {
            
            let realm = try Realm()
            let predicate = NSPredicate(format: "idCard = %@", idCard)
            let results = realm.objects(CardDB.self).filter(predicate)
            if let firstObject = results.first{
                
                try realm.write{
                    realm.delete(firstObject)
                    success(true)
                }
            }
        } catch let error {
            print("Ha ocurrido un error: \(error.localizedDescription)")
        }
    }
}
