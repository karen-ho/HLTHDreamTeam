//
//  LaunchViewController.swift
//  HLTH
//
//  Created by Karen Ho on 10/26/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tabStoryboard = UIStoryboard(name: "Tab", bundle: Bundle(for: self.classForCoder))
        let tabController = tabStoryboard.instantiateViewController(withIdentifier: "TabView") as! TabViewController
        UIApplication.shared.keyWindow?.rootViewController = tabController
    }
}

