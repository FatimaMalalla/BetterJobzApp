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
    
    @IBAction func GenerateCVtool(_ sender: UIButton) {
        guard let userUID = userUID else { return }

                // Fetch user data from Firebase
                databaseRef.child("users").child(userUID).observeSingleEvent(of: .value) { snapshot in
                    guard let userData = snapshot.value as? [String: Any] else {
                        print("No user data found.")
                        return
                    }

                    // Retrieve individual sections
                    let aboutMe = userData["aboutMe"] as? String ?? "N/A"
                    let cvData = userData["cv"] as? [String: Any] ?? [:]
                    let skills = userData["skills"] as? [String] ?? []
                    let interests = userData["interests"] as? [String] ?? []
                    let workExperience = userData["workExperience"] as? [String] ?? []

                    // Format the CV content
                    let cvContent = self.formatCVContent(
                        aboutMe: aboutMe,
                        cvData: cvData,
                        skills: skills,
                        interests: interests,
                        workExperience: workExperience
                    )

                    // Option 1: Display the CV in a new screen
                    self.displayCV(cvContent)

                    // Option 2: Export the CV as a PDF
                    // self.generatePDF(cvContent: cvContent)
                }
            }

            // MARK: - Format CV Content
            private func formatCVContent(aboutMe: String, cvData: [String: Any], skills: [String], interests: [String], workExperience: [String]) -> String {
                let email = cvData["email"] as? String ?? "N/A"
                let language = cvData["language"] as? String ?? "N/A"
                let education = cvData["education"] as? String ?? "N/A"
                let occupation = cvData["occupation"] as? String ?? "N/A"
                let phoneNumber = cvData["phoneNumber"] as? String ?? "N/A"

                var content = "---- CV ----\n"
                content += "\nAbout Me:\n\(aboutMe)"
                content += "\n\nContact Information:\n"
                content += "Email: \(email)\n"
                content += "Phone: \(phoneNumber)\n"
                content += "\nEducation:\n\(education)"
                content += "\n\nOccupation:\n\(occupation)"
                content += "\n\nLanguage:\n\(language)"
                content += "\n\nSkills:\n\(skills.joined(separator: ", "))"
                content += "\n\nInterests:\n\(interests.joined(separator: ", "))"
                content += "\n\nWork Experience:\n\(workExperience.joined(separator: "\n"))"

                return content
            }

            // MARK: - Display CV
            private func displayCV(_ content: String) {
                let cvViewController = UIViewController()
                cvViewController.view.backgroundColor = .white

                let textView = UITextView(frame: cvViewController.view.bounds)
                textView.text = content
                textView.font = UIFont.systemFont(ofSize: 16)
                textView.isEditable = false
                cvViewController.view.addSubview(textView)

                self.navigationController?.pushViewController(cvViewController, animated: true)
            }

    private func generatePDF(cvContent: String) {
        // Define the PDF page bounds
        let pageBounds = CGRect(x: 0, y: 0, width: 612, height: 792) // Standard Letter size

        // Create a PDF Renderer
        let renderer = UIGraphicsPDFRenderer(bounds: pageBounds)

        // Generate the PDF data
        let pdfData = renderer.pdfData { context in
            context.beginPage()
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            cvContent.draw(in: pageBounds.insetBy(dx: 20, dy: 20), withAttributes: attributes)
        }

        // Save or Share the PDF
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let pdfURL = documentsDirectory?.appendingPathComponent("GeneratedCV.pdf")

        do {
            try pdfData.write(to: pdfURL!)
            print("PDF saved successfully at \(pdfURL!)")
            // Optionally present a success message to the user
        } catch {
            print("Failed to save PDF: \(error.localizedDescription)")
        }
    }

}
