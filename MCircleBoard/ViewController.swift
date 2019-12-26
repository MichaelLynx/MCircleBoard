//
//  ViewController.swift
//  MCircleBoard
//
//  Created by Lynx on 2019/1/14.
//  Copyright © 2019年 Lynx. All rights reserved.
//

import UIKit

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
            ("black", 5),
            ("green", 6),
            ("black", 3),
            ("green", 3)
        ]
        
        let array2:[(imageType: MCircleItemType, count:Int)] = [
            (.purple, 12),
            (.yellow, 6),
            (.green, 13),
            (.red, 9)
        ]
        
        let array3:[String] = ["black",
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
                               "red"]
        
        let array4:[MCircleItemType] = [.white, .white, .white, .white, .white, .yellow, .yellow, .yellow, .yellow, .yellow, .black, .black, .black, .black, .red, .red, .red]
        
        let circleBoard = MCircleBoard(array: array1)
        circleBoard.frame = CGRect(x: 100, y: 60, width: 200, height: 200)
        view.addSubview(circleBoard)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            circleBoard.setInterface(array: array2)
            circleBoard.setInterface(array: array3)
            //circleBoard.setInterface(array: array4)
        }
        
    }
}

