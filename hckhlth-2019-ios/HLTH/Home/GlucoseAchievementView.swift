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
    var delegate: GlucoseAchievementDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
