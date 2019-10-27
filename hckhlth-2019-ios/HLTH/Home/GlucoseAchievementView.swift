//
//  GlucoseAchievementView.swift
//  HLTH
//
//  Created by Karen Ho on 10/27/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

protocol GlucoseAchievementDelegate {
    func completeAchievement()
}

class GlucoseAchievementView: UIView {
    @IBOutlet weak var shareButton: UIButton!
    
    var delegate: GlucoseAchievementDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shareButton.layer.cornerRadius = shareButton.frame.height / 2.0
    }
    
    @IBAction func close(_ sender: UIButton) {
        delegate?.completeAchievement()
        removeFromSuperview()
    }
    
    @IBAction func ok(_ sender: UIButton) {
        delegate?.completeAchievement()
        removeFromSuperview()
    }
}
