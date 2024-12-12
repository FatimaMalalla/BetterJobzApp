//
//  InterestsViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-14 on 12/12/2024.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class InterestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var interestTextField: UITextField!
    @IBOutlet weak var interestsTableView: UITableView!
    
    var interests: [String] = [] // Local array to store interests
        let databaseRef = Database.database().reference()
        var userUID: String? {
            return Auth.auth().currentUser?.uid
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up table view
              interestsTableView.delegate = self
              interestsTableView.dataSource = self
              
              // Load interests from Firebase
              loadInterests()
    }
    
    @IBAction func addInterestTapped(_ sender: UIButton) {
        guard let newInterest = interestTextField.text, !newInterest.isEmpty else {
                    print("Interest field is empty.")
                    return
                }

                // Add the new interest to the local array and update Firebase
                interests.append(newInterest)
                updateInterestsInFirebase()

                // Clear the text field
                interestTextField.text = ""
    }
    
    // MARK: - Delete Interest
      func deleteInterest(at index: Int) {
          // Remove the interest from the local array
          interests.remove(at: index)
          
          // Update Firebase
          updateInterestsInFirebase()
      }

      // MARK: - Firebase Integration
      private func loadInterests() {
          guard let userUID = userUID else { return }

          databaseRef.child("users").child(userUID).child("interests").observeSingleEvent(of: .value) { snapshot in
              if let value = snapshot.value as? [String] {
                  self.interests = value
                  self.interestsTableView.reloadData()
              } else {
                  print("No interests found for this user.")
              }
          }
      }

      private func updateInterestsInFirebase() {
          guard let userUID = userUID else { return }

          databaseRef.child("users").child(userUID).child("interests").setValue(interests) { error, _ in
              if let error = error {
                  print("Failed to update interests: \(error.localizedDescription)")
              } else {
                  print("Interests updated successfully!")
                  self.interestsTableView.reloadData()
              }
          }
      }

      // MARK: - Table View Data Source
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return interests.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "InterestCell", for: indexPath)
          cell.textLabel?.text = interests[indexPath.row]

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
              deleteInterest(at: index)
    }
  
      
    
    
}
