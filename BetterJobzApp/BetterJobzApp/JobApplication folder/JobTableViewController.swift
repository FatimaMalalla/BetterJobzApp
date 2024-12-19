//
//  JobTableViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-07 on 15/12/2024.
//

import UIKit
import FirebaseDatabase

class JobTableViewController: UITableViewController {
    
    //Current Work Experience
    
    @IBOutlet weak var currentJobTitle: UITextField!
    @IBOutlet weak var currentEmployerName: UITextField!
    @IBOutlet weak var currentJobDesc: UITextField!
    
    //Previous Work Experience
    
    @IBOutlet weak var previousJobTitle: UITextField!
    @IBOutlet weak var previousEmployerName: UITextField!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var previousJobDesc: UITextField!
    
    //Qualifications
    
    @IBOutlet weak var skills: UITextField!
    @IBOutlet weak var education: UITextField!
    @IBOutlet weak var certifications: UITextField!
    @IBOutlet weak var yearsOfExperience: UITextField!
    
    //Cover letter
    @IBOutlet weak var letterOfIntent: UITextField!
    
    
    var ref: DatabaseReference!
    
    /// Displays an alert with a title, message, and an action button.
    func showAlert(title: String, message: String, buttonTitle: String = "OK", completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            // Call the completion handler if provided
            completion?()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    // Employed Next button
    @IBAction func NextButtonTapped(_ sender: Any) {
        guard let jobTitle = currentJobTitle.text, !jobTitle.isEmpty,
              let employerName = currentEmployerName.text, !employerName.isEmpty,
              let description = currentJobDesc.text, !description.isEmpty
        else {
            showAlert(title: "Error", message: "All fields are required.")
            return
        }
        let jobApplicationData: [String: Any] = [
            "Current Job Title": jobTitle,
            "Current Employer Name": employerName,
            "Description of Current Job": description
        ]
        
        ref.child("Current_Job_Details").childByAutoId().setValue(jobApplicationData)
    }
    
    // Unemployed Next button
    @IBAction func unemployedNextButtonTapped(_ sender: Any) {
        guard let pJobTitle = previousJobTitle.text, !pJobTitle.isEmpty,
              let pEmployerName = previousEmployerName.text, !pEmployerName.isEmpty,
              let start = startDate.text, !start.isEmpty,
              let end = endDate.text, !end.isEmpty,
              let pDescription = previousJobDesc.text, !pDescription.isEmpty
        else{
            showAlert(title: "Error", message: "All fields are required.")
            return
        }
        let jobApplicationData: [String: Any] = [
            "Previous Job Title": pJobTitle,
            "Previous Employer Name": pEmployerName,
            "Start Date": start,
            "End Date": end,
            "Description of Previous Job": pDescription
        ]
        
        ref.child("Previous_Job_Details").childByAutoId().setValue(jobApplicationData)
    }
    
    // Qualification Next button
    @IBAction func qualificationNextButtonTapped(_ sender: Any) {
        guard let skillBox = skills.text, !skillBox.isEmpty,
              let educationBox = education.text, !educationBox.isEmpty,
              let certificationsBox = certifications.text, !certificationsBox.isEmpty,
              let yearsOfExperienceBox = yearsOfExperience.text, !yearsOfExperienceBox.isEmpty
        else{
            showAlert(title: "Error", message: "All fields are required.")
            return
            }
        
        let jobApplicationData: [String: Any] = [
            "Skills": skillBox,
            "Education": educationBox,
            "Certifications": certificationsBox,
            "Years of Experience": yearsOfExperienceBox
        ]
        
        ref.child("Qualifications_Details").childByAutoId().setValue(jobApplicationData)
    }
    
    // Cover letter finish button
    @IBAction func coverLetterFinishButtonTapped(_ sender: Any) {
        guard let letterOfIntentBox = letterOfIntent.text,
              !letterOfIntentBox.isEmpty
        else{
            showAlert(title: "Error", message: "All fields are required.")
            return
            }
        
        let jobApplicationData: [String: Any] = [
            "Letter of Intent": letterOfIntentBox
            ]
        
        ref.child("Letter_of_Intent").childByAutoId().setValue(jobApplicationData)
    }
    
    
    
    
    
    
    
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}
