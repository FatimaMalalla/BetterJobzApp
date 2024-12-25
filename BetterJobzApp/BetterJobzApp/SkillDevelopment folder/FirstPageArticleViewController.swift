//
//  FirstPageArticleViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-16N on 25/12/2024.
//

import UIKit

class FirstPageArticleViewController: UIViewController {

    @IBOutlet weak var firstLikeButton: UIButton!
    @IBOutlet weak var firstSaveButton: UIButton!
    
    // Keys for UserDefaults
    let likeButtonKey = "likeButtonState"
    let saveButtonKey = "saveButtonState"
    
    // Track the states
    var isFirstButtonLiked = false
    var isFirstButtonSaved = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Restore states from UserDefaults
        isFirstButtonLiked = UserDefaults.standard.bool(forKey: likeButtonKey)
        updateLikeButtonImage()

        isFirstButtonSaved = UserDefaults.standard.bool(forKey: saveButtonKey)
        updateBookmarkButtonImage()
        
        // Add observer for state updates
        NotificationCenter.default.addObserver(self, selector: #selector(updateStates), name: NSNotification.Name("UpdateStates"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reload the state when the view appears
        isFirstButtonLiked = UserDefaults.standard.bool(forKey: likeButtonKey)
        isFirstButtonSaved = UserDefaults.standard.bool(forKey: saveButtonKey)
        updateLikeButtonImage()
        updateBookmarkButtonImage()
    }
    
    @IBAction func firstLikeButtonTapped(_ sender: Any) {
        // Toggle the state
        isFirstButtonLiked.toggle()

        // Save the new state
        UserDefaults.standard.set(isFirstButtonLiked, forKey: likeButtonKey)
        
        // Notify other views of the change
        NotificationCenter.default.post(name: NSNotification.Name("UpdateStates"), object: nil)

        // Update the button's image
        updateLikeButtonImage()
    }
    
    @IBAction func firstSaveButtonTapped(_ sender: Any) {
        // Toggle the state
        isFirstButtonSaved.toggle()

        // Save the new state
        UserDefaults.standard.set(isFirstButtonSaved, forKey: saveButtonKey)
        
        // Notify other views of the change
        NotificationCenter.default.post(name: NSNotification.Name("UpdateStates"), object: nil)

        // Update the button's image
        updateBookmarkButtonImage()
    }
    
    private func updateLikeButtonImage() {
        if isFirstButtonLiked {
            firstLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            firstLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    private func updateBookmarkButtonImage() {
        if isFirstButtonSaved {
            firstSaveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            firstSaveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    @objc private func updateStates() {
        // Reload states from UserDefaults when notified
        isFirstButtonLiked = UserDefaults.standard.bool(forKey: likeButtonKey)
        isFirstButtonSaved = UserDefaults.standard.bool(forKey: saveButtonKey)
        updateLikeButtonImage()
        updateBookmarkButtonImage()
    }
    
    //Second Article
    @IBAction func secondArticle(_ sender: Any) {

        let websiteURL = URL(string: "https://drexel.edu/scdc/professional-resources/application-materials/resumes/experience-description")!

        // Open the URL
        if UIApplication.shared.canOpenURL(websiteURL) {
            UIApplication.shared.open(websiteURL, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL")
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

}
