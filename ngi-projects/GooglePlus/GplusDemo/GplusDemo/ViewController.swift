//
//  ViewController.swift
//  GplusDemo
//
//  Created by NGI-NOMAN on 10/30/15.
//  Copyright © 2015 NGI-NOMAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController,GPPSignInDelegate {

      var signIn : GPPSignIn?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapOnLoginButton(sender: AnyObject) {
        
        // Check or Make Authentication WIth G+
        
        if (signIn?.authenticate() != nil){
            
        }
        
        signIn = GPPSignIn.sharedInstance()
        signIn?.shouldFetchGooglePlusUser = true
        signIn?.shouldFetchGoogleUserEmail = true
        signIn?.shouldFetchGoogleUserID = true
        signIn?.clientID = "655702833611-n53s4dnjht7r81372qn182ga645b1ner.apps.googleusercontent.com"
        signIn?.scopes = [kGTLAuthScopePlusLogin]
        signIn?.delegate = self
        signIn?.authenticate()
        
    }
    
    
    //MARK: G+
    func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
        
        //MARK : Google Plus Sharing
        
//        print("Google Plus Authentication %@" , auth)
//        
//        if ((error) != nil) {
//            // Do some error handling here.
//        } else {
//            
//            _ = GPPSignIn.sharedInstance().homeServerAuthorizationCode
//        }
//        
//        let shareBuilder  : GPPNativeShareBuilder = GPPShare.sharedInstance().nativeShareDialog()
//        shareBuilder.setURLToShare(NSURL(fileURLWithPath: "" ))
//        shareBuilder.setPrefillText("")
//        shareBuilder.open()
        
        print("received auth \(auth), error \(error)")
        
        if (GPPSignIn.sharedInstance().userID != nil) {
            let user = GPPSignIn.sharedInstance().googlePlusUser
            print("user name: " + user.name.JSONString() + "\nemail: ")
            if (user.emails != nil){
                print(user.emails.first?.JSONString() ?? "no email")
            } else {
                print("no email")
            }
        } else {
            print("User ID is nil")
        }
        
    }

}

