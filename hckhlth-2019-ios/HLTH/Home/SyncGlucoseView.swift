//
//  SyncGlucoseView.swift
//  HLTH
//
//  Created by Karen Ho on 10/26/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation
import UIKit

protocol GlucoseDelegate {
    func showAchievement()
}

class SyncGlucoseView: UIView {
    @IBOutlet weak var syncButton: UIButton!
    @IBOutlet weak var glucoseLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var logView: UIView!
    @IBOutlet weak var overlayView: UIView!
    
    var delegate: GlucoseDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        spinner.hidesWhenStopped = true
        syncButton.isHidden = false
        spinner.isHidden = true
        glucoseLabel.isHidden = true
        
        syncButton.layer.cornerRadius = syncButton.frame.height / 2.0
        saveButton.layer.cornerRadius = saveButton.frame.height / 2.0
    }
    
    @IBAction func sync(_ sender: UIButton) {
        syncButton.isHidden = true
        spinner.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.spinner.stopAnimating()
            self.glucoseLabel.isHidden = false
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        super.removeFromSuperview()
        
        delegate?.showAchievement()
    }
    
    @IBAction func save(_ sender: UIButton) {
        super.removeFromSuperview()
        
        delegate?.showAchievement()
    }
}
