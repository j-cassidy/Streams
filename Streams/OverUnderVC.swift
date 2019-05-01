//
//  OverUnderVC.swift
//  Streams
//
//  Created by James Cassidy on 4/15/19.
//  Copyright © 2019 James Cassidy. All rights reserved.
//

import UIKit

class OverUnderVC: UIViewController {
    
    
    @IBOutlet weak var overUnderTableView: UITableView!
    
    var propFinder = PropFinder()
    var country: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Available Props"
        
        overUnderTableView.delegate = self
        overUnderTableView.dataSource = self
        
        propFinder.getProps(countrySelection: country) { _ in
            self.overUnderTableView.reloadData()
        }
        
    }
    
}

extension OverUnderVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propFinder.charts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "overUnderCell", for: indexPath) as! OverUnderTableViewCell
        let prop = propFinder.charts?[indexPath.row]
        cell.configure(with: prop!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let betDetailVC = storyboard!.instantiateViewController(withIdentifier: "BetDetailVC") as? BetDetailVC else {
            return
            
        }
        betDetailVC.prop = propFinder.charts?[indexPath.row]
        navigationController?.pushViewController(betDetailVC, animated: true)
    }
    
}


