//
//  SetNavBarAppearance.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 18/11/23.
//

import UIKit

class SetNavBarAppearance {
    
    static func setupNavBar(with navigationController: UINavigationController) -> UINavigationBarAppearance {
        //navigationItem.title = "New Invoice"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(displayP3Red: 0, green: 0.498, blue: 0.8588, alpha: 1.0)
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.isTranslucent = false
        
        return navBarAppearance
    }
    
}

