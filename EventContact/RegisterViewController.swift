//
//  RegisterViewController.swift
//  EventContact
//
//  Created by Princess Sampson on 9/30/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import UIKit

class RegisterViewController: ViewController {
    let store = UserStore()
    
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var firstNameTextfield: UITextField!
    @IBOutlet var lastNameTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var confirmPasswordTextfield: UITextField!
    var passwordsMatch: Bool {
        return passwordTextfield.text! == confirmPasswordTextfield.text!
    }
    
    
}

extension RegisterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyFieldsAndDisableRegisterButton()
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let emailFieldIsNotEmpty = !(emailTextfield.text?.isEmpty)!
        let firstNameFieldIsNotEmpty = !(firstNameTextfield.text?.isEmpty)!
        let lastNameFieldIsNotEmpty = !(lastNameTextfield.text?.isEmpty)!
        let passwordFieldsNotEmptyAndMatch =
            (!(passwordTextfield.text?.isEmpty)!
                && !(confirmPasswordTextfield.text?.isEmpty)!)
                && passwordsMatch
        
        
        if emailFieldIsNotEmpty && firstNameFieldIsNotEmpty && lastNameFieldIsNotEmpty && passwordFieldsNotEmptyAndMatch {
            registerButton.isEnabled = true
        }
        
        return true
    }
}


extension RegisterViewController {
    
    @IBAction func attemptRegistration(_ sender: AnyObject) {
        
        let firstName = firstNameTextfield.text!
        let lastName = lastNameTextfield.text!
        let email = emailTextfield.text!
        let password = passwordTextfield.text!
        
        let registerRequest = RegisterRequest(firstName: firstName, lastName: lastName, email: email, password: password)
        
        print(registerRequest)
        
        store.registerUser(requestBody: registerRequest) { (result) in
            switch result {
            case let .Success(user):
                let tabController = EventContactTabBarController()
                tabController.user = user
                self.show(tabController, sender: nil)
            case let .Failure(_, message):
                print("\n\n\n\nERROR MESSAGE: \n\(message)")
                self.alertUser(title: "Couldn't create account", message: message, action: "Try again")
            }
        }
        
    }
    
    
}

extension RegisterViewController {
    func alertUser(title: String, message: String, action: String) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: action, style: .default, handler: nil)
        ac.addAction(alertAction)
        
        show(ac, sender: nil)
    }
    
    func emptyFieldsAndDisableRegisterButton() {
        
        emailTextfield.text = ""
        firstNameTextfield.text = ""
        lastNameTextfield.text = ""
        passwordTextfield.text = ""
        confirmPasswordTextfield.text = ""
        registerButton.isEnabled = false
        
    }
}
