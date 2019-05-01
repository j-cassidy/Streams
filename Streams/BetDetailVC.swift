//
//  BetDetailVC.swift
//  Streams
//
//  Created by James Cassidy on 4/15/19.
//  Copyright © 2019 James Cassidy. All rights reserved.
//

import UIKit

class BetDetailVC: UIViewController {
    

    @IBOutlet weak var streamsLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var betDetailTableView: UITableView!
    
    var prop: Prop!
    var odds = ["-110", "-110"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        streamsLabel.text = prop.streams.withCommas() + ".5"
        songLabel.text = prop.trackName
        artistLabel.text = prop.artistName
        
        betDetailTableView.delegate = self
        betDetailTableView.dataSource = self
        
        title = "Details"
    
    }
    
}

extension BetDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return odds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let overCell = tableView.dequeueReusableCell(withIdentifier: "overCell", for: indexPath) as! BetDetailTableViewCell
            overCell.configureOverCell(with: odds[indexPath.row])
            return overCell
        } else {
            let underCell = tableView.dequeueReusableCell(withIdentifier: "underCell", for: indexPath) as! BetDetailTableViewCell
            underCell.configueUnderCell(with: odds[indexPath.row])
            return underCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let submitBetVC = storyboard!.instantiateViewController(withIdentifier: "SubmitBetVC") as? SubmitBetVC else {
            return
            
        }
        
        submitBetVC.prop = songLabel.text
        submitBetVC.odd = odds[indexPath.row]
        submitBetVC.pick = ((indexPath.row == 0) ? "Over" : "Under")
        navigationController?.pushViewController(submitBetVC, animated: true)
    }
    
}

