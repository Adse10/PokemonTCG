//
//  CardSetTableViewCell.swift
//  PokemonTCG
//
//  Created by Adrián Bolaños Ríos on 26/04/2021.
//

import UIKit

class CardSetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imageSet: UIImageView!
    
    static let kIdentifier = "CardSetTableViewCell"
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageSet.image = nil
    }
    
    func loadData(cardSet: CardSet){
        lbName.text = cardSet.name
        if let image = cardSet.images?.logo {
            imageSet.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "pokeball"))
        }
    }
    
}
