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

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    
    //Admin Login Credentials : Admin@gmail.com, Password : Password123
    //Employee Login Credentials : johndoe123@gmail.com , password : PassEmp
    //Job Seeker Login Credentials : Joyce@Gmail.com , Password : JY2000
    //login : hj123@gmail.com  , password : Hpj123
    

    @IBAction func loginButtonTapped(_ sender: Any) {
        // Retrieve user input
        guard let username = Username.text, !username.isEmpty,
              let password = Password.text, !password.isEmpty else {
            let alert = UIAlertController(title: "Missing field data",
                                          message: "Please fill in the required fields",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
            return
        }
        
        // Firebase Authentication
        Auth.auth().signIn(withEmail: username, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                strongSelf.showAlert(title: "Error", message: error.localizedDescription)
                return
            }
            
            // Navigate to Home
            strongSelf.performSegue(withIdentifier: "showDashboardSegue", sender: nil)
        }
    }

    // Helper function to show an alert
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

   
}
