//
//  User.swift
//  POCA
//
//  Created by Alexandru Draghi on 23/05/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation
class User
{
    var Name : String = ""
    var Username: String = ""
    var Email : String = ""
    var passion1 : Int = 0
    var passion2 : Int = 0
    var passion3 : Int = 0
    init ()
    {
        
    }
    init(NameTemp: String, UsernameTemp: String, EmailTemp: String, passion1Temp: Int, passion2Temp: Int, passion3Temp: Int)
    {
        Name = NameTemp
        Username = UsernameTemp
        Email = EmailTemp
        passion1 = passion1Temp
        passion2 = passion2Temp
        passion3 = passion3Temp
    }

    
}