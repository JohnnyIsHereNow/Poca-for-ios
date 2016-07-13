//
//  ViewModel.swift
//  POCA
//
//  Created by Alexandru Draghi on 25/05/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
@IBDesignable class ViewModel: UIView {

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passion1Label: UILabel!
    @IBOutlet weak var passion2Label: UILabel!
    @IBOutlet weak var passion3Label: UILabel!
    
    @IBAction func acceptButton(sender: UIButton)
    {
        
    }
    @IBAction func deleteButton(sender: UIButton)
    {

    }
    
    @IBInspectable var myUsernameLabelText : String?
    {
        get
        {
            return usernameLabel.text
        }
        set (myUsernameLabelText)
        {
            usernameLabel.text = myUsernameLabelText
        }
    }
    
    @IBInspectable var myNameLabelText : String?
        {
        get
        {
            return nameLabel.text
        }
        set (myNameLabelText)
        {
            nameLabel.text = myNameLabelText
        }
    }

    @IBInspectable var myEmailLabelText : String?
        {
        get
        {
            return emailLabel.text
        }
        set (myEmailLabelText)
        {
            emailLabel.text = myEmailLabelText
        }
    }
    
    @IBInspectable var myPassion1LabelText : String?
        {
        get
        {
            return passion1Label.text
        }
        set (myPassion1LabelText)
        {
            passion1Label.text = myPassion1LabelText
        }
    }
    
    @IBInspectable var myPassion2LabelText : String?
        {
        get
        {
            return passion2Label.text
        }
        set (myPassion2LabelText)
        {
            passion2Label.text = myPassion2LabelText
        }
    }
    
    @IBInspectable var myPassion3LabelText : String?
        {
        get
        {
            return passion3Label.text
        }
        set (myPassion3LabelText)
        {
            passion3Label.text = myPassion3LabelText
        }
    }


    
    var view : UIView!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }
    
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder : aDecoder)!
        setup()
    }
    
    func setup()
    {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        view.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView
    {
        let bundle = NSBundle (forClass: self.dynamicType)
        let nib = UINib(nibName: "ViewModel", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil) [0] as! UIView
        return view
    }
}
