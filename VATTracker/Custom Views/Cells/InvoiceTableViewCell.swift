//
//  InvoiceTableViewCell.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 13/11/23.
//

import UIKit

class InvoiceTableViewCell: UITableViewCell {
    
    //MARK: - Variables
    static let reuseIdentifier = "InvoiceTableViewCell"
    
    //MARK: - UI Components
    let dateLabel = VTIncoiceListCellLabel(fontSize: 25, text: "Date Issued: ")
    var dateLabelText = VTIncoiceListCellLabel(fontSize: 20)
    let invoiceIssuerLabel = VTIncoiceListCellLabel(fontSize: 25, text: "Invoice Issuer: ")
    var invoiceIssuerLabelText = VTIncoiceListCellLabel(fontSize: 20)
    let invoiceNumberLabel = VTIncoiceListCellLabel(fontSize: 25, text: "Invoice Number: ")
    var invoiceNumberLabelText = VTIncoiceListCellLabel(fontSize: 20)
    let totalAmountLabel = VTIncoiceListCellLabel(fontSize: 25, text: "Total Amount: ")
    var totalAmountLabelText = VTIncoiceListCellLabel(fontSize: 20)
    let vatAmountLabel = VTIncoiceListCellLabel(fontSize: 25, text: "VAT Amount: ")
    var vatAmountLabelText = VTIncoiceListCellLabel(fontSize: 20)
    
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    private func configureUI() {
        let views = [dateLabel, dateLabelText, invoiceIssuerLabel, invoiceIssuerLabelText, invoiceNumberLabel, invoiceNumberLabelText,
                     totalAmountLabel, totalAmountLabelText, vatAmountLabel, vatAmountLabelText]
        
        for everyView in views {
            self.addSubview(everyView)
        }
        
        let padding: CGFloat = 1
        let width = UIScreen.main.bounds.width
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 40),
            dateLabel.widthAnchor.constraint(equalToConstant: width / 2),
            dateLabelText.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            dateLabelText.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: padding),
            dateLabelText.heightAnchor.constraint(equalToConstant: 40),
            dateLabelText.widthAnchor.constraint(equalToConstant: width / 2),
            
            invoiceIssuerLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding),
            invoiceIssuerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            invoiceIssuerLabel.heightAnchor.constraint(equalToConstant: 40),
            invoiceIssuerLabel.widthAnchor.constraint(equalToConstant: width / 2),
            invoiceIssuerLabelText.topAnchor.constraint(equalTo: dateLabelText.bottomAnchor, constant: padding),
            invoiceIssuerLabelText.leadingAnchor.constraint(equalTo: invoiceIssuerLabel.trailingAnchor, constant: padding),
            invoiceIssuerLabelText.heightAnchor.constraint(equalToConstant: 40),
            invoiceIssuerLabelText.widthAnchor.constraint(equalToConstant: width / 2),
            
            invoiceNumberLabel.topAnchor.constraint(equalTo: invoiceIssuerLabel.bottomAnchor, constant: padding),
            invoiceNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            invoiceNumberLabel.heightAnchor.constraint(equalToConstant: 40),
            invoiceNumberLabel.widthAnchor.constraint(equalToConstant: width / 2),
            invoiceNumberLabelText.topAnchor.constraint(equalTo: invoiceIssuerLabelText.bottomAnchor, constant: padding),
            invoiceNumberLabelText.leadingAnchor.constraint(equalTo: invoiceNumberLabel.trailingAnchor, constant: padding),
            invoiceNumberLabelText.heightAnchor.constraint(equalToConstant: 40),
            invoiceNumberLabelText.widthAnchor.constraint(equalToConstant: width / 2),
            
            totalAmountLabel.topAnchor.constraint(equalTo: invoiceNumberLabel.bottomAnchor, constant: padding),
            totalAmountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            totalAmountLabel.heightAnchor.constraint(equalToConstant: 40),
            totalAmountLabel.widthAnchor.constraint(equalToConstant: width / 2),
            totalAmountLabelText.topAnchor.constraint(equalTo: invoiceNumberLabelText.bottomAnchor, constant: padding),
            totalAmountLabelText.leadingAnchor.constraint(equalTo: totalAmountLabel.trailingAnchor, constant: padding),
            totalAmountLabelText.heightAnchor.constraint(equalToConstant: 40),
            totalAmountLabelText.widthAnchor.constraint(equalToConstant: width / 2),
            
            vatAmountLabel.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor, constant: padding),
            vatAmountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            vatAmountLabel.heightAnchor.constraint(equalToConstant: 40),
            vatAmountLabel.widthAnchor.constraint(equalToConstant: width / 2),
            vatAmountLabelText.topAnchor.constraint(equalTo: totalAmountLabelText.bottomAnchor, constant: padding),
            vatAmountLabelText.leadingAnchor.constraint(equalTo: vatAmountLabel.trailingAnchor, constant: padding),
            vatAmountLabelText.heightAnchor.constraint(equalToConstant: 40),
            vatAmountLabelText.widthAnchor.constraint(equalToConstant: width / 2)
        ])
    }
    
    //MARK: - Selectors


    
}
