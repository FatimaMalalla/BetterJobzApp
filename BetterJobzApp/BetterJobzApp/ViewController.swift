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
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    // MARK: - Create account button
    @IBAction func createButtonTapped(_ sender: UIButton) {
        
        // Collect data from the text fields
               let firstName = firstNameTextField.text ?? ""
               let lastName = lastNameTextField.text ?? ""
               let email = emailTextField.text ?? ""
               let password = passwordTextField.text ?? ""
               let dateOfBirth = dateOfBirthTextField.text ?? ""
               let gender = genderTextField.text ?? ""
               let phoneNumber = phoneNumberTextField.text ?? ""

               // Validate input
        if firstName.isEmpty, lastName.isEmpty, email.isEmpty, password.isEmpty {
            showAlert(title: "Alert", message: "Please fill in all required fields.")
        }
        else
        {
            showAlert(title: "Success", message: "User Created successfully!")
            performSegue(withIdentifier: "showDashboardSegue", sender: nil)
        }
             

               // Save user details (e.g., to UserDefaults or a database)
               let user = [
                   "firstName": firstName,
                   "lastName": lastName,
                   "email": email,
                   "password": password,
                   "dateOfBirth": dateOfBirth,
                   "gender": gender,
                   "phoneNumber": phoneNumber
               ]

               // Save user to UserDefaults (you can use other methods like CoreData or Firebase)
               UserDefaults.standard.set(user, forKey: "userDetails")

        
        }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // Clear all text fields
                firstNameTextField.text = ""
                lastNameTextField.text = ""
                emailTextField.text = ""
                passwordTextField.text = ""
                dateOfBirthTextField.text = ""
                genderTextField.text = ""
                phoneNumberTextField.text = ""
    }
}
    


    
    
    

