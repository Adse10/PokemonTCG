//
//  CardSetListViewController.swift
//  PokemonTCG
//
//  Created by Adrián Bolaños Ríos on 26/04/2021.
//

import UIKit

final class CardSetListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Propiedades
    
    var managerConnection =  CardSetManagerConnections()
    var page = 1
    var listSets: [CardSet] = []
    var isLoadingPage = true
    var otherPage = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Registramos celdas
        registersCells()
        // Llamamos al ws
        loadData()
    }
    
    // MARK: - Métodos privados
    private func registersCells(){
        tableView.register(UINib(nibName: CardSetTableViewCell.kIdentifier, bundle: nil), forCellReuseIdentifier: CardSetTableViewCell.kIdentifier)
    }
    
    private func loadData(){
        managerConnection.getAllSet(page: page) { response in
            self.processData(response)
        } failure: { error in
            self.isLoadingPage = false
            self.otherPage = false
            print("Ha ocurrido un error: \(error.localizedDescription)")
        }

    }
    
    private func processData(_ response: [CardSet]){
        self.isLoadingPage = false
        // Añadimos elemento al array
        if self.listSets.count != 0 {
            self.listSets += response
        }else{
            listSets = response
        }
        // Comprobamos si tenemos más paginas
        if response.count < 20 {
            otherPage = false
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CardSetListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let idSet = listSets[indexPath.row].idSet {
            let controller = CardSetDetailViewController.init(idSet: idSet)
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
}

extension CardSetListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardSetTableViewCell.kIdentifier, for: indexPath) as? CardSetTableViewCell
        if listSets.count > 0 {
            cell!.loadData(cardSet: listSets[indexPath.row])
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
