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

class HomeViewController: UIViewController {
    @IBOutlet weak var homeTable: UITableView!
    @IBOutlet weak var syncGlucoseButton: UIButton!
    
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
        
        homeTable.rowHeight = UITableView.automaticDimension
        homeTable.estimatedRowHeight = 600
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
        homeTable.contentInset = insets
    }
    
    @IBAction func syncGlucose(_ sender: UIButton) {
        if let syncGlucoseView = syncGlucoseView {
            tabBarController?.view.addSubview(syncGlucoseView)
        } else {
            let syncGlucoseView = SyncGlucoseView.loadFromNibNamed("SyncGlucoseView", bundle: Bundle(for: self.classForCoder)) as! SyncGlucoseView
            syncGlucoseView.frame = UIScreen.main.bounds
            syncGlucoseView.delegate = self
            
            tabBarController?.view.addSubview(syncGlucoseView)
            self.syncGlucoseView = syncGlucoseView
        }
    }
    
    @IBAction func goToSettings(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Settings", bundle: Bundle(for: self.classForCoder))
        let settingsController = storyboard.instantiateViewController(withIdentifier: "SettingsView") as! SettingsViewController
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    func showGlucoseAchievementView() {
        if let glucoseAchievementView = glucoseAchievementView {
            tabBarController?.view.addSubview(glucoseAchievementView)
        } else {
            let glucoseAchievementView = GlucoseAchievementView.loadFromNibNamed("GlucoseAchievementView", bundle: Bundle(for: self.classForCoder)) as! GlucoseAchievementView
            glucoseAchievementView.frame = UIScreen.main.bounds
            glucoseAchievementView.delegate = self
            
            tabBarController?.view.addSubview(glucoseAchievementView)
            self.glucoseAchievementView = glucoseAchievementView
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
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
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeHeader") as! HomeHeaderCell
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeActionHeader") as! HomeActionHeaderCell
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeEmptyAction") as! HomeEmptyActionCell
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - GlucoseDelegate
extension HomeViewController: GlucoseDelegate {
    func showAchievement() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showGlucoseAchievementView()
        }
    }
}

// MARK: - GlucoseAchievementDelegate
extension HomeViewController: GlucoseAchievementDelegate {
    func completeAchievement() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let currentUser = UserManager.getUser()
        guard currentUser == USER_1 else { return }
        
        ref.child("achievement").child("unlocked").setValue(true)
    }
}
