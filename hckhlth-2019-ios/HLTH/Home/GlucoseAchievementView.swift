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
    @IBOutlet weak var achievementView: UIView!
    @IBOutlet weak var overlayView: UIView!
    
    var delegate: GlucoseAchievementDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shareButton.layer.cornerRadius = shareButton.frame.height / 2.0
    }
    
    @IBAction func close(_ sender: UIButton) {
        close()
    }
    
    @IBAction func ok(_ sender: UIButton) {
        close()
    }
    
    func close() {
        delegate?.completeAchievement()
        overlayView.alpha = 1
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.achievementView.center.y += self.achievementView.frame.height
            self.overlayView.alpha = 0
        }) { (completed) in
            self.overlayView.alpha = 1
            self.removeFromSuperview()
        }
    }
}
