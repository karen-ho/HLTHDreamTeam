//
//  SettingsViewController.swift
//  HLTH
//
//  Created by Karen Ho on 10/27/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

let USER_1: String = "USER 1"
let USER_2: String = "USER 2"
let CURRENT_USER: String = "CURRENT_USER"

class SettingsViewController: UIViewController {
    @IBOutlet weak var currentUserLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = UserDefaults.standard.string(forKey: CURRENT_USER) {
            currentUserLabel.text = "\(currentUser)"
        } else {
            UserDefaults.standard.set(USER_1, forKey: CURRENT_USER)
            currentUserLabel.text = "\(USER_1)"
        }
    }
    
    @IBAction func switchUser(_ sender: UIButton) {
        if let currentUser = UserDefaults.standard.string(forKey: CURRENT_USER) {
            let newUser = currentUser == USER_1 ? USER_2 : USER_1
            UserDefaults.standard.set(newUser, forKey: CURRENT_USER)
            currentUserLabel.text = "\(newUser)"
        }
    }
}
