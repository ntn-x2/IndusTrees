//
//  ViewController.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    fileprivate static let logoMinY: CGFloat = 80
    
    @IBOutlet weak var viewLogo: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        self.configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.animateView()
    }
    
    @IBAction func loginDidTap(_ sender: UIButton) {
        let email = self.usernameTextField.text!
        
        guard let account = Mocks.account(withEmail: email) else {
            print("Could not find an account for: \(email)")
            return
        }
        
        if (Mocks.projectManagers.map { $0.account }.contains { $0.bid == account.bid }) {
            
            self.performSegue(withIdentifier: "showProjects", sender: nil)
        }
        
        if (Mocks.teamLeaders.map { $0.account }.contains { $0.bid == account.bid }) {
            
            self.performSegue(withIdentifier: "showProjects", sender: nil)
        }
        
        if (Mocks.employees.map { $0.account }.contains { $0.bid == account.bid }) {
            
            self.performSegue(withIdentifier: "showMenu", sender: nil)
        }
    }
    
    private func configure() {
        self.viewLogo.center = self.view.center
        self.usernameTextField.tintColor = .white
        self.passwordTextField.tintColor = .white
    }
    
    private func animateView() {
    
        UIView.animate(withDuration: 1, delay: 0.15, options: .curveEaseIn, animations: {
            
            let logoScaledWidth: CGFloat = self.viewLogo.frame.width * 3/4

            self.viewLogo.bounds.size = CGSize(width: logoScaledWidth, height: logoScaledWidth)
            self.viewLogo.center.y = (logoScaledWidth / 2) + LoginController.logoMinY
        }, completion: { _ in
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                
                self.usernameTextField.alpha = 1
                self.passwordTextField.alpha = 1
                self.loginButton.alpha = 1
            }, completion: nil)
        })
    }
    
    
}

extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField === self.passwordTextField {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
