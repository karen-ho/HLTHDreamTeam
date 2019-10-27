//
//  CommunityViewController.swift
//  HLTH
//
//  Created by Karen Ho on 10/26/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

var HAS_LIKED = false

class CommunityViewController: UIViewController {
    @IBOutlet weak var communityTable: UITableView!
    
    var communityEvents: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle(for: self.classForCoder)
        let communityNib = UINib(nibName: "CommunityCell", bundle: bundle)
        communityTable.register(communityNib, forCellReuseIdentifier: "community")
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let currentUser = UserManager.getUser()
        
        ref.child("achievement").child("unlocked").observe(.value) { (snapshot) in
            guard currentUser == USER_2 else { return }
            if let value = snapshot.value as? Bool, value == true {
                DispatchQueue.main.async {
                    self.communityEvents.append("YAY")
                    self.communityTable.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
                }
            } else {
                DispatchQueue.main.async {
                    self.communityEvents.removeAll()
                    self.communityTable.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension CommunityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let currentUser = UserManager.getUser()
        
        if indexPath.section == 0 && indexPath.row == 0 && currentUser == USER_2 {
            ref.child("achievement").child("liked").setValue(true)
            HAS_LIKED = true
            communityTable.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension CommunityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communityEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "community") as! CommunityCell
        cell.selectionStyle = .none
        cell.likeImage.image = HAS_LIKED ? UIImage(named: "liked") : UIImage(named: "like")
        return cell
    }
    
}
