//
//  DoctorMessageViewController.swift
//  HLTH
//
//  Created by Karen Ho on 10/27/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class DoctorMessageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("doctor").child("read").setValue(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
