//
//  CVToolViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-20 on 11/12/2024.
//

import UIKit

class CVToolViewController: ViewController , UITextViewDelegate {

    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("textView: \(textView != nil), placeholderLabel: \(placeholderLabel != nil)")
//          
//          textView.delegate = self
//          placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    @IBAction func CancelBttnTapped(_ sender: UIButton) {
        
        // Dismiss the current view controller or navigate back to the main page
               self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        
//        guard let text = textView.text, !text.isEmpty else {
//                    // Show an alert if there's no text to save
//                    let alert = UIAlertController(
//                        title: "No Content",
//                        message: "Please add details before saving.",
//                        preferredStyle: .alert
//                    )
//                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                    present(alert, animated: true, completion: nil)
//                    return
//                }
//
//                // Save the text content (could save to UserDefaults, CoreData, or pass to the main screen)
//                saveTextData(text)
//
//                // Dismiss the current view controller or navigate back to the main page
//                self.dismiss(animated: true, completion: nil)
        
    }
    
   
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//            // Show the placeholder when user starts editing and text is empty
//            if textView.text.isEmpty {
//                placeholderLabel.isHidden = false
//            }
//        }
//
//        func textViewDidChange(_ textView: UITextView) {
//            // Hide the placeholder when user starts typing
//            placeholderLabel.isHidden = !textView.text.isEmpty
//        }
//
//        func textViewDidEndEditing(_ textView: UITextView) {
//            // Show placeholder if text view is empty when editing ends
//            placeholderLabel.isHidden = !textView.text.isEmpty
//        }
//    
//
//    // MARK: - Save Text Data
//       func saveTextData(_ text: String) {
//           // Example: Save to UserDefaults (you can replace this with your preferred data-saving method)
//           UserDefaults.standard.set(text, forKey: "savedCVText")
//       }
}
