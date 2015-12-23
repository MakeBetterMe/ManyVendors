//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


func multiplyFunc<T>(names:T...){
    for name in names{
        print(name)
    }
}

multiplyFunc("xiao","hei",3,5)

var names = ["1","2","3","99"]
names.map({name in print("\(name) has map")})

var numbers = [1,2,3,4,5,6]
names = names.sort({a,b in a > b})
print(names)