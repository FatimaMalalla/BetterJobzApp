//
//  CustomSegue.swift
//  BetterJobz
//
//  Created by BP-36-201-01 on 24/11/2024.
//

import UIKit

class CustomSegue: UIStoryboardSegue {

        override func perform() {
            // Access the source and destination views
            guard let sourceView = self.source.view,
                  let destinationView = self.destination.view else {
                return
            }

            // Add destination view as a subview temporarily
            if let window = sourceView.window {
                window.insertSubview(destinationView, aboveSubview: sourceView)
            }

            // Set the initial position of the destination view
            destinationView.transform = CGAffineTransform(translationX: sourceView.frame.width, y: 0)

            // Animate the transition
            UIView.animate(withDuration: 0.5, animations: {
                sourceView.transform = CGAffineTransform(translationX: -sourceView.frame.width, y: 0)
                destinationView.transform = .identity
            }, completion: { finished in
                // Reset transformations and present the destination view controller
                sourceView.transform = .identity
                self.source.present(self.destination, animated: false, completion: nil)
            })
        }
    }


