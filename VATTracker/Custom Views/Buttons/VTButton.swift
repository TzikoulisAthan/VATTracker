//
//  VTButton.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 10/11/23.
//

import UIKit

class VTButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(buttonTitle: String, color: UIColor, type: UIButton.ButtonType = .system) {
        //super.init(frame: .zero)
        self.init(type: type)
        self.setTitle(buttonTitle, for: .normal)
        self.backgroundColor = color
        self.buttonType
        configure()
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
    }
    
}
