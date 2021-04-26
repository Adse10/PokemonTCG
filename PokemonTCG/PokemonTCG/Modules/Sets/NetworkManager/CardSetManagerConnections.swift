//
//  CardSetManagerConnections.swift
//  PokemonTCG
//
//  Created by Adrián Bolaños Ríos on 26/04/2021.
//

import Foundation

class CardSetManagerConnections {
    
    /* Función para obtener los diferentes sets */
    func getAllSet(page: Int, success: @escaping (_ cardSets: [CardSet]) -> (), failure: @escaping (_ error: Error) -> ()){
        
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: Endpoints.main + Endpoints.listSet + "?page=" + String(page) + "&pageSize=20")!)
        
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
                    let result = try decoder.decode(ListSet.self, from: data)
                    success(result.data)
                    
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
    
    /* Función para obtener el detalle de un set */
    func getDetailSet(idSet: String, success: @escaping (_ cardSet: CardSet) -> (), failure: @escaping (_ error: Error) -> ()){
        
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: Endpoints.main + Endpoints.detailSet + idSet)!)
        
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
                    let result = try decoder.decode(DetailSet.self, from: data)
                    success(result.data)
                    
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
