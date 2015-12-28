//
//  Dog.swift
//  元类
//
//  Created by 王云鹏 on 15/12/24.
//  Copyright © 2015年 Pony. All rights reserved.
//

import Cocoa

class Animal: NSObject {
    
}

class Dog: Animal {
    var name:String = "xiaohei"
   class func bark(){
        debugPrint("小狗再叫呢")
    }
    
    func sleep(){
        debugPrint("睡觉呢")
    }
}
