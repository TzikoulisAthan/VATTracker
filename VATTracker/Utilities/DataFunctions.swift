//
//  DataFunctions.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 22/11/23.
//

import UIKit
import CoreData

struct DataFunctions {
    
    //MARK: - Invoice table Methods
    
    static func loadInvoices() -> [Invoice] {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        var invoiceList: [Invoice] = []
        
        
        let request = Invoice.fetchRequest()
        
        do {
            invoiceList = try context.fetch(request)
        } catch {
            print("Error fetching data\(error)")
        }
        
        return invoiceList
    }
    
    
    static func getTotalAmount(list: [Invoice]) -> (income: Double, expenses: Double) {
        
        var expenses: Double = 0
        var income: Double = 0
        
        if list.count-1 >= 0 {
            for i in 0...list.count-1 {
                if Double(list[i].totalAmount!)! < 0 {
                    income += Double(list[i].totalAmount ?? "0")!
                } else {
                    expenses += Double(list[i].totalAmount ?? "0")!
                }
            }
        } else {
            print("Invoice list is empty")
        }
        
        
        return (abs(income), expenses)
    }
    
    
    static func getTotalVatAmount(list: [Invoice]) -> Double {
        var totalVatAmount: Double = 0
        
        if list.count-1 >= 0 {
            for i in 0...list.count-1 {
                totalVatAmount += Double(list[i].vatAmount ?? "0")!
            }
        } else {
            print("Invoice list is empty")
        }
        
        
        return totalVatAmount
    }
    
    
    //MARK: - Payment table Methods
    
    static func loadPayments() -> [Payments] {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        var paymentsList: [Payments] = []
        
        
        let request = Payments.fetchRequest()
        
        do {
            paymentsList = try context.fetch(request)
        } catch {
            print("Error fetching data\(error)")
        }
        
        return paymentsList
    }
    
    static func getTotalPaymentsAmount(list: [Payments]) -> Double {
        var totalPaymentsAmount: Double = 0
        
        if list.count-1 >= 0 {
            for i in 0...list.count-1 {
                totalPaymentsAmount += Double(list[i].amount ?? "0")!
            }
        } else {
            print("Invoice list is empty")
        }
        
        return totalPaymentsAmount
    }
    
}
