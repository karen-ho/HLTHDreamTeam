//
//  DoctorMessageViewController.swift
//  HLTH
//
//  Created by Karen Ho on 10/27/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

class DoctorMessageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
