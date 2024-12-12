//
//  SkillsViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-14 on 12/12/2024.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SkillsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var skillTextField: UITextField!
    @IBOutlet weak var skillsTableView: UITableView!
  
    var skills: [String] = [] // Local array to store skills
        let databaseRef = Database.database().reference()
        var userUID: String? {
            return Auth.auth().currentUser?.uid
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set up table view
            skillsTableView.delegate = self
            skillsTableView.dataSource = self
            
            // Load skills from Firebase
            loadSkills()
        }
    
    // MARK: - Add Skill
    @IBAction func addSkillTapped(_ sender: UIButton) {
        guard let newSkill = skillTextField.text, !newSkill.isEmpty else {
            print("Skill field is empty.")
            return
        }

        // Add the new skill to the local array and update Firebase
        skills.append(newSkill)
        updateSkillsInFirebase()

        // Clear the text field
        skillTextField.text = ""
    }

    // MARK: - Delete Skill
    func deleteSkill(at index: Int) {
        // Remove the skill from the local array
        skills.remove(at: index)
        
        // Update Firebase
        updateSkillsInFirebase()
    }

    // MARK: - Firebase Integration
    private func loadSkills() {
        guard let userUID = userUID else { return }

        databaseRef.child("users").child(userUID).child("skills").observeSingleEvent(of: .value) { snapshot in
            if let value = snapshot.value as? [String] {
                self.skills = value
                self.skillsTableView.reloadData()
            } else {
                print("No skills found for this user.")
            }
        }
    }

    private func updateSkillsInFirebase() {
        guard let userUID = userUID else { return }

        databaseRef.child("users").child(userUID).child("skills").setValue(skills) { error, _ in
            if let error = error {
                print("Failed to update skills: \(error.localizedDescription)")
            } else {
                print("Skills updated successfully!")
                self.skillsTableView.reloadData()
            }
        }
    }

    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath)
        cell.textLabel?.text = skills[indexPath.row]

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
        deleteSkill(at: index)
        
    }
    
       
    
    
    
    
}
