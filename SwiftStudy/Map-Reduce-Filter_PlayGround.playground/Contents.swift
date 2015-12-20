//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var intArr = [1,2,3,4,5]
var stringArr = intArr.map({"\($0 * 2)"})
print(stringArr)

var intArr2 = [2,3,4,5,6]
var intArr3 = intArr2.map({ $0 * 2 })


var intArr4 = intArr2.map { (item:Int) -> Int in
    guard item > 2 else {
        return 0
    }
    return item
}
print(intArr4)

var intArr5 = intArr2.filter({$0 > 2})
print(intArr5)

var number = intArr2.reduce(1,combine: -)
print(number)

var stringArr = ["1","2","XIAOHEI","3"]
