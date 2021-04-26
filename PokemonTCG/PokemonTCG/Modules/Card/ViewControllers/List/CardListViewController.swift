//
//  CardListViewController.swift
//  PokemonTCG
//
//  Created by Adrián Bolaños Ríos on 24/04/2021.
//

import UIKit

final class CardListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var managerConnection = CardManagerConnections()
    var listCards: [Card] = []
    var page: Int = 1
    var isLoadingPage = true
    var otherPage = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Registramos las celdas del collection
        registerCells()
        //Obtenemos los datos
        loadData()
    }

    // MARK: - Funciones privadas
    
    private func loadData(){
        managerConnection.getListCard(page: page) { cards in
            self.processData(cards)
        } failure: { error in
            print("Ha ocurrido un error")
        }
    }
    
    private func processData(_ response: [Card]){
        self.isLoadingPage = false
        // Añadimos elemento al array
        if self.listCards.count != 0 {
            self.listCards += response
        }else{
            listCards = response
        }
        // Comprobamos si tenemos más paginas
        if response.count < 20 {
            otherPage = false
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func registerCells(){
        collectionView.register(UINib(nibName: CardCollectionViewCell.kIdentifier, bundle: nil), forCellWithReuseIdentifier: CardCollectionViewCell.kIdentifier)
    }
}

extension CardListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.kIdentifier, for: indexPath) as? CardCollectionViewCell
        if listCards.count > 0 {
            cell!.loadData(card: listCards[indexPath.row])
        }
        return cell!
    }
    
    
}

extension CardListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Vamos a ir al detalle de una carta
        if let idCard = listCards[indexPath.row].idCard {
            let controller = CardDetailViewController.init(idCard:idCard)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension CardListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 3), height: (UIScreen.main.bounds.width / 3 * 1.5))
    }
}
