//
//  Reservation.swift
//  NxtRez2
//
//  Created by Fuat on 5/15/17.
//  Copyright © 2017 Joseph K. All rights reserved.
//

import UIKit

// Main Class for now holds only 4 attributes
class Reservation {
    
    var name: String
    var rDate: String
    var rTime: String
    var guest: String
    var completed = false
    
    init?(name: String, rDate: String, rTime: String, guest: String) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        guard !rDate.isEmpty else {
            return nil
        }
        
        guard !rTime.isEmpty else {
            return nil
        }
        
        guard !guest.isEmpty else {
            return nil
        }
        
        
        // Initialize stored properties.
        self.name    = name    // first name last name
        self.rDate   = rDate   // rezDate
        self.rTime   = rTime   // time of rez
        self.guest   = guest   // nbr of guest
    }
}
