//
//  ViewController.swift
//  闭包回调
//
//  Created by 王云鹏 on 15/12/23.
//  Copyright © 2015年 Pony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var second:SecondViewController? = SecondViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(type:UIButtonType.System)
        btn.frame = CGRectMake(100, 100, 100, 100)
        btn.backgroundColor = UIColor.redColor()
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.setTitle("present", forState: UIControlState.Normal)
        self.view.addSubview(btn)
        btn.addTarget(self, action: "btnClick:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func btnClick(btn:UIButton){
        self.second!.view.backgroundColor = UIColor.blueColor()
        self.presentViewController(self.second!, animated:true, completion: nil)
        self.second!.callBack = ({[unowned self] color in
                        self.view.backgroundColor = color
                        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

