//
//  ViewController.swift
//  BetterJobz
//
//  Created by BP-36-201-02 on 24/11/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        
        // Set the gradient colors
        gradientLayer.colors = [
            UIColor(red: 0.06, green: 0.14, blue: 0.25, alpha: 1.0).cgColor, // #10233F
            UIColor(red: 0.16, green: 0.35, blue: 0.63, alpha: 1.0).cgColor  // #2A5AA1
        ]
        
        // Set the gradient direction (top to bottom)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0) // Top-center
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)   // Bottom-center
        
        // Set the gradient frame to match the view's bounds
        gradientLayer.frame = view.bounds
        
        // Add the gradient layer to the view
        view.layer.insertSublayer(gradientLayer, at: 0)
    }


}

