//
//  LoginViewController.swift
//  MoneyKeeper
//
//  Created by Артём on 29.01.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let user = User.getUserData()
    
    //MARK: - @IB Outlets
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = 10
        
    }
    
    //MARK: - Override Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - Private Methods
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            textField?.text = ""
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    //MARK: - @IB Actions
    @IBAction func logInButtonPressed() {
        
        guard loginTextField.text == user.login, passwordTextField.text == user.password else {
            showAlert(
                title: "Invalid login or password!",
                message: "Please, enter correct login and password",
                textField: passwordTextField
            )
            return
        }
    }
    
    @IBAction func forgotRegisterData(_ sender: UIButton) {
        sender.tag == 0
        ? showAlert(title: "Oooops! 😉", message: "Your login is \(user.login)!")
        : showAlert(title: "Oooops! 😌", message: "Your password is \(user.password)!")
    }
}
    
    
    
