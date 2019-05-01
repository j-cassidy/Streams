//
//  betDetailTableViewCell.swift
//  Streams
//
//  Created by James Cassidy on 4/15/19.
//  Copyright © 2019 James Cassidy. All rights reserved.
//

import UIKit

class BetDetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var overOddsLabel: UILabel!
    @IBOutlet weak var underOddsLabel: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureOverCell(with: String) {
        overOddsLabel.text = "-110"
    }
    func configueUnderCell(with: String) {
        underOddsLabel.text = "-110"
    }

}
