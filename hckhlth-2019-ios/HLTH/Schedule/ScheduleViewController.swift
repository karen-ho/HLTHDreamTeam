//
//  ScheduleViewController.swift
//  HLTH
//
//  Created by Karen Ho on 10/27/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

class ScheduleViewController: UIViewController {
    @IBOutlet weak var scheduleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleButton.layer.cornerRadius = scheduleButton.frame.height / 2.0
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
