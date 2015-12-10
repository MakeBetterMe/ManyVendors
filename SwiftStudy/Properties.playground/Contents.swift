//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//存储属性
struct FixedRange{
    var starValue:Int
    let length:Int
}


/*
由于结构体（struct）属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。

属于引用类型的类（class）则不一样。把一个引用类型的实例赋给一个常量后，仍然可以修改该实例的变量属性。
*/

var s1 = FixedRange(starValue: 0, length: 10)
s1.starValue = 100
print(s1.starValue)


class Animal {
    let starAge:Int
    var endAge:Int
    
    init(){
        starAge = 0
        endAge = 100
    }
    
    init(s:Int,e:Int) {
        starAge = s
        endAge = e
    }
}

let a1 = Animal(s: 1, e: 120);
a1.endAge = 1000
print(a1.endAge)


/*TIPS
必须将延迟存储属性声明成变量（使用var关键字），因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性。
延迟属性很有用，当属性的值依赖于在实例的构造过程结束后才会知道具体值的外部因素时，或者当获得属性的初始值需要复杂或大量计算时，可以只在需要的时候计算它。
*/

//计算属性
/*
    而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值
*/
class Dog {
    lazy var name:String = "王 小黑"
    let age:Int = 32
    var contentName:String{
        get{
            let nameArr = self.name.componentsSeparatedByString(" ")
            if let string = nameArr.first{
                return string
            }else{
                return "默认的姓氏"
            }
        }
        
        set{
            let nameArr = self.name.componentsSeparatedByString(" ")
            self.name = nameArr.first!.stringByAppendingString(newValue);
        }
    }
}

var d1 = Dog()
print(d1.contentName)
d1.contentName = "二傻"
print(d1.name)



//属性观察器
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896



//类型属性
/*
跟实例的存储型属性不同，必须给存储型类型属性指定默认值，因为类型本身没有构造器，也就无法在初始化过程中使用构造器给类型属性赋值。
存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。即使它们被多个线程同时访问，系统也保证只会对其进行一次初始化，并且不需要对其使用lazy修饰符。
*/

class CatAnimal {
    static var name:String = "猫科"{
        didSet{
            if name == "老虎"{
                print("老虎")
            }
        }
        willSet{
            print(newValue)
        }
    }
}


print(CatAnimal.name)
var cat = CatAnimal()
CatAnimal.name = "老虎"




class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

class SpecialClass:SomeClass {

}
