//
//  MainVC.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 7/4/23.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    
    //MARK: - Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var invoiceList = [Invoice]()
    
    //MARK: - UI Elements
    let titleView = OverviewTitleVC()
    let vatLabel: UILabel = {
       let label = UILabel()
        label.text = "VAT Balance"
        return label
    }()
    let vatBalanceLabel = UILabel()
    let cashLabel: UILabel = {
       let label = UILabel()
        label.text = "Cash Balance"
        return label
    }()
    let cashBalanceLabel = UILabel()
    

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        loadInvoices()
        let x = getTotalAmount()
        vatBalanceLabel.text = String(format: "%2f", x)
        let y = getTotalVatAmount()
        cashBalanceLabel.text = String(format: "%2f", y)
    }
    
    //MARK: - Functions
    private func loadInvoices() {
        
        let request = Invoice.fetchRequest()
        
        do {
            invoiceList = try context.fetch(request)
        } catch {
            print("Error fetching data\(error)")
        }
    }
    
    
    //MARK: - Data manipulation functions
    
    //TODO: make functions take date range as a parameter and calculate total amount and vat amount for those datesw
    private func getTotalAmount() -> Double {
        
        var totalAmount: Double = 0
        
        if invoiceList.count-1 >= 0 {
            for i in 0...invoiceList.count-1 {
                totalAmount += Double(invoiceList[i].totalAmount ?? "0")!
            }
        } else {
            print("Invoice list is empty")
        }
        
        
        return totalAmount
    }
    
    
    private func getTotalVatAmount() -> Double {
        var totalVatAmount: Double = 0
        
        if invoiceList.count-1 >= 0 {
            for i in 0...invoiceList.count-1 {
                totalVatAmount += Double(invoiceList[i].vatAmount ?? "0")!
            }
        } else {
            print("Invoice list is empty")
        }
        
        
        return totalVatAmount
    }
    
    //MARK: - UI Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        addTitleView()

    }
    
    
    private func addTitleView() {
        addChild(titleView)
        view.addSubview(titleView.view)
        titleView.didMove(toParent: self)
        setConstraints()
    }
    
    private func setConstraints() {
        let views  = [vatLabel, vatBalanceLabel, cashLabel, cashBalanceLabel]
        
        for everyView in views {
            view.addSubview(everyView)
            everyView.translatesAutoresizingMaskIntoConstraints = false
        }
        titleView.view.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            titleView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.view.heightAnchor.constraint(equalToConstant: 150),
            
            vatLabel.topAnchor.constraint(equalTo: titleView.view.bottomAnchor, constant: padding),
            vatLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vatLabel.heightAnchor.constraint(equalToConstant: 50),
            
            vatBalanceLabel.topAnchor.constraint(equalTo: vatLabel.bottomAnchor, constant: padding),
            vatBalanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vatBalanceLabel.heightAnchor.constraint(equalToConstant: 50),
            
            cashLabel.topAnchor.constraint(equalTo: vatBalanceLabel.bottomAnchor, constant: padding),
            cashLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cashLabel.heightAnchor.constraint(equalToConstant: 50),
            
            cashBalanceLabel.topAnchor.constraint(equalTo: cashLabel.bottomAnchor, constant: padding),
            cashBalanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cashBalanceLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
