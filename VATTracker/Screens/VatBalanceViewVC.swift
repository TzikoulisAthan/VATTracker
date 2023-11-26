//
//  VatBalanceViewVC.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 24/11/23.
//

import UIKit

class VatBalanceViewVC: UIViewController {
    
    //MARK: - Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var invoiceList = [Invoice]()
    
    //MARK: - UI Components
    let vatStatusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Current VAT status: "
        label.textColor = .white
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Output"
        return label
    }()
    
    let vatLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.text = "VAT Amount: "
        return label
    }()
    let vatAmountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calculateVat()
    }
    
    //MARK: - Functions
    
    private func calculateVat() {
        
        invoiceList = DataFunctions.loadInvoices()
        let vatBalance = DataFunctions.getTotalVatAmount(list: invoiceList)
        let absoluteVatBalance = abs(vatBalance)
        let vatBalanceString = String(format: "%.2f", vatBalance)
        vatAmountLabel.text = vatBalanceString
        
        if vatBalance < 0 {
            statusLabel.text = "Output"
        } else {
            statusLabel.text = "Input"
        }
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        let views = [vatStatusLabel, statusLabel, vatLabel, vatAmountLabel]
        
        for everyView in views {
            view.addSubview(everyView)
            everyView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.backgroundColor = UIColor(red: 0.2941, green: 0.5765, blue: 0.949, alpha: 0.7)
        
        let padding: CGFloat = 10
        let linePadding: CGFloat = 30
        let labelWidth = view.frame.size.width
        let labelHeight: CGFloat = 50
        
        NSLayoutConstraint.activate([
            vatStatusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            vatStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            vatStatusLabel.widthAnchor.constraint(equalToConstant: labelWidth/2),
            vatStatusLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            statusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            statusLabel.widthAnchor.constraint(equalToConstant: labelWidth/2),
            statusLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            vatLabel.topAnchor.constraint(equalTo: vatStatusLabel.bottomAnchor, constant: padding),
            vatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            vatLabel.widthAnchor.constraint(equalToConstant: labelWidth/2),
            vatLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            vatAmountLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: padding),
            vatAmountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            vatAmountLabel.widthAnchor.constraint(equalToConstant: labelWidth/2),
            vatAmountLabel.heightAnchor.constraint(equalToConstant: labelHeight),
        ])
    }
    
}
