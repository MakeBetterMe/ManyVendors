//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//swift指针
func printSafePoint(a:UnsafeMutablePointer<Int>){
    debugPrint("\(a.memory)")
    a.memory += 1
}

var aaPoint = UnsafeMutablePointer<Int>.alloc(1)
aaPoint.initialize(100)
printSafePoint(aaPoint)
print(aaPoint.memory)



//in-out 写入读出参数

func swapValue(inout a:Int,inout b:Int){
    let temp = a
    a = b
    b = temp
}

var a = 10
var b = 20
swap(&a, &b)
debugPrint("a等于\(a),b等于\(b)")


func swapValue<T>(inout a:T,inout b:T){
    let temp = a
    a = b
    b = temp
}
var aaa = 100
var bbb = 22
swapValue(&aaa, b: &bbb)
print(aaa)
print(bbb)


var s = "xiaohei"
var g = "xiaobai"
swapValue(&s, b: &g)
print(s)
print(g)

//作为返回值
//T作为类型占位符
func addDict<K,V>(a:[K:V]){
    print(a)
}

addDict(["11":"22"])
addDict([1:2])



struct Stack<T>{
    var arr:[T] = []
    mutating func push(a:T){
        arr.append(a)
    }
    mutating func pop(){
        arr.removeLast()
    }
}

var smallTruct = Stack(arr: [1,2,3])
smallTruct.push(2)
print(smallTruct.arr)
smallTruct.pop()
print(smallTruct.arr)

var smallTruct2 = Stack(arr: ["a","b","c"])
smallTruct2.push("d")
print(smallTruct2.arr)
smallTruct2.pop()
print(smallTruct2.arr)



func findStringIndex<T:Equatable>(array:[T], valueToFind: T) -> Int? {
    for (index,value) in EnumerateSequence(array){
        if value == valueToFind{
            return index
        }
    }
    return nil
}
let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
findStringIndex(strings, valueToFind: "dog")
let numbers = [1,23,22,33]
findStringIndex(numbers, valueToFind: 22)


protocol Container {
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack: Container {
    // original IntStack implementation
    var items:[Int] = []
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}


