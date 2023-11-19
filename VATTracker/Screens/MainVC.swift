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
    var cash = String()

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadInvoices()
        let cashBalance = getTotalAmount()
        let incomeString = String(format: "%.2f", cashBalance.income)
        let expensesString = String(format: "%.2f", cashBalance.expenses)
        cash = incomeString
        //OverviewTitleVC(vatData: incomeString)
        cashBalanceLabel.text = "Income / Expenses: \(incomeString) / \(expensesString)"
        
        
        let vatBalance = getTotalVatAmount()
        let absoluteVatBalance = abs(vatBalance)
        let vatBalanceStrin = String(format: "%.2f", vatBalance)
        
        if vatBalance < 0 {
            vatBalanceLabel.text = "Output VAT: \(absoluteVatBalance)"
        } else {
            vatBalanceLabel.text = "Input VAT: \(absoluteVatBalance)"
        }
        
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
    
    //TODO: make functions take date range as a parameter and calculate total amount and vat amount for those dates periods
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
    
    //TODO: Work on UI 
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.standardAppearance = SetNavBarAppearance.setupNavBar(with: self.navigationController!)
        navigationController?.navigationBar.scrollEdgeAppearance = SetNavBarAppearance.setupNavBar(with: self.navigationController!)
        addTitleView()
        setConstraints()
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
        
        titleView.view.layer.cornerRadius = 10
        vatLabel.layer.backgroundColor = CGColor(red: 0.34, green: 0.67, blue: 0.12, alpha: 1)
        vatLabel.layer.bounds = CGRect(x: 1500, y: 150, width: 150, height: 150)
        
        vatLabel.shadowOffset = CGSize(width: 10, height: 50)
        vatLabel.shadowColor = .red
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            titleView.view.topAnchor.constraint(equalTo: cashBalanceLabel.bottomAnchor, constant: padding),
            titleView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.view.heightAnchor.constraint(equalToConstant: 150),
            
            vatLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
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
