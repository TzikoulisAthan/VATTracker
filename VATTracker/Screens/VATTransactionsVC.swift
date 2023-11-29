//
//  VATTransactionsVC.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 28/11/23.
//

import UIKit
import CoreData

class VATTransactionsVC: UIViewController {

    //MARK: - Variables
    var paymentsList = [Payments]()
    
    //MARK: - UI Components
    let tableView = UITableView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        paymentsList = DataFunctions.loadPayments()
        
    }
    
    //MARK: - UI Setup
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 160
        
        tableView.register(VatTransactionsTableViewCell.self, forCellReuseIdentifier: VatTransactionsTableViewCell.reuseIdentifier)
    }
    
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
    
    //MARK: - Selectors

}


extension VATTransactionsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VatTransactionsTableViewCell.reuseIdentifier, for: indexPath) as! VatTransactionsTableViewCell
        
        cell.dateLabel.text = "29/12/2023"
        cell.descriptionLabel.text = paymentsList[indexPath.row].explanation
        cell.amountLabel.text = paymentsList[indexPath.row].amount

        return cell
    }
    
    
}
