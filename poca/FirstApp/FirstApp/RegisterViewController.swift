//
//  RegisterViewController.swift
//  FirstApp
//
//  Created by Alexandru Draghi on 17/05/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource
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
    @IBOutlet weak var AdvisorSwitch: UISwitch!
    
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
        
        self.hideKeyboard()
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SignUPTapped(sender: AnyObject)
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
        let isAdvisor:NSNumber.BooleanLiteralType = AdvisorSwitch.on
        var isAdvisor2 = 0
        if (isAdvisor==true) {isAdvisor2 = 1}
        let currentTime = NSDate()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateFormat="yyyy-MM-dd"
        
        let birthdate2 = dateFormatter.stringFromDate(birthdate)
        print(birthdate2)
        
        
        if ( realname.isEqualToString("") || email.isEqualToString("") || username.isEqualToString("") || password.isEqualToString("") || repassword.isEqualToString("")
            || birthdate.isEqualToDate(currentTime))
            {
            
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign up Failed!"
                alertView.message = "Please complete all the fields!"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
            else {
            
                    do {
                        let post:NSString = "realname=\(realname)&email=\(email)&username=\(username)&password=\(password)&repassword=\(repassword)&birthdate=\(birthdate2)&passion1=\(passion1)&passion2=\(passion2)&passion3=\(passion3)&isAdvisor=\(isAdvisor2)"
                
                        NSLog("PostData: %@",post);
                
                        let url:NSURL = NSURL(string:"http://angelicapp.com/POCA/jsonsignup.php")!
                
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
                        
                                        let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                        
                        
                                        let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                        
                                        NSLog("Success: %ld", success);
                        
                                        if(success == 1)
                                            {
                                                NSLog("SignUP SUCCESS");
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
                                                    alertView.title = "Sign up Failed!"
                                                    alertView.message = error_msg as String
                                                    alertView.delegate = self
                                                    alertView.addButtonWithTitle("OK")
                                                    alertView.show()
                                                
                                                }
                        
                                }
                            else
                            {
                                let alertView:UIAlertView = UIAlertView()
                                alertView.title = "Sign up Failed!"
                                alertView.message = "Connection Failed"
                                alertView.delegate = self
                                alertView.addButtonWithTitle("OK")
                                alertView.show()
                            }
                        }
                        else
                        {
                            let alertView:UIAlertView = UIAlertView()
                            alertView.title = "Sign up Failed!"
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
                        alertView.title = "Sign up Failed!"
                        alertView.message = "Server Error"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
        }
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return passionsList.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return passionsList[row]
    }
    
    func retrivePassions()
    {
        var newString = ""
        //code
            let url:NSURL = NSURL(string:"http://angelicapp.com/POCA/jsonpassions.php")!
            let session = NSURLSession.sharedSession()
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
            let paramString = "data=passions"
            request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
            let task = session.dataTaskWithRequest(request)
            {
                    (let data, let response, let error) in
                
                    guard let _:NSData = data, let _:NSURLResponse = response where error == nil
                    else
                    {
                            print(error)
                            return
                    }
                
                let dataString = NSString(data:data!,encoding: NSUTF8StringEncoding)
                newString = dataString!.substringFromIndex(1)

                 let newStringArr = newString.componentsSeparatedByString("+")
                
                print(newStringArr)
            }
            task.resume()

        //code
    }
    
    @IBAction func exitRegister(sender: UIButton)
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
