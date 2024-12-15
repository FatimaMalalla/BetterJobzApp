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
        
            // Validate fields
            guard let firstName = FirstNameTextField.text, !firstName.isEmpty else {
                showAlert(title: "Validation Error", message: "First Name is required.")
                return
            }
            
            guard let lastName = LastNameTextField.text, !lastName.isEmpty else {
                showAlert(title: "Validation Error", message: "Last Name is required.")
                return
            }
            
            guard let email = EmailTextField.text, isValidEmail(email) else {
                showAlert(title: "Validation Error", message: "Enter a valid email address.")
                return
            }
            
            guard let password = PasswordTextField.text, isValidPassword(password) else {
                showAlert(title: "Validation Error", message: "Password must be at least 6 characters.")
                return
            }
            
            guard let dob = DobTextField.text, !dob.isEmpty else {
                showAlert(title: "Validation Error", message: "Date of Birth is required.")
                return
            }
            
            guard let gender = GenderTextField.text, !gender.isEmpty else {
                showAlert(title: "Validation Error", message: "Gender is required.")
                return
            }
            
            guard let phoneNumber = PhoneNumberTextField.text, !phoneNumber.isEmpty else {
                showAlert(title: "Validation Error", message: "Phone Number is required.")
                return
            }
            
            // Combine First Name and Last Name to create Username
            let username = "\(firstName) \(lastName)"
            
            // Firebase Authentication to create a new user
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard error == nil, let user = result?.user else {
                    self.showAlert(title: "Error", message: "Failed to create account: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                // Save additional user data to Firebase Realtime Database
                let userUID = user.uid
                let userData: [String: Any] = [
                    "FirstName": firstName,
                    "LastName": lastName,
                    "Username": username,
                    "Email": email,
                    "Password": password,
                    "Dob": dob,
                    "Gender": gender,
                    "PhoneNumber": phoneNumber
                ]
                
                let databaseRef = Database.database().reference()
                databaseRef.child("users").child(userUID).setValue(userData) { error, _ in
                    if let error = error {
                        self.showAlert(title: "Error", message: "Failed to save user data: \(error.localizedDescription)")
                    } else {
                        self.showAlert(title: "Success", message: "Account created successfully!")
                    }
                }
            }
        }

        // Helper function to validate email
        private func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailPredicate.evaluate(with: email)
        }

        // Helper function to validate password
        private func isValidPassword(_ password: String) -> Bool {
            return password.count >= 6
        }

        // Helper function to show alerts
        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }

    
}
