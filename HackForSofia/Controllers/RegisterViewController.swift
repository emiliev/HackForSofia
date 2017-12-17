//
//  RegisterViewController.swift
//  HackForSofia
//
//  Created by Marina Georgieva on 12/16/17.
//  Copyright © 2017 Emil Iliev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    var ref: DatabaseReference!

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Registration"
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text
        else { return false }
        
        let should = validateTextFields()
        if should {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
                guard let sSelf = self,
                    error == nil else {
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self?.present(alertController, animated: true, completion: nil)
                        return
                }
                
                print("User registered in!")
                sSelf.ref.child("data/users").updateChildValues(["\(Auth.auth().currentUser!.uid)": ["Username": firstName + " " + lastName]])
            }
        }
        
        return should
    }
    
    func validateTextFields() -> Bool {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmPasswordTextField.text
        else { return false }
        
        var message: String = ""
        var should: Bool = true
        
        if !isValidEmail(testStr: email) {
            message = "Please enter a valid email address"
            should = false
            
        } else if password.count < 6 {
            message = "Password must be greater than 6 characters"
            should = false
            
        } else if password != confirmPassword {
            message = "Password and confirm password must be the same"
            should = false
        }
        
        if !should{
            let alertController = UIAlertController(title: "Invalid", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
        
        return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
