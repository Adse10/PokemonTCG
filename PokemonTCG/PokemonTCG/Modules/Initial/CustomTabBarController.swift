//
//  CustomTabBarController.swift
//  PokemonTCG
//
//  Created by Adrián Bolaños Ríos on 24/04/2021.
//

import UIKit

class CustomTabBarController: UITabBarController {

    // Creamos dos propiedades perezosas (lazy var) para cada uno de los controladores que tenemos
    lazy var allCardTabBar: UIViewController = {
        let allCardTab = CardListViewController()
        let navigationController = UINavigationController(rootViewController: allCardTab)
        let tabBarItem = UITabBarItem(title: "all.cards".localize(), image: nil, selectedImage: nil)
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }()
    
    // Tab de sets
    lazy var setTabBar: UIViewController = {
        let setTab = CardSetListViewController()
        let navigationController = UINavigationController(rootViewController: setTab)
        let tabBarItem = UITabBarItem(title: "all.sets".localize(), image: nil, selectedImage: nil)
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewControllers = [allCardTabBar, setTabBar]
    }

}
