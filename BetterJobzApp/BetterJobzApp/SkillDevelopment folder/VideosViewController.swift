//
//  VideosViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-16N on 25/12/2024.
//

import UIKit

class VideosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func firstVideo(_ sender: Any) {
        let youtubeURL = URL(string: "https://www.youtube.com/watch?v=0FFLFcB9xfQ")!
        
        // Open the URL
        if UIApplication.shared.canOpenURL(youtubeURL) {
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL")
        }
    }
    
    @IBAction func secondVideo(_ sender: Any) {
        // Second Video
        let youtubeURL = URL(string: "https://www.youtube.com/watch?v=hrZSfMly_Ck")!
        
        // Open the URL
        if UIApplication.shared.canOpenURL(youtubeURL) {
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL")
        }
    }
    
    @IBAction func thirdVideo(_ sender: Any) {
        //Third Video
        let youtubeURL = URL(string: "https://www.youtube.com/watch?v=HG68Ymazo18")!
        
        // Open the URL
        if UIApplication.shared.canOpenURL(youtubeURL) {
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
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
