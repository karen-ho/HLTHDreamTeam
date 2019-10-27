//
//  HealthSummaryCell.swift
//  HLTH
//
//  Created by Karen Ho on 10/27/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

class HealthSummaryCell: UITableViewCell {
    @IBOutlet weak var starView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        starView.layer.cornerRadius = 10.0
    }
}
