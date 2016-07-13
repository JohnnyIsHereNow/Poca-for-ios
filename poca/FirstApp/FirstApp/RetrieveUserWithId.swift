//
//  RetrieveUserWithId.swift
//  POCA
//
//  Created by Alexandru Draghi on 10/06/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class RetrieveUserWithId: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func retriveUser(userID:Int) -> User
    {
        let user = User()
        var newString = ""
        do {
            let post:NSString = "userID=\(userID)"
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string:"http://angelicapp.com/POCA/jsonGetUserById.php")!
            
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            
            let postLength:NSString = String( postData.length )
            
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData?
            do
            {
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            }
            catch let error as NSError
            {
                reponseError = error
                urlData = nil
            }
            
            if ( urlData != nil )
            {
                let res = response as! NSHTTPURLResponse!;
                
                //NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    newString = responseData.substringFromIndex(0)
                    let newStringArr = newString.componentsSeparatedByString("+")
                    print(newStringArr)
                    if newStringArr.count != 0
                    {
                    user.Name = newStringArr[0]
                    user.Email = newStringArr[1]
                    user.Username = newStringArr[2]
                    user.passion1 = Int(newStringArr[4]) as Int!
                    user.passion2 = Int(newStringArr[5]) as Int!
                    user.passion3 = Int(newStringArr[6]) as Int!
                    }
                }
                else
                {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Update Failed!"
                    alertView.message = "Connection Failed"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            }
            else
            {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Update Failed!"
                alertView.message = "Connection Failure"
                if let error = reponseError
                {
                    alertView.message = (error.localizedDescription)
                }
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
        return user;
    }
}
