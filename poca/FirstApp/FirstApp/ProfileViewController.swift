//
//  ProfileViewController.swift
//  POCA
//
//  Created by Alexandru Draghi on 22/05/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource
{

    @IBOutlet weak var RealNameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RetypePasswordTextField: UITextField!
    @IBOutlet weak var BirthDatePicker: UIDatePicker!
    @IBOutlet weak var Passion1PickerView: UIPickerView!
    @IBOutlet weak var Passion2PickerView: UIPickerView!
    @IBOutlet weak var Passion3PickerView: UIPickerView!
    let userID:NSInteger = 0;
    
    var passionsList: [String] = [String]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        passionsList = ["Gaming","Programming","Fishing","Jogging","Design","Medicine","Yoga","Soccer","Volunteering","Cooking","Hunting","Card games"]
        self.Passion1PickerView.delegate = self
        self.Passion1PickerView.dataSource = self
        self.Passion2PickerView.delegate = self
        self.Passion2PickerView.dataSource = self
        self.Passion3PickerView.delegate = self
        self.Passion3PickerView.dataSource = self
        let prefs = NSUserDefaults.standardUserDefaults()

        UsernameTextField.text = prefs.objectForKey("USERNAME") as! String!
        UsernameTextField.enabled = false
        retriveDetails()
        self.hideKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func retriveDetails()
    {
        var username:NSString = ""
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        username = prefs.objectForKey("USERNAME") as! String
        var newString = ""
        do {
            let post:NSString = "username=\(username)"
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string:"http://angelicapp.com/POCA/jsonPrepareForUpdate.php")!
            
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
                    // print(newStringArr)
                    
                    let p1: Int! = Int(newStringArr[4])
                    let p2: Int! = Int(newStringArr[5])
                    let p3: Int! = Int(newStringArr[6])
                    let userID: Int! = Int(newStringArr[7])

                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = dateFormatter.dateFromString(newStringArr[3] as String)
                    
                    RealNameTextField.text = newStringArr[0]
                    EmailTextField.text = newStringArr[1]
                    PasswordTextField.text = ""
                    RetypePasswordTextField.text = ""
                    BirthDatePicker.date = date!
                    Passion1PickerView.selectRow(p1, inComponent: 0, animated: false)
                    Passion2PickerView.selectRow(p2, inComponent: 0, animated: false)
                    Passion3PickerView.selectRow(p3, inComponent: 0, animated: false)
                    prefs.setObject(userID, forKey: "userID")
                    
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
    }
        
    
    @IBAction func UpdateTapped(sender: AnyObject)
    {
        let realname:NSString = RealNameTextField.text!
        let email:NSString = EmailTextField.text!
        let username:NSString = UsernameTextField.text!
        let password:NSString = PasswordTextField.text!
        let repassword:NSString = RetypePasswordTextField.text!
        let birthdate:NSDate = BirthDatePicker.date
        let passion1:NSInteger = Passion1PickerView.selectedRowInComponent(0)
        let passion2:NSInteger = Passion2PickerView.selectedRowInComponent(0)
        let passion3:NSInteger = Passion3PickerView.selectedRowInComponent(0)
        let currentTime = NSDate()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle   // You can also use Long, Medium and No style.
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateFormat="yyyy-MM-dd"
        
        if ( realname.isEqualToString("") || email.isEqualToString("") || username.isEqualToString("") || password.isEqualToString("") || repassword.isEqualToString("")
            || birthdate.isEqualToDate(currentTime))
        {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Update Failed!"
            alertView.message = "Please complete all the fields!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else {
            
            do {
                let post:NSString = "realname=\(realname)&email=\(email)&username=\(username)&password=\(password)&repassword=\(repassword)&passion1=\(passion1)&passion2=\(passion2)&passion3=\(passion3)&birthdate=\(dateFormatter.stringFromDate(birthdate))"
                
                NSLog("PostData: %@",post);
                
                let url:NSURL = NSURL(string:"http://angelicapp.com/POCA/jsonUpdate.php")!
                // self.session = NSURLSession(configuration: urlconfig, delegate: self.delegates, delegateQueue: nil)
                
                let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
                
                let postLength:NSString = String( postData.length )
                
                let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
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
                        
                        if(success == 1)
                        {
                            NSLog("Update SUCCESS");
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                        else
                        {
                            var error_msg:NSString
                            
                            if jsonData["error_message"] as? NSString != nil
                            {
                                error_msg = jsonData["error_message"] as! NSString
                            }
                            else
                            {
                                error_msg = "Unknown Error"
                            }
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Update Failed!"
                            alertView.message = error_msg as String
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()
                            
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
            catch
            {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Update Failed!"
                alertView.message = "Server Error"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return passionsList.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return passionsList[row]
    }
    
    @IBAction func exitProfile(sender: UIButton)
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
