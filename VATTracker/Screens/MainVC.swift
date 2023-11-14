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
    let stackView = UIStackView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        addTitleView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        loadInvoices()
        let x = getTotalAmount()
        print(x)
        let y = getTotalVatAmount()
        print(y)
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
    private func getTotalAmount() -> Double {
        
        var totalAmount: Double = 0
        
        for i in 0...invoiceList.count-1 {
            totalAmount += Double(invoiceList[i].totalAmount ?? "0")!
        }
        
        return totalAmount
    }
    
    
    private func getTotalVatAmount() -> Double {
        var totalVatAmount: Double = 0
        
        for i in 0...invoiceList.count-1 {
            totalVatAmount += Double(invoiceList[i].vatAmount ?? "0")!
        }
        
        return totalVatAmount
    }
    
    //MARK: - UI Methods
    func addTitleView() {
        addChild(titleView)
        view.addSubview(titleView.view)
        titleView.didMove(toParent: self)
        setTitleViewConstraints()
    }
    
    func setTitleViewConstraints() {
        titleView.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.view.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
}
