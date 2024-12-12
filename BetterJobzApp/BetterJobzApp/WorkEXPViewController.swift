//
//  WorkEXPViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-14 on 12/12/2024.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class WorkEXPViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var workExperienceTextField: UITextField!
    @IBOutlet weak var workExperienceTableView: UITableView!
    
    var workExperience: [String] = [] // Local array to store work experience entries
        let databaseRef = Database.database().reference()
        var userUID: String? {
            return Auth.auth().currentUser?.uid
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set up the table view
            workExperienceTableView.delegate = self
            workExperienceTableView.dataSource = self
            
            // Load work experience from Firebase
            loadWorkExperience()
        }

    
    @IBAction func addWorkExperienceTapped(_ sender: UIButton) {
        guard let newExperience = workExperienceTextField.text, !newExperience.isEmpty else {
                    print("Work experience field is empty.")
                    return
                }

                // Add the new entry to the local array and update Firebase
                workExperience.append(newExperience)
                updateWorkExperienceInFirebase()

                // Clear the text field
                workExperienceTextField.text = ""
        
    }
    
    // MARK: - Delete Work Experience
       func deleteWorkExperience(at index: Int) {
           // Remove the entry from the local array
           workExperience.remove(at: index)
           
           // Update Firebase
           updateWorkExperienceInFirebase()
       }

       // MARK: - Firebase Integration
       private func loadWorkExperience() {
           guard let userUID = userUID else { return }

           databaseRef.child("users").child(userUID).child("workExperience").observeSingleEvent(of: .value) { snapshot in
               if let value = snapshot.value as? [String] {
                   self.workExperience = value
                   self.workExperienceTableView.reloadData()
               } else {
                   print("No work experience found for this user.")
               }
           }
       }

       private func updateWorkExperienceInFirebase() {
           guard let userUID = userUID else { return }

           databaseRef.child("users").child(userUID).child("workExperience").setValue(workExperience) { error, _ in
               if let error = error {
                   print("Failed to update work experience: \(error.localizedDescription)")
               } else {
                   print("Work experience updated successfully!")
                   self.workExperienceTableView.reloadData()
               }
           }
       }

       // MARK: - Table View Data Source
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return workExperience.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "WorkExperienceCell", for: indexPath)
           cell.textLabel?.text = workExperience[indexPath.row]

           // Add a delete button to each cell
           let deleteButton = UIButton(type: .custom)
           deleteButton.setTitle("Delete", for: .normal)
           deleteButton.setTitleColor(.red, for: .normal)
           deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
           deleteButton.tag = indexPath.row
           cell.accessoryView = deleteButton

           return cell
       }

       // MARK: - Delete Button Action
       
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        
        let index = sender.tag
        deleteWorkExperience(at: index)
    }
    
}
