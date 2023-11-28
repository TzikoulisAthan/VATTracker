//
//  OverviewTitleView.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 9/4/23.
//

import UIKit

class CashBalanceViewVC: UIViewController {
    
    //MARK: - Variables
    var invoiceList = [Invoice]()
    
    //MARK: - UI Components
    
    let incomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Income amount: "
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    
    let incomeAmountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let expensesLabel: UILabel = {
        let label = UILabel()
        label.text = "Expenses amount: "
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    
    let expensesAmountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "2412"
        return label
    }()
    
    let cashBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Cash balance amount: "
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    
    let cashBalanceAmountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "2412"
        return label
    }()
    
    let lineSeparatorView: UIView = {
        let line = UIView()
        line.layer.borderWidth = 5
        line.layer.borderColor = UIColor.white.cgColor
        
        return line
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        invoiceList = DataFunctions.loadInvoices()
        let cashBalance = DataFunctions.getTotalAmount(list: invoiceList)
        let incomeString = String(format: "%.2f", cashBalance.income)
        let expensesString = String(format: "%.2f", cashBalance.expenses)
        incomeAmountLabel.text = incomeString
        expensesAmountLabel.text = expensesString
        var incomeToExpensesBalance = cashBalance.income - cashBalance.expenses
        cashBalanceAmountLabel.text = String(format: "%.2f", incomeToExpensesBalance)
    
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        
        let views = [incomeLabel, incomeAmountLabel, expensesLabel, expensesAmountLabel, cashBalanceLabel, cashBalanceAmountLabel, lineSeparatorView]
        
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
            cashBalanceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            cashBalanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            cashBalanceLabel.widthAnchor.constraint(equalToConstant: labelWidth/2),
            cashBalanceLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            cashBalanceAmountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            cashBalanceAmountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            cashBalanceAmountLabel.widthAnchor.constraint(equalToConstant: labelWidth/2),
            cashBalanceAmountLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            incomeLabel.topAnchor.constraint(equalTo: cashBalanceLabel.bottomAnchor, constant: linePadding),
            incomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            incomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            incomeLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            incomeAmountLabel.topAnchor.constraint(equalTo: cashBalanceAmountLabel.bottomAnchor, constant: linePadding),
            incomeAmountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            incomeAmountLabel.widthAnchor.constraint(equalToConstant: labelWidth/2),
            incomeAmountLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            expensesLabel.topAnchor.constraint(equalTo: incomeLabel.bottomAnchor, constant: linePadding),
            expensesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            expensesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            expensesLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            expensesAmountLabel.topAnchor.constraint(equalTo: incomeAmountLabel.bottomAnchor, constant: linePadding),
            expensesAmountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            expensesAmountLabel.widthAnchor.constraint(equalToConstant: labelWidth/2),
            expensesAmountLabel.heightAnchor.constraint(equalToConstant: labelHeight),
        ])
    }

}
