//
//  CVToolViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-14 on 12/12/2024.
//

import UIKit
import PDFKit
import FirebaseAuth
import FirebaseDatabase

class CVToolViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load user data from Firebase
        loadUserData()
        loadCVData()
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var educationTextField: UITextField!
    @IBOutlet weak var occupationTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    let databaseRef = Database.database().reference()
    var userUID: String? {
        return Auth.auth().currentUser?.uid
    }
    
    private func loadUserData() {
        guard let userUID = userUID else { return }
        
        // Fetch user data from Firebase
        databaseRef.child("users").child(userUID).observeSingleEvent(of: .value) { snapshot in
            guard let userData = snapshot.value as? [String: Any] else {
                print("No data found for user.")
                return
            }
            
            // Populate text fields with data from Firebase
            self.emailTextField.text = userData["email"] as? String
            self.languageTextField.text = userData["language"] as? String
            self.educationTextField.text = userData["education"] as? String
            self.occupationTextField.text = userData["occupation"] as? String
            self.phoneNumberTextField.text = userData["phoneNumber"] as? String
        }
    }
    
    private func loadCVData() {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        let databaseRef = Database.database().reference()
        databaseRef.child("users").child(userUID).child("cv").observeSingleEvent(of: .value) { snapshot in
            if let cvData = snapshot.value as? [String: Any] {
                self.emailTextField.text = cvData["email"] as? String
                self.languageTextField.text = cvData["language"] as? String
                self.educationTextField.text = cvData["education"] as? String
                self.occupationTextField.text = cvData["occupation"] as? String
                self.phoneNumberTextField.text = cvData["phoneNumber"] as? String
            } else {
                print("No CV data found.")
            }
        }
    }
    
    
    @IBAction func SaveBttnTapped(_ sender: UIButton) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        // Collect CV data
        let cvData: [String: Any] = [
            "email": emailTextField.text ?? "",
            "language": languageTextField.text ?? "",
            "education": educationTextField.text ?? "",
            "occupation": occupationTextField.text ?? "",
            "phoneNumber": phoneNumberTextField.text ?? ""
        ]
        
        let databaseRef = Database.database().reference()
        // Save CV data under the "cv" key
        databaseRef.child("users").child(userUID).child("cv").setValue(cvData) { error, _ in
            if let error = error {
                print("Failed to save CV: \(error.localizedDescription)")
            } else {
                print("CV data saved successfully!")
            }
        }
    }
    
    
    @IBAction func generateCVButtonTapped(_ sender: UIButton) {
        
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        // Fetch user data from Firebase
        databaseRef.child("users").child(userUID).observeSingleEvent(of: .value) { snapshot in
            guard let userData = snapshot.value as? [String: Any] else {
                print("No user data found.")
                return
            }
            
            // Retrieve and format the CV content
            let aboutMe = userData["aboutMe"] as? String ?? "N/A"
            let cvData = userData["cv"] as? [String: Any] ?? [:]
            let skills = userData["skills"] as? [String] ?? []
            let interests = userData["interests"] as? [String] ?? []
            let workExperience = userData["workExperience"] as? [String] ?? []
            
            let formattedCV = self.formatCVContent(
                aboutMe: aboutMe,
                cvData: cvData,
                skills: skills,
                interests: interests,
                workExperience: workExperience
            )
            
            // Perform segue and pass the CV content
            self.performSegue(withIdentifier: "showGeneratedCVSegue", sender: formattedCV)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showGeneratedCVSegue",
//           let destinationVC = segue.destination as? GeneratedCVViewController,
//           let cvContent = sender as? String {
//            destinationVC.cvContent = cvContent
//        }
//    }
//    
    private func formatCVContent(aboutMe: String, cvData: [String: Any], skills: [String], interests: [String], workExperience: [String]) -> NSAttributedString {
        let email = cvData["email"] as? String ?? "N/A"
        let language = cvData["language"] as? String ?? "N/A"
        let education = cvData["education"] as? String ?? "N/A"
        let occupation = cvData["occupation"] as? String ?? "N/A"
        let phoneNumber = cvData["phoneNumber"] as? String ?? "N/A"
        
        // Define the font and styles
        let boldFont = UIFont.boldSystemFont(ofSize: 14)
        let regularFont = UIFont.systemFont(ofSize: 14)
        
        // Create the formatted CV using NSMutableAttributedString
        let formattedCV = NSMutableAttributedString()
        
        // Title
        let title = NSAttributedString(string: "---- CV ----\n\n", attributes: [.font: boldFont])
        formattedCV.append(title)
        
        // About Me
        let aboutMeTitle = NSAttributedString(string: "About Me:\n", attributes: [.font: boldFont])
        formattedCV.append(aboutMeTitle)
        formattedCV.append(NSAttributedString(string: "\(aboutMe)\n\n", attributes: [.font: regularFont]))
        
        // Left Column (Skills, Interests, Language)
        let leftColumn = """
        Skills:\n\(skills.joined(separator: "\n"))\n
        Interests:\n\(interests.joined(separator: "\n"))\n
        Language:\n\(language)\n
        """
        let leftColumnAttributed = NSAttributedString(string: leftColumn, attributes: [.font: regularFont])
        formattedCV.append(leftColumnAttributed)
        
        // Separator between columns
        formattedCV.append(NSAttributedString(string: "\n\n"))
        
        // Right Column (Education, Contact Info, Work Experience)
        let rightColumn = """
        Education:\n\(education)\n
        Occupation:\n\(occupation)\n
        Contact Information:\nEmail: \(email)\nPhone: \(phoneNumber)\n
        Work Experience:\n\(workExperience.joined(separator: "\n"))\n
        """
        let rightColumnAttributed = NSAttributedString(string: rightColumn, attributes: [.font: regularFont])
        formattedCV.append(rightColumnAttributed)
        
        return formattedCV
    }
    
    
}
