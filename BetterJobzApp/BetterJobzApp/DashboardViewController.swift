//
//  DashboardViewController.swift
//  BetterJobzApp
//
//  Created by BP-36-201-07 on 26/11/2024.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController {
    var username: String? // Optional property to pass data

    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle passed data or setup here
        print("Logged in user: \(username ?? "Unknown User")")
    }
}
