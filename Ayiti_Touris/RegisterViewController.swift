//
//  RegisterViewController.swift
//  Ayiti_Touris
//
//  Created by Abraham Asmile on 12/1/2018 AP.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmpasswordField: UITextField!
 
    @IBOutlet weak var registerButton: UIButton!
    
    var generalError = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerUser() {
        // create a user object
        let newUser = PFUser()
        
        // set properties to user
        newUser.username = usernameField.text
        newUser.password = passwordField.text

        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                self.generalError = error.localizedDescription
                self.generalAlert()
            } else {
                let sms = "User Registered successfully Go back to the Login Page to log in";
                print(sms)
                self.generalError = sms
                self.generalAlert()
                self.clearField()
            }
        }
        //check if passwords match
        if (passwordField != confirmpasswordField ){
            // Display an alert
            return;
        }
    }
    
    func clearField(){
        usernameField.text = ""
       // emailField.text = ""
        passwordField.text = ""
        confirmpasswordField.text = ""
    }
    

        
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        if EmptyFieldAlert() != true {
            registerUser()
            
            
            
            
            
        }
    }
    
    
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    func EmptyFieldAlert() -> Bool {
        var isFieldEmpty = false
        if usernameField.text?.isEmpty == true || passwordField.text?.isEmpty == true || confirmpasswordField.text?.isEmpty == true {
            isFieldEmpty = true
            let alertController = UIAlertController(title: "TextField Empty", message: "This Field can't be Empty.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default
                , handler: { (action) in self.registerUser()}))
            self.present(alertController, animated: true)
            
        }
        return isFieldEmpty;
    }
    
    func generalAlert(){
        let alertController = UIAlertController(title: "Alert", message: self.generalError , preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in self.registerButton.isTouchInside}))
        self.present(alertController, animated: true)
    }
    

    @IBAction func onRegister(_ sender: Any) {
       registerUser()
    }


}
