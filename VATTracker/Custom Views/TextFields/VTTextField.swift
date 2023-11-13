//
//  VTTextField.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 10/11/23.
//

import UIKit

class VTTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 10)
    }
    
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 10)
    }
    
    
    init(keyboardType: UIKeyboardType) {
        super.init(frame: .zero)
        
        self.keyboardType = keyboardType
        
        configure()
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .title3)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .next
    }
    
}
