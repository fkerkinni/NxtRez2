//
//  ReservationTableViewCell.swift
//  NxtRez2
//
//  Created by Fuat on 5/15/17.
//  Copyright © 2017 Joseph K. All rights reserved.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {
    
    //Properties
    @IBOutlet weak var nameLabel:  UILabel!
    @IBOutlet weak var rDateLabel: UILabel!
    @IBOutlet weak var rTimeLabel: UILabel!
    @IBOutlet weak var guestLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // add more code for init
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
