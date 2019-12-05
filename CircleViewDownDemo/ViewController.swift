//
//  ViewController.swift
//  CircleViewDownDemo
//
//  Created by Lynx on 2019/1/14.
//  Copyright © 2019年 Lynx. All rights reserved.
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
            ("circleicon_black", 12),
            ("circleicon_green", 6),
            ("circleicon_black", 3),
            ("circleicon_purple", 9)
        ]
        
        let array2:[(imageType: MCircleItemType, count:Int)] = [
            (.purple, 12),
            (.yellow, 6),
            (.green, 13),
            (.red, 9)
        ]
        
        let array3:[String] = ["circleicon_black",
                               "circleicon_black",
                               "circleicon_black",
                               "circleicon_black",
                               "circleicon_black",
                               "circleicon_lightblue",
                               "circleicon_lightblue",
                               "circleicon_lightblue",
                               "circleicon_lightblue",
                               "circleicon_red",
                               "circleicon_red",
                               "circleicon_red"]
        
        let array4:[MCircleItemType] = [.white, .white, .white, .white, .white, .yellow, .yellow, .yellow, .yellow, .yellow, .black, .black, .black, .black, .red, .red, .red]
        
        let circleBoard1 = MCircleBoard(array: array1)
        circleBoard1.frame = CGRect(x: 10, y: 60, width: 150, height: 150)
        view.addSubview(circleBoard1)
        
        let circleBoard2 = MCircleBoard()
        circleBoard2.setInterface(defaultArray: array2)
        view.addSubview(circleBoard2)
        
        let circleBoard3 = MCircleBoard(array: array3)
        view.addSubview(circleBoard3)
        
        let circleBoard4 = MCircleBoard(defaultArray: array4, isClockWise: false)
        view.addSubview(circleBoard4)
        circleBoard4.backgroundColor = .orange
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            circleBoard1.setInterface(defaultArray: [(.green, 12),(.yellow, 5), (.black, 10) ,(.red, 13)])
            circleBoard3.setInterface(array: array3, isClockWise: false)
        }
        
        circleBoard2.snp_makeConstraints { (make) in
            make.top.equalTo(60)
            make.width.height.equalTo(200)
            make.right.equalTo(view).offset(-20)
        }
        
        circleBoard3.snp_makeConstraints { (make) in
            make.height.width.equalTo(200)
            make.top.equalTo(circleBoard2.snp_bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        circleBoard4.snp_makeConstraints { (make) in
            make.height.width.equalTo(200)
            make.top.equalTo(circleBoard3.snp_bottom).offset(20)
            make.right.equalToSuperview().offset(-50)
        }
    }
}

