//
//  SecondViewController.swift
//  闭包回调
//
//  Created by 王云鹏 on 15/12/23.
//  Copyright © 2015年 Pony. All rights reserved.
//

import UIKit
typealias callBackValue = (value:UIColor) ->Void

class SecondViewController: UIViewController {
    var callBack:callBackValue?

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(type:UIButtonType.System)
        btn.frame = CGRectMake(100, 100, 100, 100)
        btn.backgroundColor = UIColor.redColor()
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.setTitle("action", forState: UIControlState.Normal)
        self.view.addSubview(btn)
        btn.addTarget(self, action: "btnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let btn2 = UIButton(type:UIButtonType.System)
        btn2.frame = CGRectMake(100, 220, 100, 100)
        btn2.backgroundColor = UIColor.yellowColor()
        btn2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn2.setTitle("dismiss", forState: UIControlState.Normal)
        self.view.addSubview(btn2)
        btn2.addTarget(self, action: "dismiss:", forControlEvents: UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view.
    }
    
    
    func btnClick(btn:UIButton){
        if let call = self.callBack{
            call(value: UIColor.orangeColor())
        }
    }
    

    func dismiss(btn:UIButton){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        debugPrint("被销毁了")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
