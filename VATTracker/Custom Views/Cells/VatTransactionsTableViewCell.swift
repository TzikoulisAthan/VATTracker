//
//  VTVatTransactionsTableViewCell.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 28/11/23.
//

import UIKit

class VatTransactionsTableViewCell: UITableViewCell {
    
    //MARK: - Variables
    static let reuseIdentifier = "VatTransactionsTableViewCell"

    
    //MARK: - UI Components
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        let views = [dateLabel, descriptionLabel, amountLabel]
        
        for everyView in views {
            self.addSubview(everyView)
            everyView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let padding: CGFloat = 1
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 35),
            dateLabel.widthAnchor.constraint(equalToConstant: 150),
            
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 80),

            amountLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding*5),
            amountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            amountLabel.heightAnchor.constraint(equalToConstant: 35),
            amountLabel.widthAnchor.constraint(equalToConstant: 100)

        ])
    }
    
    //MARK: - Selectors

    

 

}
