//
//  CardManagerConnections.swift
//  PokemonTCG
//
//  Created by Adrián Bolaños Ríos on 24/04/2021.
//

import Foundation

class CardManagerConnections{
    
    /* Función para obtener una página de cartas */
    func getListCard(page: Int, success: @escaping (_ listCard: [Card]) -> (), failure: @escaping (_ error: Error) -> ()){
        
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: Endpoints.main + Endpoints.listCard + "?page=" + String(page) + "&pageSize=20")!)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("X-Api-Key", forHTTPHeaderField: Endpoints.apiKey)
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                return
            }
            
            if response.statusCode == 200 {
                do {
                    
                    let decoder = JSONDecoder()
                    let cards = try decoder.decode(Cards.self, from: data)
                    print(cards.cards)
                    success(cards.cards)
                    
                } catch let error {
                    
                    failure(error)
                    print("Ha ocurrido un error: \(error.localizedDescription)")
                }
            }
            else if response.statusCode == 401 {
                print("Error 401")
            }
        }.resume()
        
    }
    
    /* Función para obtener el detalle de una carta */
    func getDetailCard(idCard: String, success: @escaping (_ card: Card) -> (), failure: @escaping (_ error: Error) -> ()){
        
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: Endpoints.main + Endpoints.detailCard + idCard)!)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("X-Api-Key", forHTTPHeaderField: Endpoints.apiKey)
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                return
            }
            
            if response.statusCode == 200 {
                do {
                    
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CardDetail.self, from: data)
                     success(result.card)
                    
                } catch let error {
                    
                    failure(error)
                    print("Ha ocurrido un error: \(error.localizedDescription)")
                }
            }
            else if response.statusCode == 401 {
                print("Error 401")
            }
        }.resume()
    }
    
}
