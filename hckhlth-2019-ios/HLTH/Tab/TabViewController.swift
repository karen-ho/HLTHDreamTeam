//
//  TabViewController.swift
//  HLTH
//
//  Created by Karen Ho on 10/26/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

class TabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeStoryboard = UIStoryboard(name: "Home", bundle: Bundle(for: self.classForCoder))
        let homeController = homeStoryboard.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
        let homeNavController = UINavigationController(rootViewController: homeController)
        homeNavController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "star"), selectedImage: UIImage(named: "star"))
        
        let myHealthStoryboard = UIStoryboard(name: "MyHealth", bundle: Bundle(for: self.classForCoder))
        let myHealthController = myHealthStoryboard.instantiateViewController(withIdentifier: "MyHealthView") as! MyHealthViewController
        let myHealthNavController = UINavigationController(rootViewController: myHealthController)
        myHealthNavController.tabBarItem = UITabBarItem(title: "MyHealth", image: UIImage(named: "star"), selectedImage: UIImage(named: "star"))
        
        let messagesStoryboard = UIStoryboard(name: "Messages", bundle: Bundle(for: self.classForCoder))
        let messagesController = messagesStoryboard.instantiateViewController(withIdentifier: "MessagesView") as! MessagesViewController
        let messagesNavController = UINavigationController(rootViewController: messagesController)
        messagesNavController.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "star"), selectedImage: UIImage(named: "star"))
        
        let communityStoryboard = UIStoryboard(name: "Community", bundle: Bundle(for: self.classForCoder))
        let communityController = communityStoryboard.instantiateViewController(withIdentifier: "CommunityView") as! CommunityViewController
        let communityNavController = UINavigationController(rootViewController: communityController)
        communityNavController.tabBarItem = UITabBarItem(title: "Community", image: UIImage(named: "star"), selectedImage: UIImage(named: "star"))
        
        viewControllers = [homeNavController, myHealthNavController, messagesNavController, communityNavController]
    }
}
