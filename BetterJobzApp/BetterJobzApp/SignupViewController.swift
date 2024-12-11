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
              let FirstName = FirstNameTextField.text,
              let LastName = LastNameTextField.text,
              let Dob = DobTextField.text,
              let Gender = GenderTextField.text,
              let PhoneNumber = PhoneNumberTextField.text,
              !username.isEmpty && !email.isEmpty && !password.isEmpty && !FirstName.isEmpty && !LastName.isEmpty && !Dob.isEmpty && !Gender.isEmpty && !PhoneNumber.isEmpty
        else{
            let alert = UIAlertController(title: "Missing Field Data", message: "Please Fill in all the fields", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
            
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {
            Result, error in
            guard error == nil else {
                let alert = UIAlertController(title:"Error", message: "SignUp Failed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
                
                return
            }
        })
//        
//        let ref = Database.database().reference()
//        
//        guard let user = Result?.user else {
//            self.showAlert(title: "Error", message: "User creation failed.")
//            return
//        }
//        let uid = user.uid
//
//        
//        let userInfo: [String: Any] = [
//             "Email": email,
//             "FirstName": FirstName,
//             "LastName": LastName,
//             "Dob": Dob,
//             "Gender": Gender,
//             "PhoneNumber": PhoneNumber
//         ]
//
//         ref.child("users").child(uid).setValue(userInfo) { error, _ in
//             if let error = error {
//                 self.showAlert(title: "Error", message: "Failed to save user data: \(error.localizedDescription)")
//                 return
//             }
//
//             self.showAlert(title: "Success", message: "Account created successfully!")
//         }
    }
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


