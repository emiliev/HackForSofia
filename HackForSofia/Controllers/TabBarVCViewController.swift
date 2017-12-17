//
//  TabBarVCViewController.swift
//  HackForSofia
//
//  Created by Emil Iliev on 12/17/17.
//  Copyright © 2017 Emil Iliev. All rights reserved.
//

import UIKit
import FirebaseAuth

class TabBarVCViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! Auth.auth().signOut()
        
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let user = user else {
                let auth = self?.storyboard?.instantiateViewController(withIdentifier: "loginNavVC") as! UINavigationController
                self?.present(auth, animated: true, completion: nil)
                return
            }

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
