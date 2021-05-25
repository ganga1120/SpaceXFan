//
//  SignInViewController.swift
//  SpaceXFan
//
//  Created by ggajulapati on 25/05/21.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    let signInViewModel =  SignInViewModel()
    
    lazy var loader : LoaderView = {
        let viewModel = LoaderView()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func canelBtnButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        
        guard let emailValue = self.emailTextField.text, !emailValue.isEmpty,
              let passwordValue = self.passwordTextField.text, !passwordValue.isEmpty else {
            self.showAlert(title: "", message: Constants.Alert.alertMessaageAllfieldsrequired)
            return
        }
        
        if signInViewModel.valdiateEmail(emailAddress: emailTextField.text!) {
            
            loader.show(in: self.view)
            
            signInViewModel.handleLoginTapped(emailAddress: emailTextField.text!, password: passwordTextField.text!) { (isLoign, error) in
                
                DispatchQueue.main.async { [weak self] in
                    self?.loader.dismiss()
                    if isLoign {
                        self?.displayAlerMsg()
                    } else {
                        if let error = error {
                            self?.showAlert(title: "", message: error.localizedDescription)
                        }
                    }
                }
                
            }
        } else {
            self.showAlert(title: "", message: Constants.Alert.alertMessaageValidEmail)
        }
        
    }
    
    private func displayAlerMsg() {
        
        let alert = UIAlertController(title: "", message: Constants.Alert.alertMessaagelogin, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }))
    }
    
}


extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
