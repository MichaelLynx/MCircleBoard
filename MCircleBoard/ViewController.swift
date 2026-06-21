//
//  ViewController.swift
//  MCircleBoard
//
//  Created by Lynx on 2019/1/14.
//  Copyright © 2019年 Lynx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let array1:[(imageName:String, count:Int)] = [
            ("black", 5),
            ("green", 6),
            ("black", 3),
            ("green", 3)
        ]
        
        let array2:[String] = [
            "black",
            "black",
            "black",
            "black",
            "black",
            "blue",
            "blue",
            "blue",
            "blue",
            "red",
            "red",
            "red"
        ]
        
        let array3:[(imageType: MCircleItemType, count:Int)] = [
            (.purple, 12),
            (.yellow, 6),
            (.green, 13),
            (.red, 9)
        ]
        
        let circleBoard = MCircleBoard(array: array1)
        circleBoard.frame = CGRect(x: 100, y: 60, width: 200, height: 200)
        view.addSubview(circleBoard)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            circleBoard.setupInterface(array: array2)
            circleBoard.setupInterface(array: array3, isClockwise: false)
        }
        
    }
}
