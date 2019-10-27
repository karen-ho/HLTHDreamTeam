//
//  HomeActionCell.swift
//  HLTH
//
//  Created by Karen Ho on 10/27/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

class HomeActionCell: UITableViewCell {
    @IBOutlet weak var newButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newButton.layer.cornerRadius = newButton.frame.height / 2.0
    }
}
