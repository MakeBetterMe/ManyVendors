//: Playground - noun: a place where people can play


/*
  参考  http://www.jianshu.com/p/eb718439551f
    Swift2.0中加入了defer新语法声明。defer译为延缓、推迟之意。那么在Swift2.0中它将被应用于什么位置呢？比如，读取某目录下的文件内容并处理数据，你需要首先定位到文件目录，打开文件夹，读取文件内容以及处理数据，关闭文件以及文件夹。倘若一切顺利，只需按照设定好的程序流程走一轮即可；不过考虑事情要面面俱到，倘若中间某个环节失败，比如读取文件内容失败、处理数据失败等等，还需要进行一些后续收尾工作，即关闭文件或关闭文件夹(当然就算顺利执行，也是要关闭的)。
    重点:并不是函数结束时开始执行defer栈推出操作，而是每当一个作用域结束就进行该作用域defer执行。
*/


import UIKit





var str = "Hello, playground"

func testDefer(name:String) throws{
    print("1-1")
    if name == ""{
        //这里是作用域2 if的作用域
        print("2-1")
        defer{
            print("2-2")
        }
        print("2-3")
    }
    print("1-2")
    defer{
        print("1-3")
    }
    print("1-4")
    
    if name == "hello"{
        //作用域3
        print("3-1")
        defer{
            print("3-2")
        }
        print("3-3")
        defer{
            print("3-4")
        }
    }
}

try! testDefer("")


func testMySelf(age:Int){
    if age == 12{
        print("我12了")
    }
    defer{
        print("你猜我多少岁")
    }
    defer{
        print("按栈进来的")
    }
}

testMySelf(12)

/*********************************Guard************************************/
//Guard可以理解为确定条件满足，否则返回咯
func testGuard(age:Int){
    guard age > 10 else{
        return
    }
    print("我的年纪\(age)岁")
}

testGuard(19)


class Student {
    private var name = "王云鹏"
    private var age = 12
}

var s = Student()
print(s)


