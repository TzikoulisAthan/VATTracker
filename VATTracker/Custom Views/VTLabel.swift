//
//  VTLabel.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 10/11/23.
//

import UIKit

class VTLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(labelTitle: String) {
        super.init(frame: .zero)
        self.text = labelTitle
        
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
