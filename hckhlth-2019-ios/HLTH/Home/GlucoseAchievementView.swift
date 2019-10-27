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
    @IBOutlet weak var achievementImage: UIImageView!
    
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
    
    func animate() {
//        achievementImage.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
//        UIView.animate(withDuration: 2.0,
//        delay: 0,
//        usingSpringWithDamping: 1.0,
//        initialSpringVelocity: 2.0,
//        options: .allowUserInteraction,
//        animations: {
//            self.achievementImage.transform = .identity
//        },
//        completion: nil)
    }
    
    func close() {
        delegate?.completeAchievement()
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.achievementView.center.y += self.achievementView.frame.height
            self.overlayView.backgroundColor = UIColor.clear
        }) { (completed) in
            self.overlayView.backgroundColor = UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 0.8)
            self.removeFromSuperview()
        }
    }
}
