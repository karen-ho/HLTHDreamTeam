//
//  HomeViewController.swift
//  HLTH
//
//  Created by Karen Ho on 10/26/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var homeTable: UITableView!
    @IBOutlet weak var syncGlucoseButton: UIButton!
    
    var syncGlucoseView: SyncGlucoseView?
    var glucoseAchievementView: GlucoseAchievementView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func showGlucoseAchievementView() {
        if let glucoseAchievementView = glucoseAchievementView {
            tabBarController?.view.addSubview(glucoseAchievementView)
        } else {
            let glucoseAchievementView = GlucoseAchievementView.loadFromNibNamed("GlucoseAchievementView", bundle: Bundle(for: self.classForCoder)) as! GlucoseAchievementView
            glucoseAchievementView.frame = UIScreen.main.bounds
            
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
        return 2
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
        return UITableViewCell()
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
