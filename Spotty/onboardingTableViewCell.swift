//
//  onboardingTableViewCell.swift
//  Spotty
//
//  Created by David Krystall on 2/11/17.
//  Copyright © 2017 David Krystall. All rights reserved.
//

import UIKit

class onboardingTableViewCell: UITableViewCell {

    @IBOutlet var cellLeftLabel: UILabel!
    @IBOutlet var valueTextField: UITextField!
    var cellValue:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
