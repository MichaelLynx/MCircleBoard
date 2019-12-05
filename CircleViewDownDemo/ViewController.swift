//
//  ViewController.swift
//  CircleViewDownDemo
//
//  Created by Zayata on 2019/1/14.
//  Copyright © 2019年 Zayata. All rights reserved.
//

import UIKit
import SnapKit

let WIDTH_SCREEN = Double(UIScreen.main.bounds.size.width)
let HEIGHT_SCREEN = Double(UIScreen.main.bounds.size.height)

class ViewController: UIViewController {

    let basicAngle:Double = 360 / 29.0
    let radius:Double = 100
    let width:Double = 70
    let height:Double = 70
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let array1:[(imageName:String, count:Int)] = [
            ("white", 12),
            ("yellow", 6),
            ("white", 3),
            ("yellow", 9)
        ]
        
        let array2:[(imageType: MCircleItemType, count:Int)] = [
            (.white, 12),
            (.yellow, 6),
            (.green, 13),
            (.red, 9)
        ]
        
        let array3:[String] = ["white", "white", "white", "white", "white", "yellow", "yellow", "yellow", "yellow", "white", "white", "white"]
        
        let array4:[MCircleItemType] = [.white, .white, .white, .white, .white, .yellow, .yellow, .yellow, .yellow, .yellow, .black, .black, .black, .black, .red, .red, .red]
        
//        let circleBoard = MCircleBoard(array: array1, itemWidth: 24, isClockWise: true)
        let circleBoard = MCircleBoard(defaultArray: array2)
        view.addSubview(circleBoard)
         
        circleBoard.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(200)
            make.centerX.equalTo(view)
            make.width.height.equalTo(178)
        }
        circleBoard.backgroundColor = UIColor.orange
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            circleBoard.snp.remakeConstraints { (make) in
                make.top.equalTo(self.view).offset(300)
                make.centerX.equalTo(self.view)
                make.width.height.equalTo(200)
            }
            //circleBoard.setInterface(defaultArray: [(.white, 12),(.yellow, 5), (.black, 10) ,(.red, 13)])
            //circleBoard.setInterface(array: array3)
            circleBoard.setInterface(defaultArray: array4, isClockWise: false)
        }
    }
}

