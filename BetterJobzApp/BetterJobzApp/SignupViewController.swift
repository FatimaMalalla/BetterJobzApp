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
        
        guard let phoneNumber = PhoneNumberTextField.text, isValidPhoneNumber(phoneNumber) else {
            showAlert(title: "Validation Error", message: "Enter a valid phone number.")
            return
        }

        // Firebase Authentication
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] Result, error in
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert(title: "Error", message: "SignUp Failed: \(error.localizedDescription)")
                return
            }
            
            // Save user details to Firebase Realtime Database
            guard let user = Result?.user else {
                self.showAlert(title: "Error", message: "User creation failed.")
                return
            }
            
            let uid = user.uid
            let ref = Database.database().reference()
            
            let userInfo: [String: Any] = [
                "Email": email,
                "FirstName": firstName,
                "LastName": lastName,
                "Dob": dob,
                "Gender": gender,
                "PhoneNumber": phoneNumber
            ]
            
            ref.child("users").child(uid).setValue(userInfo) { error, _ in
                if let error = error {
                    self.showAlert(title: "Error", message: "Failed to save user data: \(error.localizedDescription)")
                    return
                }
                
                self.showAlert(title: "Success", message: "Account created successfully!")
            }
        })
    }

    // Helper Functions for Validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = "^[0-9]{8}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phoneNumber)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}
