//
//  VTIncoiceListCellLabel.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 13/11/23.
//

import UIKit

class VTIncoiceListCellLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(fontSize: CGFloat, text: String = "") {
        super.init(frame: .zero)
        self.font = UIFont(name: "Arial", size: fontSize)
        self.text = text
        
        configure()
    }
    
    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
