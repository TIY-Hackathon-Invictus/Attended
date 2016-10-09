//
//  LoginViewController.swift
//  EventContact
//
//  Created by Princess Sampson on 9/30/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import UIKit

class LoginViewController: ViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    fileprivate let store = UserStore()
    
}

extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loginButton.isEnabled = false
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == passwordTextField {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let emailFieldIsNotEmpty = !(emailTextfield.text?.isEmpty)!
        let passwordFieldIsNotEmpty = !(passwordTextField.text?.isEmpty)!
        
        if emailFieldIsNotEmpty && passwordFieldIsNotEmpty {
            loginButton.isEnabled = true
        }
        
        return true
    }
    
}

extension LoginViewController {
    @IBAction func attemptLogin(_ sender: AnyObject) {
        
        let email = emailTextfield.text!
        let password = passwordTextField.text!
        
        let privateQueue = OperationQueue()
        
        privateQueue.addOperation {
            let loginRequest = LoginRequest(email: email, password: password)
            
            self.store.loginUser(requestBody: loginRequest) { (result) in
                
                print("\n\n\n\n\(result)")
                
                switch result {
                case let .Success(user):
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    let navController = storyboard.instantiateViewController(withIdentifier: "NavController") as! UINavigationController
                    let eventsController = navController.topViewController as! EventsTableViewController
                    eventsController.currentUser = user
                    
                    self.show(navController, sender: nil)
                case let .Failure(_, message):
                    let ac = UIAlertController(title: "Couldn't login", message: message, preferredStyle: .alert)
                    
                    let alertAction = UIAlertAction(title: "Try again", style: .default, handler: nil)
                    ac.addAction(alertAction)
                    
                    OperationQueue.main.addOperation {
                        self.present(ac, animated: true) {
                            self.clearFieldsAndDisableLoginButton()
                        }
                    }
                }
            }
            
        }
    }
    
}

extension LoginViewController {
    
    fileprivate func clearFieldsAndDisableLoginButton() {
        emailTextfield.text = ""
        passwordTextField.text = ""
        loginButton.isEnabled = false
        
    }
}
