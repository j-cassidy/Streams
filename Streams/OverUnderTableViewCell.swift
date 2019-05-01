//
//  OverUnderTableViewCell.swift
//  Streams
//
//  Created by James Cassidy on 4/15/19.
//  Copyright © 2019 James Cassidy. All rights reserved.
//

import UIKit

class OverUnderTableViewCell: UITableViewCell {

    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var playCountLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with prop: Prop) {
        songNameLabel.text = prop.trackName
        artistNameLabel.text = prop.artistName
        playCountLabel.text = "O/U: " + prop.streams.withCommas() + ".5" + " streams"
    }

}
