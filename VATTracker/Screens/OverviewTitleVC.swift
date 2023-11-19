//
//  OverviewTitleView.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 9/4/23.
//

import UIKit

class OverviewTitleVC: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var invoiceList = [Invoice]()
    
    let vatTitleLabel = UILabel()
    
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor(red: 0.2941, green: 0.5765, blue: 0.949, alpha: 1.0)
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadInvoices()
        let cashBalance = getTotalAmount()
        let incomeString = String(format: "%.2f", cashBalance.income)
        let expensesString = String(format: "%.2f", cashBalance.expenses)
        vatTitleLabel.text = incomeString
        
//        let vatBalance = getTotalVatAmount()
//        let absoluteVatBalance = abs(vatBalance)
//        let vatBalanceStrin = String(format: "%.2f", vatBalance)
//        vatTitleLabel.text = vatBalanceStrin
//        
//        if vatBalance < 0 {
//            vatBalanceLabel.text = "Output VAT: \(absoluteVatBalance)"
//        } else {
//            vatBalanceLabel.text = "Input VAT: \(absoluteVatBalance)"
//        }
    }

    
    private func loadInvoices() {
        
        let request = Invoice.fetchRequest()
        
        do {
            invoiceList = try context.fetch(request)
        } catch {
            print("Error fetching data\(error)")
        }
    }
    
    
    private func getTotalAmount() -> (income: Double, expenses: Double) {
        
        var expenses: Double = 0
        var income: Double = 0
        
        if invoiceList.count-1 >= 0 {
            for i in 0...invoiceList.count-1 {
                if Double(invoiceList[i].totalAmount!)! < 0 {
                    income += Double(invoiceList[i].totalAmount ?? "0")!
                } else {
                    expenses += Double(invoiceList[i].totalAmount ?? "0")!
                }
            }
        } else {
            print("Invoice list is empty")
        }
        
        
        return (abs(income), expenses)
    }
    
    private func configureUI() {
        configureVatTitleLabel()
        configureVatLabel()
    }
    
    
    private func configureVatTitleLabel() {
        view.addSubview(vatTitleLabel)
        vatTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        vatTitleLabel.text = "asfasf"
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
