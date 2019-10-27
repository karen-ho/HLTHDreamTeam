//
//  HomeViewController.swift
//  HLTH
//
//  Created by Karen Ho on 10/26/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

var HAS_ENTERED_GLUCOSE = false
var HAS_ACTION_ITEMS = false

class HomeViewController: UIViewController {
    @IBOutlet weak var homeTable: UITableView!
    @IBOutlet weak var syncGlucoseButton: UIButton!
    @IBOutlet weak var friendNotificationView: UIView!
    
    var syncGlucoseView: SyncGlucoseView?
    var glucoseAchievementView: GlucoseAchievementView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle(for: self.classForCoder)
        let homeHeaderNib = UINib(nibName: "HomeHeaderCell", bundle: bundle)
        homeTable.register(homeHeaderNib, forCellReuseIdentifier: "homeHeader")
        
        let homeGraphNib = UINib(nibName: "HomeGraphCell", bundle: bundle)
        homeTable.register(homeGraphNib, forCellReuseIdentifier: "homeGraph")
        
        let homeActionHeaderNib = UINib(nibName: "HomeActionHeaderCell", bundle: bundle)
        homeTable.register(homeActionHeaderNib, forCellReuseIdentifier: "homeActionHeader")
        
        let homeEmptyActionNib = UINib(nibName: "HomeEmptyActionCell", bundle: bundle)
        homeTable.register(homeEmptyActionNib, forCellReuseIdentifier: "homeEmptyAction")
        
        let homeActionNib = UINib(nibName: "HomeActionCell", bundle: bundle)
        homeTable.register(homeActionNib, forCellReuseIdentifier: "homeAction")
        
        homeTable.rowHeight = UITableView.automaticDimension
        homeTable.estimatedRowHeight = 600
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let currentUser = UserManager.getUser()
        ref.child("achievement").child("liked").observe(.value) { (snapshot) in
            guard currentUser == USER_1 else { return }
            if let value = snapshot.value as? Bool, value == true {
                DispatchQueue.main.async {
                    self.friendNotificationView.center.y -= self.friendNotificationView.frame.height
                    self.friendNotificationView.isHidden = false
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                        self.friendNotificationView.center.y += self.friendNotificationView.frame.height
                    }, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self.friendNotificationView.isHidden = true
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        homeTable.reloadData()
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        if HAS_ACTION_ITEMS {
            ref.child("doctor").child("read").removeValue()
        }
    }
    
    @IBAction func syncGlucose(_ sender: UIButton) {
        if let syncGlucoseView = syncGlucoseView {
            syncGlucoseView.logView.center.y += syncGlucoseView.logView.frame.height
            syncGlucoseView.overlayView.backgroundColor = UIColor.clear
            tabBarController?.view.addSubview(syncGlucoseView)
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
                syncGlucoseView.logView.center.y -= syncGlucoseView.logView.frame.height
                syncGlucoseView.backgroundColor = UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 0.8)
            }) { (completion) in
            }
        } else {
            let syncGlucoseView = SyncGlucoseView.loadFromNibNamed("SyncGlucoseView", bundle: Bundle(for: self.classForCoder)) as! SyncGlucoseView
            syncGlucoseView.frame = UIScreen.main.bounds
            syncGlucoseView.delegate = self
            
            syncGlucoseView.logView.center.y += syncGlucoseView.logView.frame.height
            syncGlucoseView.overlayView.backgroundColor = UIColor.clear
            tabBarController?.view.addSubview(syncGlucoseView)
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
                syncGlucoseView.logView.center.y -= syncGlucoseView.logView.frame.height
                syncGlucoseView.backgroundColor = UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 0.8)
            }) { (completion) in
            }
            
            self.syncGlucoseView = syncGlucoseView
        }
    }
    
    @IBAction func goToSettings(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Settings", bundle: Bundle(for: self.classForCoder))
        let settingsController = storyboard.instantiateViewController(withIdentifier: "SettingsView") as! SettingsViewController
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    @IBAction func closeNotification(_ sender: UIButton) {
        friendNotificationView.isHidden = true
    }
    
    func showGlucoseAchievementView() {
        if let glucoseAchievementView = glucoseAchievementView {
            tabBarController?.view.addSubview(glucoseAchievementView)
            glucoseAchievementView.animate()
        } else {
            let glucoseAchievementView = GlucoseAchievementView.loadFromNibNamed("GlucoseAchievementView", bundle: Bundle(for: self.classForCoder)) as! GlucoseAchievementView
            glucoseAchievementView.frame = UIScreen.main.bounds
            glucoseAchievementView.delegate = self
            
            tabBarController?.view.addSubview(glucoseAchievementView)
            glucoseAchievementView.animate()
            self.glucoseAchievementView = glucoseAchievementView
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if HAS_ACTION_ITEMS && indexPath.section == 3 {
            let storyboard = UIStoryboard(name: "Schedule", bundle: Bundle(for: self.classForCoder))
            let scheduleViewController = storyboard.instantiateViewController(withIdentifier: "ScheduleView") as! ScheduleViewController
            navigationController?.pushViewController(scheduleViewController, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeGraph") as! HomeGraphCell
            cell.selectionStyle = .none
            cell.graphImage.image = HAS_ENTERED_GLUCOSE ? UIImage(named: "graph2") : UIImage(named: "graph1")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeHeader") as! HomeHeaderCell
            cell.selectionStyle = .none
            cell.averageLabel.text = HAS_ENTERED_GLUCOSE ? "154" : "167"
            cell.deviationLabel.text = HAS_ENTERED_GLUCOSE ? "±96" : "±83"
            cell.hypersLabel.text = HAS_ENTERED_GLUCOSE ? "28%" : "33%"
            cell.hyposLabel.text = HAS_ENTERED_GLUCOSE ? "14%" : "17%"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeActionHeader") as! HomeActionHeaderCell
            cell.selectionStyle = .none
            cell.actionLabel.text = HAS_ACTION_ITEMS ? "1 Action Item" : "0 Action Items"
            cell.flagImage.image = cell.flagImage.image?.withRenderingMode(.alwaysTemplate)
            cell.tintColor = HAS_ACTION_ITEMS ? TEAL : UIColor.black
            return cell
        case 3:
            if HAS_ACTION_ITEMS {
                let cell = tableView.dequeueReusableCell(withIdentifier: "homeAction") as! HomeActionCell
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "homeEmptyAction") as! HomeEmptyActionCell
                cell.selectionStyle = .none
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - GlucoseDelegate
extension HomeViewController: GlucoseDelegate {
    func showAchievement() {
        showGlucoseAchievementView()
    }
}

// MARK: - GlucoseAchievementDelegate
extension HomeViewController: GlucoseAchievementDelegate {
    func completeAchievement() {
        HAS_ENTERED_GLUCOSE = true
        homeTable.reloadData()
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let currentUser = UserManager.getUser()
        guard currentUser == USER_1 else { return }
        
        ref.child("achievement").child("unlocked").setValue(true)
    }
}
