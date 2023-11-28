//
//  VatBalanceViewVC.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 24/11/23.
//

import UIKit

class VatBalanceViewVC: UIViewController {
    
    //MARK: - Variables
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
    
    let payVatButton: UIButton = {
        let button = VTButton(buttonTitle: "Pay VAT", color: .systemGreen, type: .system)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.addTarget(self, action: #selector(payVatButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let receiveVatButton: UIButton = {
        let button = VTButton(buttonTitle: "Receive VAT", color: .systemBlue, type: .system)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.addTarget(self, action: #selector(receiveVatButtonPressed), for: .touchUpInside)
        return button
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
        
        //TODO: Dispatchqueue here?
        invoiceList = DataFunctions.loadInvoices()
        let vatBalance = DataFunctions.getTotalVatAmount(list: invoiceList)
        let absoluteVatBalance = abs(vatBalance)
        let vatBalanceString = String(format: "%.2f", vatBalance)
        vatAmountLabel.text = vatBalanceString
        
        if vatBalance < 0 {
            statusLabel.text = "Input > Output"
        } else {
            statusLabel.text = "Output > Input"
        }
    }
    
    
    //MARK: - Selectors
    
    @objc func payVatButtonPressed() {
        
        invoiceList = DataFunctions.loadInvoices()
        let currentVatAmount = DataFunctions.getTotalVatAmount(list: invoiceList)
        
        if currentVatAmount > 0 {
            let alert = UIAlertController(title: "New VAT payment", message: "\nYou are about to make a new VAT payment.\n\nAction is irreversible.\n\nAre you sure?",
                                          preferredStyle: .alert)
            
            
            let alertAction = UIAlertAction(title: "Pay", style: .default) { action in
                DispatchQueue.main.async {
                    let alert = VTAlertVC(alertTitle: "Make VAT payment")
                    alert.isPayment = true
                    alert.vatAmountTextField.text = String(currentVatAmount)
                    alert.modalPresentationStyle = .overFullScreen
                    alert.modalTransitionStyle = .crossDissolve
                    self.present(alert, animated: true)
                }
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(alertAction)
            present(alert, animated: true)
            
        } else {
            let alert = UIAlertController(title: "No payment needed!", message: "Cannot make payment! Input VAT is greater than output VAT.", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Ok", style: .cancel)
            
            alert.addAction(alertAction)
            present(alert, animated: true)
        }
        
    }
    
    
    @objc func receiveVatButtonPressed() {
        invoiceList = DataFunctions.loadInvoices()
        let currentVatAmount = DataFunctions.getTotalVatAmount(list: invoiceList)
        
        if currentVatAmount < 0 {
            let alert = UIAlertController(title: "New VAT payment", message: "\nYou are about to receive a new VAT payment.\n\nAction is irreversible.\n\nAre you sure?",
                                          preferredStyle: .alert)
            
            
            let alertAction = UIAlertAction(title: "Receive", style: .default) { action in
                DispatchQueue.main.async {
                    let alert = VTAlertVC(alertTitle: "Receive VAT payment")
                    alert.isPayment = false
                    alert.vatAmountTextField.text = String(currentVatAmount)
                    alert.modalPresentationStyle = .overFullScreen
                    alert.modalTransitionStyle = .crossDissolve
                    self.present(alert, animated: true)
                }
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(alertAction)
            present(alert, animated: true)
            
        } else {
            let alert = UIAlertController(title: "Cannot receive!", message: "Cannot receive payment! Output VAT is greater than input VAT.", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Ok", style: .cancel)
            
            alert.addAction(alertAction)
            present(alert, animated: true)
        }
        
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        let views = [vatStatusLabel, statusLabel, vatLabel, vatAmountLabel, payVatButton, receiveVatButton]
        
        for everyView in views {
            view.addSubview(everyView)
            everyView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.backgroundColor = UIColor(red: 0.2941, green: 0.5765, blue: 0.949, alpha: 0.7)
        
        let padding: CGFloat = 10
        let labelWidth = view.frame.size.width
        let labelHeight: CGFloat = 50
        let containerWidth: CGFloat = view.frame.size.width
        
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
            
            payVatButton.topAnchor.constraint(equalTo: vatAmountLabel.bottomAnchor, constant: padding*2),
            payVatButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            payVatButton.widthAnchor.constraint(equalToConstant: containerWidth/3),
            payVatButton.heightAnchor.constraint(equalToConstant: 50),
            
            receiveVatButton.topAnchor.constraint(equalTo: vatAmountLabel.bottomAnchor, constant: padding*2),
            receiveVatButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            receiveVatButton.widthAnchor.constraint(equalToConstant: containerWidth/3),
            receiveVatButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}



