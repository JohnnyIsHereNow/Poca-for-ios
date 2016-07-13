//
//  ViewController.swift
//  FirstApp
//
//  Created by Alexandru Draghi on 17/05/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var mySearchResultsScrollView: UIScrollView!

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var Passion1PickerView: UIPickerView!
    @IBOutlet weak var Passion2PickerView: UIPickerView!
    @IBOutlet weak var Passion3PickerView: UIPickerView!
    @IBAction func Search(sender: UIButton)
    {
            completeViews()
    }

    var passionsList = ["Gaming","Programming","Fishing","Jogging","Design","Medicine","Yoga","Soccer","Volunteering","Cooking","Hunting","Card games"]
    var user: User = User()
    var retrieveUserWithId: RetrieveUserWithId = RetrieveUserWithId()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        passionsList = ["Gaming","Programming","Fishing","Jogging","Design","Medicine","Yoga","Soccer","Volunteering","Cooking","Hunting","Card games"]
        self.Passion1PickerView.dataSource = self
        self.Passion1PickerView.delegate = self
        self.Passion2PickerView.delegate = self
        self.Passion2PickerView.dataSource = self
        self.Passion3PickerView.delegate = self
        self.Passion3PickerView.dataSource = self
        //experiments here
 
        //experiments ends here
        self.hideKeyboard()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
        
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return passionsList.count
    }
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return passionsList[row]
    }
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1)
        {
            self.performSegueWithIdentifier("goto_Login", sender: self)
        }
        else
        {
            self.usernameLabel.text = (prefs.valueForKey("USERNAME") as! String)
        }
    }
    
    func retriveNoConnections() -> [String]
    {
        let userID:NSInteger = prefs.objectForKey("userID") as! Int
        var newString = ""
        var newStringArr5 = [String]()
        do
        {
            let post:NSString = "userID=\(userID)"
            NSLog("PostData: %@",post);
            let url:NSURL = NSURL(string:"http://angelicapp.com/POCA/jsonNoConnection.php")!
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
                var newStringArr3 = newStringArr1.componentsSeparatedByString("+")
                let newStringArr2 = newStringTemp[1]
                var newStringArr4 = newStringArr2.componentsSeparatedByString("+")
                
                for n in 0...newStringArr3.count - 1
                {
                    var found = false
                    for m in 0...newStringArr4.count - 1
                    {
                        if newStringArr3[n] == newStringArr4[m]
                        {
                            found = true
                        }
                    }
                    if !found
                    {
                        newStringArr5.append(newStringArr3[n])
                    }
                }
                //print(newStringArr5)
               self.prefs.setObject(newStringArr5, forKey: "arrayNoConnections")
            }
            task.resume()
        }
        return newStringArr5
    }
    
    func convertPassionsIntToString(i : Int) -> String
    {
        let Passion = passionsList[i]
        return Passion
    }
    
    func completeViews()
    {
        retriveNoConnections()
        sleep(1)
        
        mySearchResultsScrollView.contentSize = CGSize(width: 320,height: 20)
        let ArrayNoConnections = prefs.objectForKey("arrayNoConnections") as! [String]
        var y = 10;
        for view in mySearchResultsScrollView.subviews
        {
            view.removeFromSuperview()
        }
        for conn in 0...ArrayNoConnections.count - 1
        {
            if ArrayNoConnections[conn] != ""
            {
                let userId: Int! = Int(ArrayNoConnections[conn])
                user = retrieveUserWithId.retriveUser(userId)
                user = retrieveUserWithId.retriveUser(userId)
                if user.Username != ""
                {
                    if (
                        (user.passion1 == Passion1PickerView.selectedRowInComponent(0) || user.passion1 == Passion2PickerView.selectedRowInComponent(0) || user.passion1 == Passion3PickerView.selectedRowInComponent(0)) &&
                        (user.passion2 == Passion1PickerView.selectedRowInComponent(0) || user.passion2 == Passion2PickerView.selectedRowInComponent(0) || user.passion2 == Passion3PickerView.selectedRowInComponent(0)) &&
                        (user.passion3 == Passion1PickerView.selectedRowInComponent(0) || user.passion3 == Passion2PickerView.selectedRowInComponent(0) || user.passion3 == Passion3PickerView.selectedRowInComponent(0))
                        )
                    {
                    let subview : UIView = UIView(frame: CGRect(x: 10, y: y, width: 280, height: 250))
                    subview.center = CGPointMake(CGRectGetMidX(mySearchResultsScrollView.bounds),subview.center.y)
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
                    
                    let connBtn = UIButton(frame: CGRect(x:10,y:194, width: 260, height: 50))
                    connBtn.backgroundColor = UIColor(red: 0, green: 50, blue: 200, alpha: 0.5)
                    connBtn.layer.cornerRadius = 0.1 * connBtn.bounds.size.width
                    connBtn.setTitle("Add connection!", forState: .Normal)
                    connBtn.titleLabel?.textColor = UIColor(white: 0,alpha:255)
                    connBtn.titleLabel?.font = UIFont(name:"Courier-Bold",size: 20)
                    connBtn.tag = userId
                    connBtn.addTarget(self, action: #selector(HomeViewController.addConnection(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                        
                    subview.addSubview(connBtn)
                    
                    mySearchResultsScrollView.addSubview(subview)
                    y += 260
                        mySearchResultsScrollView.contentSize = CGSize(width: 320,height: y)
                    }
                }
            }
        }
    }
    func addConnection(sender: UIButton)
    {
        sender.userInteractionEnabled = false
        sender.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
        sender.setTitle("Request sent!", forState: .Normal)
        
        let myId:NSInteger = prefs.objectForKey("userID") as! Int
        let hisId:NSString = String(sender.tag)
            do {
                let post:NSString = "myId=\(myId)&hisId=\(hisId)"
                
                NSLog("PostData: %@",post);
                
                let url:NSURL = NSURL(string:"http://angelicapp.com/POCA/jsonCreateConnection.php")!
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
                            alertView.message = "Connection request has been sent!"
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

    
@IBAction func LogoutTapped(sender: AnyObject)
    {
         let appDomain = NSBundle.mainBundle().bundleIdentifier
         NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
         prefs.removeObjectForKey("USERNAME")
        
         self.performSegueWithIdentifier("goto_Login", sender: self)

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

