//
//  MainVC.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 7/4/23.
//

import UIKit

class MainVC: UIViewController {
    
    let titleView = OverviewTitleVC()
    
    let stackView = UIStackView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        addTitleView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    func addTitleView() {
        addChild(titleView)
        view.addSubview(titleView.view)
        titleView.didMove(toParent: self)
        setTitleViewConstraints()
    }
    
    
//    func addToStackView() {
//        stackView.addArrangedSubview(account1.view)
//        stackView.addArrangedSubview(account2.view)
//    }
//    
//    
//    func configureStackView() {
//        view.addSubview(stackView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        
//        stackView.axis = .vertical
//        stackView.spacing = 10
//        
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: titleView.bottomLayoutGuide.bottomAnchor, constant: 20),
//            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10)
//        ])
//    }
//    
    
    func setTitleViewConstraints() {
        titleView.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.view.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
}
