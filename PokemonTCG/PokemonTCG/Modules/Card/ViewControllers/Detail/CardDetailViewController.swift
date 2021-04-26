//
//  CardDetailViewController.swift
//  PokemonTCG
//
//  Created by Adrián Bolaños Ríos on 24/04/2021.
//

import UIKit
import ImageViewer

final class CardDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lbBoldName: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbBoldSuperType: UILabel!
    @IBOutlet weak var lbSuperType: UILabel!
    @IBOutlet weak var lbBoldSubtypes: UILabel!
    @IBOutlet weak var lbSubTypes: UILabel!
    @IBOutlet weak var lbBoldTypes: UILabel!
    @IBOutlet weak var lbTypes: UILabel!
    @IBOutlet weak var lbBoldHP: UILabel!
    @IBOutlet weak var lbHP: UILabel!
    @IBOutlet weak var imgCard: UIImageView!
    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet weak var btnFavourite: UIButton!
    
    // MARK: - Propidades
    
    private var idCard: String?
    private var card: Card?
    private var managerConnection = CardManagerConnections()
    private var managerDB = CardManagerDB()
    private var isFavourite = false
    
    init(idCard: String){
        self.idCard = idCard
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ponemos los estilos
        loadStyles()
        // Solicitamos los datos
        loadData()
        // Comprobamos si la tenemos guardada como favorito
        checkFavourite()
    }
    
    // MARK: - Funciones privadas
    private func loadData(){
        guard let idCard = idCard else { return }
        managerConnection.getDetailCard(idCard: idCard) { cardResponse in
            self.card = cardResponse
            // Cargamos los datos en la vista
            DispatchQueue.main.async {
                self.showDataInView()
            }
        } failure: { error in
            print("Ha ocurrido un error: \(error.localizedDescription)")
        }

    }
    
    private func loadStyles(){
        // Fuentes
        lbBoldName.font = UIFont.boldSystemFont(ofSize: 20)
        lbBoldSuperType.font = UIFont.boldSystemFont(ofSize: 20)
        lbBoldSubtypes.font = UIFont.boldSystemFont(ofSize: 20)
        lbBoldTypes.font = UIFont.boldSystemFont(ofSize: 20)
        lbBoldHP.font = UIFont.boldSystemFont(ofSize: 20)
        // Textos
        lbBoldName.text = "name".localize()
        lbBoldSuperType.text = "supertype".localize()
        lbBoldSubtypes.text = "subtypes".localize()
        lbBoldTypes.text = "types".localize()
        lbBoldHP.text = "hp".localize()
        btnFavourite.setTitle("favourite".localize(), for: .normal)
    }
    
    private func showDataInView(){
        if let card = card {
            lbName.text = card.name
            lbHP.text = card.hp
            lbSuperType.text = card.supertype
            
            // Revisamos los subtipos
            if let subtypes = card.subtypes {
                
                var stringSubtypes = ""
                
                for subtype in subtypes {
                    stringSubtypes += subtype
                    if !(subtypes.last?.elementsEqual(subtype))!{
                        stringSubtypes += ", "
                    }
                }
                lbSubTypes.text = stringSubtypes
            }
            
            // Revisamos los tipos
            if let types = card.types {
                
                var stringTypes = ""
                
                for type in types {
                    stringTypes += type
                    if !(types.last?.elementsEqual(type))!{
                        stringTypes += ", "
                    }
                }
                lbTypes.text = stringTypes
            }
            
            // Ponemos la imagen
            if let imageCard = card.images?.large {
                imgCard.sd_setImage(with: URL(string: imageCard), placeholderImage: UIImage(named: "pokeball"))
            }
        }
    }
    
    private func checkFavourite(){
        guard let idCardCheck = idCard else { return }
        managerDB.getCard(idCardCheck) { cardDB in
            // Cambiamos el titulo del botón para indicar que ya es favorita
            self.changeButton(favourite: true)
        } failure: { error in
            print("Ha ocurrido un error: \(error.localizedDescription)")
        }

    }
    
    private func deleteFavourite(){
        guard let idCard = card?.idCard else { return }
        
        managerDB.deleteCard(idCard) { success in
            if success == true {
                print("Ha eliminado correctamente la tarjeta")
                self.changeButton(favourite: false)
            }
        } failure: { error in
            print("Ha ocurrido un error: \(error.localizedDescription)")
        }

    }
    
    private func addFavourite(){
        
        guard let cardSave = card else { return }
        
        managerDB.saveCard(cardSave) { success in
            if success == true {
                print("Se ha guardado como favorita")
                self.changeButton(favourite: true)
            }
        } failure: { error in
            print("Ha ocurrido un error: \(error.localizedDescription)")
        }

    }
    
    private func changeButton(favourite isFavourite: Bool){
        if isFavourite == true {
            self.btnFavourite.setTitle("is.favourite".localize(), for: .normal)
            self.isFavourite = true
        }else{
            self.btnFavourite.setTitle("favourite".localize(), for: .normal)
            self.isFavourite = false
        }
    }

    // MARK: - Acciones
    
    @IBAction func actionImage(_ sender: Any) {
        ImageViewer.show(imgCard, presentingVC: self)
    }
    
    @IBAction func actionFavourite(_ sender: Any) {
        // Miramos si es favorita o no para añadirla o eliminarla
        if isFavourite == true {
            // La eliminamos de favorita
            deleteFavourite()
        }else {
            addFavourite()
        }
    }
    

}
