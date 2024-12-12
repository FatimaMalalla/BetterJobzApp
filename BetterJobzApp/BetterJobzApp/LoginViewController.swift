//
//  LoginViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-01 on 03/12/2024.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Check if a user is already logged in
                if Auth.auth().currentUser != nil {
                    // Navigate directly to the home screen
                    self.performSegue(withIdentifier: "showDashboardSegue", sender: nil)
                }
    }
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    
    //Admin Login Credentials : Admin@gmail.com, Password : Password123
    //Employee Login Credentials : johndoe123@gmail.com , password : PassEmp
    //Job Seeker Login Credentials : Joyce@Gmail.com , Password : JY2000
    //login : hj123@gmail.com  , password : Hpj123
    

    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let username = Username.text, !username.isEmpty,
                 let password = Password.text, !password.isEmpty else {
               showAlert(title: "Missing Field Data", message: "Please fill in all required fields")
               return
           }
           
           Auth.auth().signIn(withEmail: username, password: password) { [weak self] authResult, error in
               guard let self = self else { return }
               
               if let error = error {
                   self.showAlert(title: "Error", message: error.localizedDescription)
                   return
               }
               
               if let user = Auth.auth().currentUser {
                   print("Logged in as UID: \(user.uid)")
                   
                   // Navigate to the dashboard
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let dashboardVC = storyboard.instantiateViewController(withIdentifier: "DashboardViewController")
                   dashboardVC.modalPresentationStyle = .fullScreen
                   self.present(dashboardVC, animated: true) {
                       self.view.window?.rootViewController = dashboardVC
                   }
               }
           }
    }

    // Helper function to show an alert
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

   
}
