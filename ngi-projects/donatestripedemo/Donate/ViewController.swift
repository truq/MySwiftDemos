//
//  ViewController.swift
//  Donate
//
//  Created by NGI-NOMAN on 1/2/16.
//  Copyright (c) 2016  NGI-NOMAN. All rights reserved.
//

import UIKit

class ViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expireDateTextField: UITextField!
    @IBOutlet weak var cvcTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet var textFields: [UITextField]!
    
    // MARK: - Text field delegate 
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        return true
    }
    
    
    // MARK: Actions
    
    @IBAction func donate(sender: AnyObject) {
        // Initiate the card
        var stripCard = STPCard()
        
        // Split the expiration date to extract Month & Year
        if self.expireDateTextField.text!.isEmpty == false {
            let expirationDate = self.expireDateTextField.text!.componentsSeparatedByString("/")
            let expMonth = UInt(Int(expirationDate[0])!)
            let expYear = UInt(Int(expirationDate[1])!)
            
            // Send the card info to Strip to get the token
            stripCard.number = self.cardNumberTextField.text
            stripCard.cvc = self.cvcTextField.text
            stripCard.expMonth = expMonth
            stripCard.expYear = expYear
        }
    
        var underlyingError: NSError?
        do {
            try stripCard.validateCardReturningError()
        } catch var error as NSError {
            underlyingError = error
        }
        if underlyingError != nil {
            self.spinner.stopAnimating()
            self.handleError(underlyingError!)
            return
        }
        
        STPAPIClient.sharedClient().createTokenWithCard(stripCard, completion: { (token, error) -> Void in
            
            if error != nil {
                self.handleError(error!)
                return
            }
            
            self.postStripeToken(token!)
        })
    }
    
    func handleError(error: NSError) {
        print(error)
        UIAlertView(title: "Please Try Again",
            message: error.localizedDescription,
            delegate: nil,
            cancelButtonTitle: "OK").show()
        
    }
    
    func postStripeToken(token: STPToken) {
        
        let URL = "http://localhost/donate/payment.php"
        let params = ["stripeToken": token.tokenId,
            "amount": self.amountTextField.text!,
            "currency": "usd",
            "description": self.emailTextField.text!]
        
        let manager = AFHTTPRequestOperationManager()
        manager.POST(URL, parameters: params, success: { (operation, responseObject) -> Void in
            
            if let response = responseObject as? [String: String] {
                UIAlertView(title: response["status"],
                    message: response["message"],
                    delegate: nil,
                    cancelButtonTitle: "OK").show()
            }
            
            }) { (operation, error) -> Void in
                self.handleError(error!)
        }
    }
}

