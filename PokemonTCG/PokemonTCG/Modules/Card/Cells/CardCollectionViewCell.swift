//
//  CardCollectionViewCell.swift
//  PokemonTCG
//
//  Created by Adrián Bolaños Ríos on 24/04/2021.
//

import UIKit
import SDWebImage

class CardCollectionViewCell: UICollectionViewCell {
    
    static let kIdentifier = "CardCollectionViewCell"
    
    @IBOutlet weak var imgCard: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgCard.image = nil
    }
    
    func loadData(card: Card){
        if let imageCard = card.images?.small {
            imgCard.sd_setImage(with: URL(string: imageCard), placeholderImage: UIImage(named: "pokeball"))
        }
    }
    
    

}
