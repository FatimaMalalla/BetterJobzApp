//
//  SettingsViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-20 on 11/12/2024.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SettingsViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
     
    @IBAction func LogOut(_ sender: UIButton) {
            do {
            // Sign out from Firebase
            try Auth.auth().signOut()
            
            // Navigate to the login screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            loginVC.modalPresentationStyle = .fullScreen
            
            // Reset root view controller to LoginViewController
            self.view.window?.rootViewController = loginVC
            self.view.window?.makeKeyAndVisible()
        } catch let error {
            // Handle error during logout
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
}
