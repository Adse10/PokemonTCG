//
//  UIImageViewExtension.swift
//  PokemonTCG_MVVM
//
//  Created by Adrián Bolaños Ríos on 23/04/2021.
//

import UIKit

extension UIImageView {
    
    func imageFromServerURL(urlString: String){
        
        if self.image == nil {
            self.image = UIImage(named: "pokeball")
        }
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            
            if error != nil{
                return
            }
            
            DispatchQueue.main.async {
                
                guard let data = data else {
                    return
                }
                let image = UIImage(data: data)
                self.image = image
            }
            
        }.resume()
    }
}
