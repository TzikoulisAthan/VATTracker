//
//  VTAlertVC.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 27/11/23.
//

import UIKit

class VTAlertVC: UIViewController {
    
    //MARK: - UI Components
    let containerView = UIView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New VAT payment"
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    let descriptionTextField: UITextField = {
        let textField = VTTextField()
        textField.placeholder = "Description"
        textField.textAlignment = .left
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        return textField
    }()
    
    let vatAmountTextField: UITextField = {
        let textField = VTTextField()
        textField.placeholder = "Amount"
        textField.textAlignment = .left
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        return textField
    }()
    
    let actionButton = VTButton(buttonTitle: "Save", color: .systemGreen, type: .system)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        configureContainerView()
        setupUI()
    }
    
    //MARK: - Initializers
    init(alertTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.titleLabel.text = alertTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 270)
        ])
    }
    
    
    private func setupUI() {
        let views = [titleLabel, descriptionTextField, vatAmountTextField, actionButton]
        
        for everyView in views {
            containerView.addSubview(everyView)
            everyView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        actionButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            descriptionTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            descriptionTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            descriptionTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 50),
            
            vatAmountTextField.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: padding),
            vatAmountTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            vatAmountTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            vatAmountTextField.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.topAnchor.constraint(equalTo: vatAmountTextField.bottomAnchor, constant: padding),
            actionButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 100),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - Selectors
    @objc func saveButtonTapped() {
        dismiss(animated: true)
    }
    
 
}
