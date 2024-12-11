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
    
    
    @IBAction func signout(_ sender: UIButton) {
        
        do {
                    if FirebaseAuth.Auth.auth().currentUser != nil {
                        try FirebaseAuth.Auth.auth().signOut()
                        print("Successfully signed out.")
                        
                        // Navigate back to login or root screen
                        if let navigationController = self.navigationController {
                            navigationController.popToRootViewController(animated: true)
                        } else {
                            // Handle modal presentation or tab bar navigation
                            self.dismiss(animated: true, completion: nil)
                        }
                    } else {
                        print("No user is currently logged in.")
                    }
                } catch let error {
                    print("Error Signing Out: \(error.localizedDescription)")
                }
            }
    }
    
