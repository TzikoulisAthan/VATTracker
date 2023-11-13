//
//  OverviewTitleView.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 9/4/23.
//

import UIKit

class OverviewTitleView: UIView {

    let vatTitleLabel = UILabel()
    var vatLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        view.backgroundColor = UIColor(
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   

}
