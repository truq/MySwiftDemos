//
//  ViewController.swift
//  FacebookDemo
//
//  Created by NGI-NOMAN on 10/29/15.
//  Copyright © 2015 NGI-NOMAN. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit

class ViewController: UIViewController,FBSDKLoginButtonDelegate,FBSDKSharingDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
            
            print(result.grantedPermissions.contains("email"))
            print(result.grantedPermissions)
            //[email, contact_email, user_friends, public_profile] granted permission
            let content = FBSDKShareLinkContent()
            content.contentURL = NSURL(fileURLWithPath: "www.nextgeni.com")
//            FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
//            content.contentURL = [NSURL URLWithString:shareString];
            
            dispatch_async(dispatch_get_main_queue(), {
                
                let dialog = FBSDKShareDialog()
                if UIApplication.sharedApplication().canOpenURL(NSURL(fileURLWithPath: "fbauth2://")){
                    dialog.mode = FBSDKShareDialogMode.Native
                }
                else{
                    dialog.mode = FBSDKShareDialogMode.Browser
                }
                dialog.shareContent=content
                dialog.delegate = self
                dialog.fromViewController = self
                dialog.show()
                
            })
            

        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print("User Email is: \(userEmail)")
            }
        })
    }
    
    
//    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
//        print("User Logged In")
//    }
//    
//    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
//        println("User: \(user)")
//        println("User ID: \(user.objectID)")
//        println("User Name: \(user.name)")
//        var userEmail = user.objectForKey("email") as String
//        println("User Email: \(userEmail)")
//    }
//    
//    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
//        print("User Logged Out")
//    }
//    
//    func loginView(loginView : FBLoginView!, handleError:NSError) {
//        print("Error: \(handleError.localizedDescription)")
//    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        //
    }
    func sharerDidCancel(sharer: FBSDKSharing!) {
        //
    }
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        //
    }


}

