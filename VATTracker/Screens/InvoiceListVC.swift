//
//  InvoiceListVC.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 9/4/23.
//

import UIKit
import CoreData

class InvoiceListVC: UIViewController {

    //MARK: - Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var invoiceList = [Invoice]()
    
    
    //MARK: - UI Components
    let tableView = UITableView()
    let searchBar = UISearchBar()
    
   
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureUI()
        
        loadInvoices()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadInvoices()
    }
    
    //MARK: - Functions
    private func loadInvoices() {
        
        let request = Invoice.fetchRequest()
        
        do {
            invoiceList = try context.fetch(request)
        } catch {
            print("Error fetching data\(error)")
        }
        
        tableView.reloadData()
        
    }
    
    //MARK: - UI Setup
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = (UIScreen.main.bounds.height) / 3
        
        tableView.register(InvoiceTableViewCell.self, forCellReuseIdentifier: InvoiceTableViewCell.reuseIdentifier)
    }
    
    
    private func configureUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
}


//MARK: - TableView Methods
extension InvoiceListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoiceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvoiceTableViewCell.reuseIdentifier, for: indexPath) as! InvoiceTableViewCell
        //cell.dateLabelText.text = String(invoiceList[indexPath.row].date)
        cell.invoiceIssuerLabelText.text = invoiceList[indexPath.row].issuer
        cell.invoiceNumberLabelText.text = invoiceList[indexPath.row].number
        cell.totalAmountLabelText.text = invoiceList[indexPath.row].totalAmount
        cell.vatAmountLabelText.text = invoiceList[indexPath.row].vatAmount
        
        return cell
    }
    
    
}
