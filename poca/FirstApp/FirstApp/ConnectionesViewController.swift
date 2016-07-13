//
//  ConnectionesViewController.swift
//  POCA
//
//  Created by Alexandru Draghi on 23/05/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ConnectionesViewController: UIViewController {

    @IBOutlet weak var myScrollView: UIScrollView!
    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad()
    {
        var user = User()
        let retrieveUserWithId = RetrieveUserWithId()
        
        super.viewDidLoad()
        
        retriveConnections0()
        retriveConnections1()
        sleep(1)

        myScrollView.contentSize = CGSize(width: 320,height: 20)
            let Array0 = prefs.objectForKey("array0Acc") as! [String]
            let Array0Sent = prefs.objectForKey("array0Sent") as! [String]
            let Array1 = prefs.objectForKey("array1") as! [String]
            sleep(1)
            var y = 10;
        
            if Array0.count > 0
            {
            for conn in 0...Array0.count - 1
            {
                if Array0[conn] != ""
                {
                    let userId: Int! = Int(Array0[conn])
                    user = retrieveUserWithId.retriveUser(userId)
                    if user.Username != ""
                    {
                        let subview : UIView = UIView(frame: CGRect(x: 10, y: y, width: 280, height: 250))
                        subview.center = CGPointMake(CGRectGetMidX(myScrollView.bounds),subview.center.y)
                        //subview.backgroundColor = UIColor(patternImage: UIImage(named: "Background.jpg")!)
                        subview.backgroundColor = UIColor(white: 0, alpha: 0.5)
                        subview.layer.cornerRadius = 10
                        subview.layer.masksToBounds = true
                        
                        let usernameLabel = UILabel(frame: CGRect(x:0,y:8, width: 280, height: 21))
                        usernameLabel.text = user.Username
                        usernameLabel.textColor = UIColor (white: 255, alpha: 255)
                        usernameLabel.textAlignment = NSTextAlignment.Center
                        usernameLabel.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(usernameLabel)
                        
                        let nameLabel = UILabel(frame: CGRect(x:0,y:38, width: 280, height: 21))
                        nameLabel.text = user.Name
                        nameLabel.textColor = UIColor (white: 255, alpha: 255)
                        nameLabel.textAlignment = NSTextAlignment.Center
                        nameLabel.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(nameLabel)
                        
                        let emailLabel = UILabel(frame: CGRect(x:0,y:67, width: 280, height: 21))
                        emailLabel.text = user.Email
                        emailLabel.textColor = UIColor (white: 255, alpha: 255)
                        emailLabel.textAlignment = NSTextAlignment.Center
                        emailLabel.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(emailLabel)
                        
                        let pass1Label = UILabel(frame: CGRect(x:65,y:96, width: 150, height: 21))
                        pass1Label.text = convertPassionsIntToString(user.passion1)
                        pass1Label.textColor = UIColor (white: 255, alpha: 255)
                        pass1Label.textAlignment = NSTextAlignment.Center
                        pass1Label.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(pass1Label)
                        
                        let pass2Label = UILabel(frame: CGRect(x:65,y:125, width: 150, height: 21))
                        pass2Label.text = convertPassionsIntToString(user.passion2)
                        pass2Label.textColor = UIColor (white: 255, alpha: 255)
                        pass2Label.textAlignment = NSTextAlignment.Center
                        pass2Label.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(pass2Label)
                        
                        let pass3Label = UILabel(frame: CGRect(x:65,y:154, width: 150, height: 21))
                        pass3Label.text = convertPassionsIntToString(user.passion3)
                        pass3Label.textColor = UIColor (white: 255, alpha: 255)
                        pass3Label.textAlignment = NSTextAlignment.Center
                        pass3Label.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(pass3Label)

                        let accBtn = UIButton(frame: CGRect(x:1,y:194, width: 130, height: 50))
                        accBtn.backgroundColor = UIColor(red: 0, green: 50, blue: 200, alpha: 0.5)
                        accBtn.layer.cornerRadius = 0.1 * accBtn.bounds.size.width
                        accBtn.setTitle("Accept!", forState: .Normal)
                        accBtn.titleLabel?.textColor = UIColor(white: 0,alpha:255)
                        accBtn.titleLabel?.font = UIFont(name:"Courier-Bold",size: 20)
                        accBtn.tag = userId
                        accBtn.addTarget(self, action: #selector(ConnectionesViewController.accRequest(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                        subview.addSubview(accBtn)
                        
                        let delBtn = UIButton(frame: CGRect(x:148,y:194, width: 130, height: 50))
                        delBtn.backgroundColor = UIColor(red: 0, green: 50, blue: 200, alpha: 0.5)
                        delBtn.layer.cornerRadius = 0.1 * delBtn.bounds.size.width
                        delBtn.setTitle("Delete!", forState: .Normal)
                        delBtn.titleLabel?.textColor = UIColor(white: 0,alpha:255)
                        delBtn.titleLabel?.font = UIFont(name:"Courier-Bold",size: 20)
                        delBtn.tag = userId
                        delBtn.addTarget(self, action: #selector(ConnectionesViewController.delConnection(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                        subview.addSubview(delBtn)
                        
                        myScrollView.addSubview(subview)
                        y += 260
                    }
                }
            }
            }
        
            if Array1.count > 0
            {
            for conn in 0...Array1.count - 1
            {
                if Array1[conn] != ""
                {
                let userId: Int! = Int(Array1[conn])
                user = retrieveUserWithId.retriveUser(userId)
                    if user.Username != ""
                    {
                        let subview : UIView = UIView(frame: CGRect(x: 10, y: y, width: 280, height: 250))
                        subview.center = CGPointMake(CGRectGetMidX(myScrollView.bounds),subview.center.y)
                        //subview.backgroundColor = UIColor(patternImage: UIImage(named: "Background.jpg")!)
                        subview.backgroundColor = UIColor(white: 0, alpha: 0.5)
                        subview.layer.cornerRadius = 10
                        subview.layer.masksToBounds = true
                        
                        let usernameLabel = UILabel(frame: CGRect(x:0,y:8, width: 280, height: 21))
                        usernameLabel.text = user.Username
                        usernameLabel.textColor = UIColor (white: 255, alpha: 255)
                        usernameLabel.textAlignment = NSTextAlignment.Center
                        usernameLabel.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(usernameLabel)
                        
                        let nameLabel = UILabel(frame: CGRect(x:0,y:38, width: 280, height: 21))
                        nameLabel.text = user.Name
                        nameLabel.textColor = UIColor (white: 255, alpha: 255)
                        nameLabel.textAlignment = NSTextAlignment.Center
                        nameLabel.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(nameLabel)
                        
                        let emailLabel = UILabel(frame: CGRect(x:0,y:67, width: 280, height: 21))
                        emailLabel.text = user.Email
                        emailLabel.textColor = UIColor (white: 255, alpha: 255)
                        emailLabel.textAlignment = NSTextAlignment.Center
                        emailLabel.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(emailLabel)
                        
                        let pass1Label = UILabel(frame: CGRect(x:65,y:96, width: 150, height: 21))
                        pass1Label.text = convertPassionsIntToString(user.passion1)
                        pass1Label.textColor = UIColor (white: 255, alpha: 255)
                        pass1Label.textAlignment = NSTextAlignment.Center
                        pass1Label.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(pass1Label)
                        
                        let pass2Label = UILabel(frame: CGRect(x:65,y:125, width: 150, height: 21))
                        pass2Label.text = convertPassionsIntToString(user.passion2)
                        pass2Label.textColor = UIColor (white: 255, alpha: 255)
                        pass2Label.textAlignment = NSTextAlignment.Center
                        pass2Label.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(pass2Label)
                        
                        let pass3Label = UILabel(frame: CGRect(x:65,y:154, width: 150, height: 21))
                        pass3Label.text = convertPassionsIntToString(user.passion3)
                        pass3Label.textColor = UIColor (white: 255, alpha: 255)
                        pass3Label.textAlignment = NSTextAlignment.Center
                        pass3Label.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(pass3Label)
                        
                        let delBtn = UIButton(frame: CGRect(x:10,y:194, width: 260, height: 50))
                        delBtn.backgroundColor = UIColor(red: 0, green: 50, blue: 200, alpha: 0.5)
                        delBtn.layer.cornerRadius = 0.1 * delBtn.bounds.size.width
                        delBtn.setTitle("Delete connection!", forState: .Normal)
                        delBtn.titleLabel?.textColor = UIColor(white: 0,alpha:255)
                        delBtn.titleLabel?.font = UIFont(name:"Courier-Bold",size: 20)
                        delBtn.tag = userId
                        delBtn.addTarget(self, action: #selector(ConnectionesViewController.delConnection(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                        subview.addSubview(delBtn)
                        
                        myScrollView.addSubview(subview)
                        y += 260
                    }
                }
            }
        }
        
            if Array0Sent.count > 0
            {
            for conn in 0...Array0Sent.count - 1
            {
                if Array0Sent[conn] != ""
                {
                    let userId: Int! = Int(Array0Sent[conn])
                    user = retrieveUserWithId.retriveUser(userId)
                    if user.Username != ""
                    {
                        let subview : UIView = UIView(frame: CGRect(x: 10, y: y, width: 280, height: 250))
                        subview.center = CGPointMake(CGRectGetMidX(myScrollView.bounds),subview.center.y)
                        //subview.backgroundColor = UIColor(patternImage: UIImage(named: "Background.jpg")!)
                        subview.backgroundColor = UIColor(white: 0, alpha: 0.5)
                        subview.layer.cornerRadius = 10
                        subview.layer.masksToBounds = true
                        
                        let usernameLabel = UILabel(frame: CGRect(x:0,y:8, width: 280, height: 21))
                        usernameLabel.text = user.Username
                        usernameLabel.textColor = UIColor (white: 255, alpha: 255)
                        usernameLabel.textAlignment = NSTextAlignment.Center
                        usernameLabel.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(usernameLabel)
                        
                        let nameLabel = UILabel(frame: CGRect(x:0,y:38, width: 280, height: 21))
                        nameLabel.text = user.Name
                        nameLabel.textColor = UIColor (white: 255, alpha: 255)
                        nameLabel.textAlignment = NSTextAlignment.Center
                        nameLabel.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(nameLabel)
                        
                        let emailLabel = UILabel(frame: CGRect(x:0,y:67, width: 280, height: 21))
                        emailLabel.text = user.Email
                        emailLabel.textColor = UIColor (white: 255, alpha: 255)
                        emailLabel.textAlignment = NSTextAlignment.Center
                        emailLabel.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(emailLabel)
                        
                        let pass1Label = UILabel(frame: CGRect(x:65,y:96, width: 150, height: 21))
                        pass1Label.text = convertPassionsIntToString(user.passion1)
                        pass1Label.textColor = UIColor (white: 255, alpha: 255)
                        pass1Label.textAlignment = NSTextAlignment.Center
                        pass1Label.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(pass1Label)
                        
                        let pass2Label = UILabel(frame: CGRect(x:65,y:125, width: 150, height: 21))
                        pass2Label.text = convertPassionsIntToString(user.passion2)
                        pass2Label.textColor = UIColor (white: 255, alpha: 255)
                        pass2Label.textAlignment = NSTextAlignment.Center
                        pass2Label.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(pass2Label)
                        
                        let pass3Label = UILabel(frame: CGRect(x:65,y:154, width: 150, height: 21))
                        pass3Label.text = convertPassionsIntToString(user.passion3)
                        pass3Label.textColor = UIColor (white: 255, alpha: 255)
                        pass3Label.textAlignment = NSTextAlignment.Center
                        pass3Label.font = UIFont(name:"Courier-Bold",size: 20)
                        subview.addSubview(pass3Label)
                        
                        let delBtn = UIButton(frame: CGRect(x:10,y:194, width: 260, height: 50))
                        delBtn.backgroundColor = UIColor(red: 0, green: 50, blue: 200, alpha: 0.5)
                        delBtn.layer.cornerRadius = 0.1 * delBtn.bounds.size.width
                        delBtn.setTitle("Cancel request!", forState: .Normal)
                        delBtn.titleLabel?.textColor = UIColor(white: 0,alpha:255)
                        delBtn.titleLabel?.font = UIFont(name:"Courier-Bold",size: 20)
                        delBtn.tag = userId
                        delBtn.addTarget(self, action: #selector(ConnectionesViewController.delConnection(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                        subview.addSubview(delBtn)
                        
                        myScrollView.addSubview(subview)
                        y += 260
                    }
                }
            }
        }
        
        myScrollView.contentSize = CGSize(width: 320,height: y)
        self.hideKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func accRequest(sender:UIButton)
    {
        sender.userInteractionEnabled = false
        sender.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
        sender.setTitle("Already added!", forState: .Normal)
        
        let myId:NSInteger = prefs.objectForKey("userID") as! Int
        let hisId:NSString = String(sender.tag)
        do {
            let post:NSString = "myId=\(myId)&hisId=\(hisId)"
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string:"http://angelicapp.com/POCA/jsonAcceptConnection.php")!
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            let postLength:NSString = String( postData.length )
            
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            var response: NSURLResponse?
            
            var urlData: NSData?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            } catch _ as NSError {
                urlData = nil
            }
            
            if ( urlData != nil ) {
                let res = response as! NSHTTPURLResponse!;
                
                NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    //var error: NSError?
                    
                    let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                    
                    //[jsonData[@"success"] integerValue];
                    
                    NSLog("Success: %ld", success);
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Success"
                    alertView.message = "Connection has been accepted!"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                    
                } else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Request failed!"
                    alertView.message = "Connection Failed"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            }
        } catch {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Request failed!"
            alertView.message = "Server Error"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
    }
    
    func delConnection(sender:UIButton)
    {
        sender.userInteractionEnabled = false
        sender.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
        sender.setTitle("Already deleted!", forState: .Normal)
        
        let myId:NSInteger = prefs.objectForKey("userID") as! Int
        let hisId:NSString = String(sender.tag)
        do {
            let post:NSString = "myId=\(myId)&hisId=\(hisId)"
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string:"http://angelicapp.com/POCA/jsonDeleteConnection.php")!
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            let postLength:NSString = String( postData.length )
            
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            var response: NSURLResponse?
            
            var urlData: NSData?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            } catch _ as NSError {
                urlData = nil
            }
            
            if ( urlData != nil ) {
                let res = response as! NSHTTPURLResponse!;
                
                NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    //var error: NSError?
                    
                    let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                    
                    
                    let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                    
                    //[jsonData[@"success"] integerValue];
                    
                    NSLog("Success: %ld", success);
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Success"
                    alertView.message = "Connection has been removed!"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                    
                } else {
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Request failed!"
                    alertView.message = "Connection Failed"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            }
        } catch {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Request failed!"
            alertView.message = "Server Error"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
    }
    
    
    func retriveConnections1() -> [String]
    {
        let userID:NSInteger = prefs.objectForKey("userID") as! Int
        var newString = ""
        var newStringArr = [String]()
        do
        {
            let post:NSString = "userID=\(userID)"
            NSLog("PostData: %@",post);
            let url:NSURL = NSURL(string:"http://angelicapp.com/POCA/jsonConnections1.php")!
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            
            let postLength:NSString = String(postData.length)
            
            let session = NSURLSession.sharedSession()
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTaskWithRequest(request)
            {
                (let data, let response, let error) in
                
                if data == nil
                {
                    print("request failed\(error)")
                    return
                }
                guard let _:NSData = data, let _:NSURLResponse = response where error == nil
                    else
                {
                    print(error)
                    return
                }
                let dataString = NSString(data:data!,encoding: NSUTF8StringEncoding)
                newString = dataString!.substringFromIndex(1)
                newStringArr = newString.componentsSeparatedByString("+")
                self.prefs.setObject(newStringArr, forKey: "array1")
                print(newStringArr)
            }
            task.resume()
        }
        return newStringArr
    }
    
    func retriveConnections0() -> [String]
    {
        let userID:NSInteger = prefs.objectForKey("userID") as! Int
        var newString = ""
        let newStringTemp = [String]()
        do
        {
            let post:NSString = "userID=\(userID)"
            NSLog("PostData: %@",post);
            let url:NSURL = NSURL(string:"http://angelicapp.com/POCA/jsonConnections0.php")!
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            
            let postLength:NSString = String(postData.length)
            
            let session = NSURLSession.sharedSession()
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTaskWithRequest(request)
            {
                (let data, let response, let error) in
                
                if data == nil
                {
                    print("request failed\(error)")
                    return
                }
                guard let _:NSData = data, let _:NSURLResponse = response where error == nil
                    else
                {
                    print(error)
                    return
                }
                let dataString = NSString(data:data!,encoding: NSUTF8StringEncoding)
                newString = dataString!.substringFromIndex(1)
                let newStringTemp = newString.componentsSeparatedByString("/")
                let newStringArr1 = newStringTemp[0]
                let newStringArr3 = newStringArr1.componentsSeparatedByString("+")
                let newStringArr2 = newStringTemp[1]
                let newStringArr4 = newStringArr2.componentsSeparatedByString("+")
                
                self.prefs.setObject(newStringArr3, forKey: "array0Acc")
                self.prefs.setObject(newStringArr4, forKey: "array0Sent")
            }
            task.resume()
        }
        return newStringTemp
    }
    
    func convertPassionsIntToString(i : Int) -> String
    {
    let passionsList = ["Gaming","Programming","Fishing","Jogging","Design","Medicine","Yoga","Soccer","Volunteering","Cooking","Hunting","Card games"]
        let Passion = passionsList[i]
        return Passion
    }

    
    @IBAction func exitConnections(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func hideKeyboard()
    {
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target:self ,action: #selector(RegisterViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard()
    {
        view.endEditing(true);
    }


}
