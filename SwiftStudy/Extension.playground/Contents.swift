//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


extension Int {
    func times(closure: (String) -> ()) {
        for _ in 1...self {
            closure("")
        }
    }
}

3.times({_ in print("Hello,World")})
