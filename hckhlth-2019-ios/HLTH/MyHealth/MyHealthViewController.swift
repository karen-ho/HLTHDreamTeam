//
//  MyHealthViewController.swift
//  HLTH
//
//  Created by Karen Ho on 10/26/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class MyHealthViewController: UIViewController {
    @IBOutlet weak var healthTable: UITableView!
    @IBOutlet weak var doctorNotificationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle(for: self.classForCoder)
        let averageGraphNib = UINib(nibName: "AverageGraphCell", bundle: bundle)
        healthTable.register(averageGraphNib, forCellReuseIdentifier: "averageGraph")
        
        healthTable.rowHeight = UITableView.automaticDimension
        healthTable.estimatedRowHeight = 600
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let currentUser = UserManager.getUser()
        ref.child("doctor").child("notification").observe(.value) { (snapshot) in
            guard currentUser == USER_1 else { return }
            if let value = snapshot.value as? Bool, value == true {
                DispatchQueue.main.async {
                    self.doctorNotificationView.center.y -= self.doctorNotificationView.frame.height
                    self.doctorNotificationView.isHidden = false
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                        self.doctorNotificationView.center.y += self.doctorNotificationView.frame.height
                    }, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self.doctorNotificationView.isHidden = true
                }
            }
        }
    }
    
    @IBAction func goToMessage(_ sender: UIButton) {
        HAS_ACTION_ITEMS = true
        
        let storyboard = UIStoryboard(name: "DoctorMessage", bundle: Bundle(for: self.classForCoder))
        let doctorMessageViewController = storyboard.instantiateViewController(withIdentifier: "DoctorMessageView") as! DoctorMessageViewController
        navigationController?.pushViewController(doctorMessageViewController, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension MyHealthViewController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource
extension MyHealthViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "averageGraph") as! AverageGraphCell
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}
