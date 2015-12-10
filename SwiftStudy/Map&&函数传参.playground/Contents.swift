//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func calArr(arr:[Int]) ->[Int]{
    var results:[Int] = []
    for item in arr{
        results.append(item * 2)
    }
    return results
}

var resultArr = calArr([1,2,3,4])
print(resultArr)


func calArr2(arr:[Int]) ->[Int]{
    var results:[Int] = []
    for item in arr{
        results.append(item * 2 + 1)
    }
    return results
}

var resultArr2 = calArr2([1,2,3,4])
print(resultArr2)


func calArr3(arr:[Int],fx:Int -> Int) ->[Int]{
    var results:[Int] = []
    for item in arr{
        results.append(fx(item))
    }
    return results
}

func cal(a:Int) ->Int{
    return a * 10 + 1;
}

var result4 = calArr3([21,22,23,24], fx: cal)

//尾随闭包么？
/*
* 尾随闭包（Trailing Closures）
* 如果函数需要一个闭包参数作为参数，且这个参数是最后一个参数，而这个闭包表达式又很长时，
* 使用尾随闭包是很有用的。尾随闭包可以放在函数参数列表外，也就是括号外。如果函数只有一个参数，
* 那么可以把括号()省略掉，后面直接跟着闭包。
*/
var resultArr3 = calArr3([1,2,3,4]){
    x in
    return 2 * x + 1
}
print(resultArr3)

//闭包用法 http://blog.csdn.net/woaifen3344/article/details/29606853
// 因为闭包体只有一行代码，可以省略return
/*
* 尾随闭包（Trailing Closures）
* 如果函数需要一个闭包参数作为参数，且这个参数是最后一个参数，而这个闭包表达式又很长时，
* 使用尾随闭包是很有用的。尾随闭包可以放在函数参数列表外，也就是括号外。如果函数只有一个参数，
* 那么可以把括号()省略掉，后面直接跟着闭包。
*/
var resultArr4 = calArr3([9,8,7,6],fx: {(a:Int) -> Int
    in
    2 * a + 1
})




/*generics  泛型*/
func getArr4<T>(arr:[Int],f:Int -> T) ->[T]{
    var result:[T] = []
    for item in arr{
        result.append(f(item))
    }
    return result
}


var result5 = getArr4([1,2,3,4], f: {(a:Int) -> String in
    if a % 2 == 0{
        return "偶数"
    }else{
        return "奇数"
    }
})
print(result5)



