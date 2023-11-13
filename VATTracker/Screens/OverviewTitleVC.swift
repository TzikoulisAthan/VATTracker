//
//  OverviewTitleView.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 9/4/23.
//

import UIKit

class OverviewTitleVC: UIViewController {

    let vatTitleLabel = UILabel()
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor(red: 0.2941, green: 0.5765, blue: 0.949, alpha: 1.0)
        configureUI()
        
    }
    
    
    private func configureUI() {
        configureVatTitleLabel()
        configureVatLabel()
    }
    
    
    private func configureVatTitleLabel() {
        view.addSubview(vatTitleLabel)
        vatTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        vatTitleLabel.text = "Overview of expenses and VAT"
        vatTitleLabel.font = UIFont(name: "Arial", size: 20)
        vatTitleLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            vatTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vatTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vatTitleLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    private func configureVatLabel() {
        
    }

}
