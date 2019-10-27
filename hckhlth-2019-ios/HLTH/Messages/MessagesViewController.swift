//
//  MessagesViewController.swift
//  HLTH
//
//  Created by Karen Ho on 10/26/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class MessagesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showBeginningNotification(_ sender: UIButton) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let currentUser = UserManager.getUser()
        if currentUser == USER_2 {
            ref.child("start").child("record").setValue(true)
        }
    }
}
