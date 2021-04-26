//
//  CardSetDetailViewController.swift
//  PokemonTCG
//
//  Created by Adrián Bolaños Ríos on 26/04/2021.
//

import UIKit

final class CardSetDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageSet: UIImageView!
    @IBOutlet weak var lbBoldName: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbBoldReleaseDate: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    
    
    // MARK: - Properties
    
    private var idSet: String?
    private var managerConnection = CardSetManagerConnections()
    private var cardSet: CardSet?
    
    init(idSet: String){
        self.idSet = idSet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Cargamos estilos
        loadStyles()
        // Llamamos a los datos
        loadData()
    }
    
    // MARK: - Funciones privadas
    
    private func loadStyles(){
        // Textos
        lbBoldName.text = "name".localize()
        lbBoldReleaseDate.text = "release.date".localize()
        // Fuentes
        lbBoldName.font = UIFont.boldSystemFont(ofSize: 20)
        lbBoldReleaseDate.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func loadData(){
        guard let idSet = self.idSet else { return }
        managerConnection.getDetailSet(idSet: idSet) { cardSet in
            // Mostrmaos los datos
            self.cardSet = cardSet
            DispatchQueue.main.async {
                self.showDataInView()
            }
        } failure: { error in
            print("ha ocurrido un error: \(error.localizedDescription)")
        }

    }
    
   
    private func showDataInView(){
        if let setCard = cardSet {
            lbName.text = setCard.name
            lbReleaseDate.text = setCard.releaseDate
            if let logo = setCard.images?.logo {
                imageSet.sd_setImage(with: URL(string: logo), placeholderImage: UIImage(named: "pokeball"))
            }
            
        }
    }
    

}


