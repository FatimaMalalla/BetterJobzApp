//
//  AboutMeViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-01 on 12/12/2024.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class AboutMeViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    let databaseRef = Database.database().reference()
        var userUID: String? {
            return Auth.auth().currentUser?.uid
        }
    
    
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           textView.delegate = self
           placeholderLabel.isHidden = !textView.text.isEmpty

           // Load saved data from Firebase
           loadAboutMeData()
       }
    

    @IBAction func saveBttnTapped(_ sender: UIButton) {
        
        guard let userUID = Auth.auth().currentUser?.uid else { return }
         guard let aboutMeText = textView.text, !aboutMeText.isEmpty else {
             print("Text view is empty. No data to save.")
             return
         }

         let databaseRef = Database.database().reference()
         // Save About Me data under the "aboutMe" key
         databaseRef.child("users").child(userUID).child("aboutMe").setValue(aboutMeText) { error, _ in
             if let error = error {
                 print("Failed to save About Me: \(error.localizedDescription)")
             } else {
                 print("About Me saved successfully!")
             }
         }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelBttnTapped(_ sender: UIButton) {
        // Navigate back to the previous screen
               self.dismiss(animated: true, completion: nil)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
            // Hide the placeholder when the user starts editing
            placeholderLabel.isHidden = true
        }

    func textViewDidEndEditing(_ textView: UITextView) {
            // Show the placeholder if the text view is empty
            placeholderLabel.isHidden = !textView.text.isEmpty
        }

    private func loadAboutMeData() {
        guard let userUID = Auth.auth().currentUser?.uid else { return }

        let databaseRef = Database.database().reference()
        databaseRef.child("users").child(userUID).child("aboutMe").observeSingleEvent(of: .value) { snapshot in
            if let aboutMeText = snapshot.value as? String {
                self.textView.text = aboutMeText
                self.placeholderLabel.isHidden = !aboutMeText.isEmpty
            } else {
                self.textView.text = ""
                self.placeholderLabel.isHidden = false
                print("No About Me data found.")
            }
        }
    }


    
}
