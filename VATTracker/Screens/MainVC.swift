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
    let cashBalanceView = CashBalanceViewVC()
    let vatBalanceView = VatBalanceViewVC()
    
    let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = 30
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        return stackview
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
        
        invoiceList = DataFunctions.loadInvoices()
        let cashBalance = DataFunctions.getTotalAmount(list: invoiceList)
        let incomeString = String(format: "%.2f", cashBalance.income)
        let expensesString = String(format: "%.2f", cashBalance.expenses)
        cash = incomeString
        cashBalanceLabel.text = "Income / Expenses: \(incomeString) / \(expensesString)"
        
        
        let vatBalance = DataFunctions.getTotalVatAmount(list: invoiceList)
        let absoluteVatBalance = abs(vatBalance)
        let vatBalanceStrin = String(format: "%.2f", vatBalance)
        
        if vatBalance < 0 {
            vatBalanceLabel.text = "Output VAT: \(absoluteVatBalance)"
        } else {
            vatBalanceLabel.text = "Input VAT: \(absoluteVatBalance)"
        }
        
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
        
        let childViews = [cashBalanceView, vatBalanceView]
        
        for everyView in childViews {
            addChild(everyView)
            stackView.addSubview(everyView.view)
            view.addSubview(stackView)
            everyView.didMove(toParent: self)
        }
        
        setConstraints()
    }
    
    private func setConstraints() {
//        let views  = [vatBalanceLabel, cashLabel, cashBalanceLabel]
//        
//        for everyView in views {
//            view.addSubview(everyView)
//            everyView.translatesAutoresizingMaskIntoConstraints = false
//        }
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(cashBalanceView.view)
        stackView.addArrangedSubview(vatBalanceView.view)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        cashBalanceView.view.translatesAutoresizingMaskIntoConstraints = false
        cashBalanceView.view.layer.cornerRadius = 25
        cashBalanceView.view.alpha = 0.5
        
        vatBalanceView.view.translatesAutoresizingMaskIntoConstraints = false
        vatBalanceView.view.layer.cornerRadius = 25
        vatBalanceView.view.alpha = 0.5
    

        
        let padding: CGFloat = 20
        let titleViewPadding: CGFloat = 50
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
//            cashBalanceView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
//            cashBalanceView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: titleViewPadding),
//            cashBalanceView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -titleViewPadding),
//            cashBalanceView.view.heightAnchor.constraint(equalToConstant: 100),
//            
//            vatBalanceView.view.topAnchor.constraint(equalTo: cashBalanceView.view.bottomAnchor, constant: padding),
//            vatBalanceView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: titleViewPadding),
//            vatBalanceView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -titleViewPadding),
//            vatBalanceView.view.heightAnchor.constraint(equalToConstant: 100),
            
//            vatBalanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
//            vatBalanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            vatBalanceLabel.heightAnchor.constraint(equalToConstant: 50),
//            
//            cashLabel.topAnchor.constraint(equalTo: vatBalanceLabel.bottomAnchor, constant: padding),
//            cashLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            cashLabel.heightAnchor.constraint(equalToConstant: 50),
//            
//            cashBalanceLabel.topAnchor.constraint(equalTo: cashLabel.bottomAnchor, constant: padding),
//            cashBalanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            cashBalanceLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
