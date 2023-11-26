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

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadInvoices()
    }
    
    //MARK: - Functions
    private func loadInvoices(with request: NSFetchRequest<Invoice> = Invoice.fetchRequest()) {
        
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
        
        searchBar.delegate = self
    }
    
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.standardAppearance = SetNavBarAppearance.setupNavBar(with: self.navigationController!)
        navigationController?.navigationBar.scrollEdgeAppearance = SetNavBarAppearance.setupNavBar(with: self.navigationController!)

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.placeholder = "Search for invoice issuer"
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
        
        cell.dateLabelText.text = String(dateToString(inputDate: invoiceList[indexPath.row].date!))
        
        let totalAmount = invoiceList[indexPath.row].totalAmount
        let vatAmount = invoiceList[indexPath.row].vatAmount
        let prefix = "-"
        
        if totalAmount!.hasPrefix(prefix), vatAmount!.hasPrefix(prefix) {
            cell.invoiceIssuerLabelText.text = invoiceList[indexPath.row].issuer
            cell.invoiceNumberLabelText.text = invoiceList[indexPath.row].number
            cell.totalAmountLabelText.text = String(totalAmount!.dropFirst(prefix.count))
            cell.vatAmountLabelText.text = String(vatAmount!.dropFirst(prefix.count))
            cell.totalAmountLabelText.textColor = .green
            cell.vatAmountLabelText.textColor = .green
        } else {
            cell.invoiceIssuerLabelText.text = invoiceList[indexPath.row].issuer
            cell.invoiceNumberLabelText.text = invoiceList[indexPath.row].number
            cell.totalAmountLabelText.text = "(\(invoiceList[indexPath.row].totalAmount!))"
            cell.vatAmountLabelText.text = "(\(invoiceList[indexPath.row].vatAmount!))"
            cell.totalAmountLabelText.textColor = .red
            cell.vatAmountLabelText.textColor = .red
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            context.delete(invoiceList[indexPath.row])
            invoiceList.remove(at: indexPath.row)
            
            tableView.endUpdates()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


//MARK: - SearchBar Methods
extension InvoiceListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Invoice> = Invoice.fetchRequest()
        
        guard let searchText = searchBar.text else { return }
        
        request.predicate = NSPredicate(format: "issuer CONTAINS[cd] %@", searchText)
        request.sortDescriptors = [NSSortDescriptor(key: "issuer", ascending: true)]
        
       loadInvoices(with: request)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadInvoices()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
