//
//  SignupViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-01 on 03/12/2024.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignupViewController: UIViewController {
    
  
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var DobTextField: UITextField!
    @IBOutlet weak var GenderTextField: UITextField!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
      
    
    @IBAction func ResetFields(_ sender: Any) {
        FirstNameTextField.text = ""
        LastNameTextField.text = ""
        EmailTextField.text = ""
        PasswordTextField.text = ""
        DobTextField.text = ""
        GenderTextField.text = ""
        PhoneNumberTextField.text = ""
    }
    

    @IBAction func CreateAccount(_ sender: Any) {
        
        guard let username = FirstNameTextField.text ,
              let email =  EmailTextField.text,
              let password = PasswordTextField.text,
              !username.isEmpty && !email.isEmpty && !password.isEmpty
        else{
            let alert = UIAlertController(title: "Missing Field Data", message: "Please Fill in all the fields", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
            
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {
            Result, error in
            guard error == nil else {
                let alert = UIAlertController(title: "Error", message: "SignUp Failed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
                
                return
            }
        })
//        guard let firstName = FirstNameTextField.text, !firstName.isEmpty,
//              let lastName = LastNameTextField.text, !lastName.isEmpty,
//              let email = EmailTextField.text, !email.isEmpty,
//              let password = PasswordTextField.text, !password.isEmpty,
//              let dob = DobTextField.text, !dob.isEmpty,
//              let gender = GenderTextField.text, !gender.isEmpty,
//              let phone = PhoneNumberTextField.text, !phone.isEmpty
//        else {
//            let alert = UIAlertController(title: "Missing field data", message: "Please fill in all the fields", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
//            self.present(alert, animated: true)
//            return
//        }
//        
//        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {
//            Result, error in
//            guard error == nil else {
//                let alert = UIAlertController(title: "Error", message: "Signup Failed" , preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
//                self.present(alert, animated: true)
//                return
//            }
//        })
    }
        // Create User in Firebase Auth
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                self.showAlert(title: "Error", message: error.localizedDescription)
//                return
//            }
//            
//            guard let user = authResult?.user else { return }
//            let userID = user.uid
//            
//            // Save additional details in Firebase Realtime Database
//            let databaseRef = Database.database().reference().child("users").child(userID)
//            let userData: [String: Any] = [
//                "firstName": firstName,
//                "lastName": lastName,
//                "email": email,
//                "dob": dob,
//                "gender": gender,
//                "phone": phone
//            ]
//            
//            databaseRef.setValue(userData) { error, _ in
//                if let error = error {
//                    self.showAlert(title: "Error", message: error.localizedDescription)
//                    return
//                }
//                self.showAlert(title: "Success", message: "Account created successfully")
//            }
//        }
        
        
       
    
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


