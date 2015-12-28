//
//  main.swift
//  元类
//
//  Created by 王云鹏 on 15/12/24.
//  Copyright © 2015年 Pony. All rights reserved.
//

import Foundation

//print("Hello, World!")

var d = Dog()

//Dog.bark()

let typeA:Dog.Type = Dog.self

typeA.bark()



let dog2 = Dog.self()
//debugPrint(dog2.name)


typealias AnyClass = Dog.Type
