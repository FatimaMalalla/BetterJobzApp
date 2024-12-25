//
//  SecondPageTutorialViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-16N on 25/12/2024.
//

import UIKit

class SecondPageTutorialViewController: UIViewController {
    
    @IBOutlet weak var secondLikeButton: UIButton!
    @IBOutlet weak var secondSaveButton: UIButton!
    
    // Keys for UserDefaults
    let likeButtonKey = "likeButtonState"
    let saveButtonKey = "saveButtonState"
    
    // Track the states
    var isSecondButtonLiked = false
    var isSecondButtonSaved = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Restore states from UserDefaults
        isSecondButtonLiked = UserDefaults.standard.bool(forKey: likeButtonKey)
        updateSecondLikeButtonImage()

        isSecondButtonSaved = UserDefaults.standard.bool(forKey: saveButtonKey)
        updateSecondSaveButtonImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Reload the state when the view appears
        isSecondButtonLiked = UserDefaults.standard.bool(forKey: likeButtonKey)
        isSecondButtonSaved = UserDefaults.standard.bool(forKey: saveButtonKey)
        updateSecondLikeButtonImage()
        updateSecondSaveButtonImage()
    }
    
    @IBAction func secondLikeButtonTapped(_ sender: Any) {
        // Toggle the state
        isSecondButtonLiked.toggle()

        // Save the new state
        UserDefaults.standard.set(isSecondButtonLiked, forKey: likeButtonKey)
        
        // Notify other views of the change
        NotificationCenter.default.post(name: NSNotification.Name("UpdateStates"), object: nil)

        // Update the button's image
        updateSecondLikeButtonImage()
    }
    
    @IBAction func secondSaveButtonTapped(_ sender: Any) {
        // Toggle the state
        isSecondButtonSaved.toggle()

        // Save the new state
        UserDefaults.standard.set(isSecondButtonSaved, forKey: saveButtonKey)
        
        // Notify other views of the change
        NotificationCenter.default.post(name: NSNotification.Name("UpdateStates"), object: nil)

        // Update the button's image
        updateSecondSaveButtonImage()
    }
    
    private func updateSecondLikeButtonImage() {
        if isSecondButtonLiked {
            secondLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            secondLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    private func updateSecondSaveButtonImage() {
        if isSecondButtonSaved {
            secondSaveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            secondSaveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
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
