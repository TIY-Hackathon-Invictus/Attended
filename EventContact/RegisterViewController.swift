//
//  RegisterViewController.swift
//  EventContact
//
//  Created by Princess Sampson on 9/30/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import UIKit

class RegisterViewController: ViewController {
    
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
        
        // Do any additional setup after loading the view.
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}


extension RegisterViewController {
    
    @IBAction func attemptRegistration(_ sender: AnyObject) {
        
        guard passwordsMatch else {
            return
        }
        
        let firstName = firstNameTextfield.text!
        let lastName = lastNameTextfield.text!
        let email = emailTextfield.text!
        let password = passwordTextfield.text!
        
        let registerRequest = RegisterRequest(firstName: firstName, lastName: lastName, email: email, password: password)
        
//        store.loginUser(requestBody: loginRequest) { (result) in
//            switch result {
//            case .Success(_):
//                let tabController = EventContactTabBarController()
//                tabController.user = self.store.user
//                self.show(tabController, sender: nil)
//            case let .Failure(error):
//                print("rekt")
//                self.alertUser(title: "Couldn't login", message: error.localizedDescription, action: "Try again")
//            }
//        }
        
    }
    
    
}

extension RegisterViewController {
    func alertUser(title: String, message: String, action: String) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: action, style: .default, handler: nil)
        ac.addAction(alertAction)
        
        show(ac, sender: nil)
    }
}
