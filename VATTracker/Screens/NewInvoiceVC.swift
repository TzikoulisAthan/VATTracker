//
//  NewInvoiceVC.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 7/4/23.
//

import UIKit
import CoreData

class NewInvoiceVC: UIViewController {
  
    //MARK: - Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var invoices = [Invoice]()
    var loadedInvoices = [Invoice]()
    
    //MARK: - UI Components
    let datePickerLaber = VTLabel(labelTitle: "Issuing Date:")
    let invoiceIssuerLabel = VTLabel(labelTitle: "Invoice Issuer:")
    let invoiceNumberLabel = VTLabel(labelTitle: "Invoice Number:")
    let totalAmountLabel = VTLabel(labelTitle: "Total Amount:")
    let vatAmountLabel = VTLabel(labelTitle: "VAT Amount:")
    
    let invoiceIssuerTextField = VTTextField(keyboardType: .default)
    let invoiceNumberTextField = VTTextField(keyboardType: .numberPad)
    let totalAmountTextField = VTTextField(keyboardType: .decimalPad)
    let vatAmountTextField = VTTextField(keyboardType: .decimalPad)
    
    let saveButton = VTButton(buttonTitle: "Save", color: .systemGreen)
    let cancelButton = VTButton(buttonTitle: "Clear", color: .systemGray3)
    
    var datePicker: UIDatePicker = {
        let datepicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datepicker.preferredDatePickerStyle = .automatic
        } else {
            // Fallback on earlier versions
        }
        datepicker.datePickerMode = .date
        datepicker.timeZone = .current
        return datepicker
    }()
    
    
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        createDismissKeyboardTapGesture()
        
    }
    
    
    //MARK: - Dismiss keyboard method
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    //MARK: - Button Methods
    @objc func saveButtonTapped() {
        //TODO: Refine textfield validation
        guard invoiceIssuerTextField.text?.isEmpty == false else {
            print("Fill invoiceissuer textfield!")
            return
        }
        
        
        guard invoiceNumberTextField.text?.isEmpty == false else {
            print("Fill invoicenumber textfield!")
            return
        }

        
        guard totalAmountTextField.text?.isEmpty == false else {
            print("Fill totalamount textfield!")
            return
        }
        
        
        guard vatAmountTextField.text?.isEmpty == false else {
            print("Fill vatamount textfield!")
            return
        }
        
        //TODO: Create radio button for the user to select if the invoice is income or expense.
        //      If is income then use string interpolation when adding to database "-\(income)" so that it adds the minus
        
        let newInvoice = Invoice(context: self.context)
        newInvoice.issuer = invoiceIssuerTextField.text
        newInvoice.number = invoiceNumberTextField.text
        newInvoice.totalAmount = totalAmountTextField.text
        newInvoice.vatAmount = vatAmountTextField.text
        
        invoices.append(newInvoice)
        saveInvoice()
        
    }
    
    
    @objc func cancelButtonTapped() {
        clearTextFields()
    }
    
    
    //MARK: - Functions
    private func clearTextFields() {
        let textfields = [invoiceIssuerTextField, invoiceNumberTextField,
                          totalAmountTextField, vatAmountTextField
        ]
        
        for textfield in textfields {
            textfield.text = ""
        }
        
        invoiceIssuerTextField.becomeFirstResponder()
    }
    
    
    private func saveInvoice() {
        do {
            try context.save()
            clearTextFields()
        } catch {
            print("Error saving invoice: \(error)")
        }
    }
    
    
   
    
    
    //MARK: - UI Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        let views = [invoiceIssuerLabel, invoiceNumberLabel, totalAmountLabel, vatAmountLabel, invoiceIssuerTextField, invoiceNumberTextField,
                     totalAmountTextField, vatAmountTextField, saveButton, cancelButton, datePicker, datePickerLaber
        ]
        
        for everyView in views {
            view.addSubview(everyView)
        }
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 15
        let groupPadding: CGFloat = 2
        
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            datePickerLaber.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            datePickerLaber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            datePickerLaber.widthAnchor.constraint(equalToConstant: 150),
            datePickerLaber.heightAnchor.constraint(equalToConstant: 40),
            
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            datePicker.leadingAnchor.constraint(equalTo: datePickerLaber.trailingAnchor, constant: 5),
            datePicker.widthAnchor.constraint(equalToConstant: 150),
            datePicker.heightAnchor.constraint(equalToConstant: 40),
            
            invoiceIssuerLabel.topAnchor.constraint(equalTo: datePickerLaber.bottomAnchor, constant: padding),
            invoiceIssuerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            invoiceIssuerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            invoiceIssuerLabel.heightAnchor.constraint(equalToConstant: 40),
            
            invoiceIssuerTextField.topAnchor.constraint(equalTo: invoiceIssuerLabel.bottomAnchor, constant: groupPadding),
            invoiceIssuerTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            invoiceIssuerTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            invoiceIssuerTextField.heightAnchor.constraint(equalToConstant: 40),
            
            invoiceNumberLabel.topAnchor.constraint(equalTo: invoiceIssuerTextField.bottomAnchor, constant: padding),
            invoiceNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            invoiceNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            invoiceNumberLabel.heightAnchor.constraint(equalToConstant: 40),
            
            invoiceNumberTextField.topAnchor.constraint(equalTo: invoiceNumberLabel.bottomAnchor, constant: groupPadding),
            invoiceNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            invoiceNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            invoiceNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            totalAmountLabel.topAnchor.constraint(equalTo: invoiceNumberTextField.bottomAnchor, constant: padding),
            totalAmountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            totalAmountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            totalAmountLabel.heightAnchor.constraint(equalToConstant: 40),
            
            totalAmountTextField.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor, constant: groupPadding),
            totalAmountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            totalAmountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            totalAmountTextField.heightAnchor.constraint(equalToConstant: 40),
            
            vatAmountLabel.topAnchor.constraint(equalTo: totalAmountTextField.bottomAnchor, constant: padding),
            vatAmountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            vatAmountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            vatAmountLabel.heightAnchor.constraint(equalToConstant: 40),
            
            vatAmountTextField.topAnchor.constraint(equalTo: vatAmountLabel.bottomAnchor, constant: groupPadding),
            vatAmountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            vatAmountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            vatAmountTextField.heightAnchor.constraint(equalToConstant: 40),
            
            saveButton.topAnchor.constraint(equalTo: vatAmountTextField.bottomAnchor, constant: 40),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 140),
            saveButton.heightAnchor.constraint(equalToConstant: 70),
            
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 10),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 140),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}


//MARK: - TextField delegate methods
//extension NewInvoiceVC: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        <#code#>
//    }
//}
