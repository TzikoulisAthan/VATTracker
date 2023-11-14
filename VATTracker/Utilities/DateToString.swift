//
//  DateToString.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 14/11/23.
//


import Foundation

func dateToString(inputDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    
    let date = formatter.string(from: inputDate)
    
    return date
}

