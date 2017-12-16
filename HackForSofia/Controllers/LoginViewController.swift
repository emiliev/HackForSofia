//
//  LoginViewController.swift
//  HackForSofia
//
//  Created by Marina Georgieva on 12/16/17.
//  Copyright © 2017 Emil Iliev. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Login" 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(_ sender: Any) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text
        else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            guard let sSelf = self,
                error == nil else {
                    let alertController = UIAlertController(title: "Invalid Login", message: error?.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                    return
            }
            
            print("User signed in")
            sSelf.dismiss(animated: true, completion: nil)
        }
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
