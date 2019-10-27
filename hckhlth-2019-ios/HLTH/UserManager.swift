//
//  UserManager.swift
//  HLTH
//
//  Created by Karen Ho on 10/27/19.
//  Copyright © 2019 Karen Ho. All rights reserved.
//

import Foundation

class UserManager {
    static func getUser() -> String {
        if let currentUser = UserDefaults.standard.string(forKey: CURRENT_USER) {
            return currentUser
        }
        
        return USER_1
    }
}
