//
//  ViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-07 on 26/11/2024.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        // MARK: - Actions
        // Retrieve user input
        let username = Username.text ?? ""
        let password = Password.text ?? ""
        
        // Validate user input
            if username.isEmpty || password.isEmpty {
                showAlert(title: "Error", message: "Please fill in all fields")
                return
            }

            // Example authentication logic
            if username == "testuser" && password == "password123" {
                // Trigger the segue to the Storyboard Reference
                performSegue(withIdentifier: "showDashboardSegue", sender: nil)
            } else {
                showAlert(title: "Login Failed", message: "Invalid username or password")
            }
    }
    
    // Helper function to show an alert
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // Prepare for navigation if needed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDashboardSegue" {
//            // Access the destination view controller via the segue
//            let dashboardVC = segue.destination as?DashboardViewController
//            // Pass data if needed (assuming `DashboardViewController` exists)
//            dashboardVC?.username = Username.text
//        }
    }


    
    
    
}
