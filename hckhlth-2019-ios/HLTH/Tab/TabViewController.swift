//
//  TabViewController.swift
//  HLTH
//
//  Created by Karen Ho on 10/26/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

let TEAL = UIColor(red: 0.00, green: 0.59, blue: 0.81, alpha:1.0)

class TabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeStoryboard = UIStoryboard(name: "Home", bundle: Bundle(for: self.classForCoder))
        let homeController = homeStoryboard.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
        let homeNavController = UINavigationController(rootViewController: homeController)
        homeNavController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        
        let myHealthStoryboard = UIStoryboard(name: "MyHealth", bundle: Bundle(for: self.classForCoder))
        let myHealthController = myHealthStoryboard.instantiateViewController(withIdentifier: "MyHealthView") as! MyHealthViewController
        let myHealthNavController = UINavigationController(rootViewController: myHealthController)
        myHealthNavController.tabBarItem = UITabBarItem(title: "My Health", image: UIImage(named: "person"), selectedImage: UIImage(named: "person"))
        
        let messagesStoryboard = UIStoryboard(name: "Messages", bundle: Bundle(for: self.classForCoder))
        let messagesController = messagesStoryboard.instantiateViewController(withIdentifier: "MessagesView") as! MessagesViewController
        let messagesNavController = UINavigationController(rootViewController: messagesController)
        messagesNavController.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "messages"), selectedImage: UIImage(named: "messages"))
        
        let communityStoryboard = UIStoryboard(name: "Community", bundle: Bundle(for: self.classForCoder))
        let communityController = communityStoryboard.instantiateViewController(withIdentifier: "CommunityView") as! CommunityViewController
        let communityNavController = UINavigationController(rootViewController: communityController)
        communityNavController.tabBarItem = UITabBarItem(title: "Community", image: UIImage(named: "community"), selectedImage: UIImage(named: "community"))
        
        viewControllers = [homeNavController, myHealthNavController, messagesNavController, communityNavController]
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let currentUser = UserManager.getUser()
        ref.child("achievement").child("liked").observe(.value) { (snapshot) in
            guard currentUser == USER_1 else { return }
            if let value = snapshot.value as? Bool, value == true {
                DispatchQueue.main.async {
                    if let communityTab = self.tabBar.items?[3] {
                        communityTab.badgeColor = TEAL
                        communityTab.badgeValue = "1"
                    }
                }
            } else {
                if let communityTab = self.tabBar.items?[3] {
                    communityTab.badgeValue = nil
                }
            }
        }
        
        ref.child("achievement").child("unlocked").observe(.value) { (snapshot) in
            guard currentUser == USER_2 else { return }
            if let value = snapshot.value as? Bool, value == true {
                DispatchQueue.main.async {
                    if let communityTab = self.tabBar.items?[3] {
                        communityTab.badgeColor = TEAL
                        communityTab.badgeValue = "1"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    if let communityTab = self.tabBar.items?[3] {
                        communityTab.badgeValue = nil
                    }
                }
            }
        }
        
        ref.child("doctor").child("notification").observe(.value) { (snapshot) in
            guard currentUser == USER_1 else { return }
            if let value = snapshot.value as? Bool, value == true {
                DispatchQueue.main.async {
                    if let communityTab = self.tabBar.items?[2] {
                        communityTab.badgeColor = TEAL
                        communityTab.badgeValue = "1"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    if let communityTab = self.tabBar.items?[2] {
                        communityTab.badgeValue = nil
                    }
                }
            }
        }
        
        ref.child("doctor").child("read").observe(.value) { (snapshot) in
            guard currentUser == USER_1 else { return }
            if let value = snapshot.value as? Bool, value == true {
                DispatchQueue.main.async {
                    if let communityTab = self.tabBar.items?[0] {
                        communityTab.badgeColor = TEAL
                        communityTab.badgeValue = "1"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    if let communityTab = self.tabBar.items?[0] {
                        communityTab.badgeValue = nil
                    }
                }
            }
        }
    }
}
