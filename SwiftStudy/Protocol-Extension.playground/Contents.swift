//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Animal {
    var name:String {
        return "动物"
    }
    var sex = "男"
}

class Dog:Animal{
   override var name:String {
        return "小狗"
    }
}

