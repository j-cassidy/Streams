//
//  Prop.swift
//  Streams
//
//  Created by James Cassidy on 4/15/19.
//  Copyright © 2019 James Cassidy. All rights reserved.
//

import Foundation

class Prop {
    
    let trackName: String
    let artistName: String
    let position: Int
    let streams: Int
    
    
    required init(trackName: String, artistName: String, position: Int, streams: Int) {
        self.trackName = trackName
        self.artistName = artistName
        self.position = position
        self.streams = streams
    }

}

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

