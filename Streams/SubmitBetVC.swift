//
//  SubmitBetViewController.swift
//  Streams
//
//  Created by James Cassidy on 4/15/19.
//  Copyright © 2019 James Cassidy. All rights reserved.
//

import UIKit
import Stripe

class SubmitBetVC: UIViewController {
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var oddsLabel: UILabel!
    @IBOutlet weak var overUnderPickLabel: UILabel!
    @IBOutlet weak var winningsLabel: UILabel!
    @IBOutlet weak var totalPayoutLabel: UILabel!
    @IBOutlet weak var betAmountField: UITextField!
    @IBOutlet weak var paymentButton: UIButton!
    
    var betAmount: String! = ""
    var odd: String!
    var pick: String!
    var prop: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Review"
        trackNameLabel.text = prop
        oddsLabel.text = odd
        overUnderPickLabel.text = pick
        betAmountField.delegate = self
        if betAmountField.text == "" {
            winningsLabel.text = ""
            totalPayoutLabel.text = ""
            betAmountField.addBorder(width: 0.5, radius: 5.0, color: .black)
        }
        updateUserInterface()
        
    }
    
    @IBAction func paymentButtonPressed(_ sender: Any) {
        
        let addCardViewController = STPAddCardViewController()
        addCardViewController.delegate = self
        navigationController?.pushViewController(addCardViewController, animated: true)
    }
    
    @IBAction func textFieldReturnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
        betAmount = betAmountField.text!
        updateUserInterface()
        betAmountField.text = ""
    }
    
    func updateUserInterface() {
        
        let roundedWinnings = ((((Double(betAmount) ?? 0) * (10/11)) * 100).rounded() / 100)
        let roundedPayout = ((((Double(betAmount) ?? 0) + roundedWinnings) * 100).rounded() / 100)
        
        winningsLabel.text = String(roundedWinnings)
        totalPayoutLabel.text = String(roundedPayout)
        
    }
    
}

extension SubmitBetVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension SubmitBetVC: STPAddCardViewControllerDelegate {
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        StripeClient.shared.completeCharge(with: token, amount: Int(betAmount) ?? 0) { result in
            switch result {
            // 1
            case .success:
                completion(nil)
                
                let alertController = UIAlertController(title: "Success", message: "Your Bet Has Been Placed!", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                })
                alertController.addAction(alertAction)
                self.present(alertController, animated: true)
            // 2
            case .failure(let error):
                completion(error)
            }
        }
    }
}
