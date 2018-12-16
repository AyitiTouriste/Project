//
//  LoginViewController.swift
//  Ayiti_Touris
//
//  Created by Abraham Asmile on 12/1/2018 AP.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var generalError = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBAction func onSingin(_ sender: Any) {
        
        
   
    }
 
    @IBAction func onLogin(_ sender: UIButton) {
        if EmptyFieldAlert() != true {
            loginUser()
        }
    }
    
    func loginUser() {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                self.generalError = error.localizedDescription
                self.generalAlert()
            } else {
                self.performSegue(withIdentifier: "loginSegue", sender: username)
                // display view controller that needs to shown after successful login
            }
        }
    }
    
    func EmptyFieldAlert() -> Bool {
        var isFieldEmpty = false
        if usernameField.text?.isEmpty == true || passwordField.text?.isEmpty == true{
            isFieldEmpty = true
            let alertController = UIAlertController(title: "TextField Empty", message: "This Field can't be Empty.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default
                , handler: { (action) in self.loginUser()}))
            self.present(alertController, animated: true)
            
        }
        return isFieldEmpty;
    }
    
    func networkErrorAlert(){
        let alertController = UIAlertController(title: "Network Error", message: "It's Seems there is a network error. Please try again later.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: { (action) in self.loginUser()}))
        self.present(alertController, animated: true)
    }
    
    func generalAlert(){
        let alertController = UIAlertController(title: "Alert", message: self.generalError , preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in self.loginButton.isTouchInside}))
        self.present(alertController, animated: true)
    }
}
