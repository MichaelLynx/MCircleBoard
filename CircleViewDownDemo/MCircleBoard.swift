//
//  MCircleBoard.swift
//  CircleViewDownDemo
//
//  Created by Lynx on 2019/1/15.
//  Copyright © 2019年 Lynx. All rights reserved.
//

import UIKit

enum MCircleItemType: String {
    case white      = "circleicon_white"
    case black      = "circleicon_black"
    case grey       = "circleicon_grey"
    case red        = "circleicon_red"
    case yellow     = "circleicon_yellow"
    case blue       = "circleicon_blue"
    case lightblue  = "circleicon_lightblue"
    case green      = "circleicon_green"
    case purple     = "circleicon_purple"
    
    typealias RawValue = String
}

class MCircleBoard: UIView {
    private(set) var allcount:Int = 0
    private(set) var isclockwise:Bool = true
    private(set) var itemwidth:Double = 24
    var basicAngle:Double {
        get {
            return 360.0 / Double(allcount)
        }
    }
    //The direction of the circle.
    private var clockwise:Double {
        get {
            //The tag of clockwise.
            return isclockwise ? 1.0 : -1.0
        }
    }
    
    ///[Tuple]Init.
    init(array:[(imageName:String, count:Int)], itemWidth:Double = 24, isClockWise:Bool = true) {
        super.init(frame: CGRect.zero)
        
        itemwidth = itemWidth
        isclockwise = isClockWise
        allcount = 0
        setImage(array: array)
    }
    
    ///[Tuple]Init with default image.
    init(defaultArray:[(imageType:MCircleItemType, count:Int)], itemWidth:Double = 24, isClockWise:Bool = true) {
        super.init(frame: CGRect.zero)
        
        itemwidth = itemWidth
        isclockwise = isClockWise
        allcount = 0
        setImage(defaultArray: defaultArray)
    }
    
    ///[Array]Init.
    init(array:[String], itemWidth:Double = 24, isClockWise:Bool = true) {
        super.init(frame: CGRect.zero)
        
        itemwidth = itemWidth
        isclockwise = isClockWise
        allcount = 0
        setImage(array: array)
    }
    
    ///[Array]Init with default image.
    init(defaultArray:[MCircleItemType], itemWidth:Double = 24, isClockWise:Bool = true) {
        super.init(frame: CGRect.zero)
        
        itemwidth = itemWidth
        isclockwise = isClockWise
        allcount = 0
        setImage(defaultArray: defaultArray)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Setup frame.
    override func layoutSubviews() {
        if allcount > 0 {
            //The first item is the bottom one.And the default direction is clockwise.
            let radius = (Double(frame.width) - itemwidth) / 2.0
            
            let xb = Double(frame.width) / 2.0
            let yb = Double(frame.width) - itemwidth / 2.0
            let bottomCenter = CGPoint(x: xb, y: yb)
            
            for index in 0 ... allcount - 1 {
                let aImageView = getImageView(index: index)
                aImageView.frame = CGRect(x: 0, y: 0, width: itemwidth, height: itemwidth)
                aImageView.center = borderItemCenter(circleCenter: bottomCenter, radius: radius, index: index)
            }
        }
    }
    
    //MARK: - Public Method
    
    ///[Tuple]Reset the item array.
    func setInterface(array: [(imageName:String, count:Int)], isClockWise:Bool? = nil) {
        if let isClockWise = isClockWise {
            isclockwise = isClockWise
        }
        setImage(array: array)
        layoutSubviews()
    }
    
    ///[Tuple]Reset the item array with default image.
    func setInterface(defaultArray: [(imageType:MCircleItemType, count:Int)], isClockWise:Bool? = nil) {
        if let isClockWise = isClockWise {
            isclockwise = isClockWise
        }
        setImage(defaultArray: defaultArray)
        layoutSubviews()
    }
    
    ///[Array]Reset the item array.
    func setInterface(array: [String], isClockWise:Bool? = nil) {
        if let isClockWise = isClockWise {
            isclockwise = isClockWise
        }
        setImage(array: array)
        layoutSubviews()
    }
    
    //[Array]Reset the item array with default image.
    func setInterface(defaultArray: [MCircleItemType], isClockWise:Bool? = nil) {
        if let isClockWise = isClockWise {
            isclockwise = isClockWise
        }
        setImage(defaultArray: defaultArray)
        layoutSubviews()
    }
    
    //MARK: - Private Method
    
    ///[Tuple]Set image for items of the array.
    private func setImage(array: [(imageName:String, count:Int)]) {
        var allCount = 0
        for item in array {
            allCount += item.count
        }
        if allcount == allCount {
            var addup = 0
            for item in array {
                for index in 0 ..< item.count {
                    let count = index + addup
                    
                    let imageView = getImageView(index: count)
                    var image:UIImage!
                    image = UIImage(named: item.imageName)
                    
                    let angle = basicAngle * Double(count) * clockwise
                    image = rotateImage(image, withAngle: angle)
                    imageView.image = image
                }
                addup += item.count
            }
        } else {
            //The length of the array has been changed.
            var allCount = 0
            for item in array {
                allCount += item.count
            }
            
            for index in 0 ..< allcount {
                let imageView = getImageView(index: index)
                imageView.removeFromSuperview()
            }
            allcount = allCount
            
            var addup = 0
            for item in array {
                for index in 0 ..< item.count {
                    let count = index + addup
                    
                    let imageView = UIImageView()
                    imageView.tag = 1000 + count
                    addSubview(imageView)
                    var image:UIImage!
                    image = UIImage(named: item.imageName)
                    
                    let angle = basicAngle * Double(count) * clockwise
                    image = rotateImage(image, withAngle: angle)
                    imageView.image = image
                }
                addup += item.count
            }
        }
    }
    
    ///[Tuple]Set default image for items of the array.
    private func setImage(defaultArray:[(imageType:MCircleItemType, count:Int)]) {
        var allCount = 0
        for item in defaultArray {
            allCount += item.count
        }
        if allcount == allCount {
            var addup = 0
            for item in defaultArray {
                for index in 0 ..< item.count {
                    let count = index + addup
                    
                    let imageView = getImageView(index: count)
                    var image:UIImage!
                    image = UIImage(named: item.imageType.rawValue)
                    
                    let angle = basicAngle * Double(count) * clockwise
                    image = rotateImage(image, withAngle: angle)
                    imageView.image = image
                }
                addup += item.count
            }
        } else {
            //The length of the array has been changed.
            var allCount = 0
            for item in defaultArray {
                allCount += item.count
            }
            
            for index in 0 ..< allcount {
                let imageView = getImageView(index: index)
                imageView.removeFromSuperview()
            }
            allcount = allCount
            
            var addup = 0
            for item in defaultArray {
                for index in 0 ..< item.count {
                    let count = index + addup
                    
                    let imageView = UIImageView()
                    imageView.tag = 1000 + count
                    addSubview(imageView)
                    var image:UIImage!
                    image = UIImage(named: item.imageType.rawValue)
                    
                    let angle = basicAngle * Double(count) * clockwise
                    image = rotateImage(image, withAngle: angle)
                    imageView.image = image
                }
                addup += item.count
            }
        }
    }
    
    ///[Array]Set image for items of the array.
    private func setImage(array: [String]) {
        let allCount = array.count
        
        if allcount == allCount {
            for index in 0 ..< array.count {
                let imageName = array[index]
                
                let imageView = getImageView(index: index)
                var image:UIImage!
                image = UIImage(named: imageName)
                
                let angle = basicAngle * Double(index) * clockwise
                image = rotateImage(image, withAngle: angle)
                imageView.image = image
            }
        } else {
            //The length of the array has been changed.
            let allCount = array.count
            
            for index in 0 ..< allcount {
                let imageView = getImageView(index: index)
                imageView.removeFromSuperview()
            }
            allcount = allCount
            
            for index in 0 ..< array.count {
                let imageName = array[index]
                
                let imageView = UIImageView()
                imageView.tag = 1000 + index
                addSubview(imageView)
                var image:UIImage!
                image = UIImage(named: imageName)
                
                let angle = basicAngle * Double(index) * clockwise
                image = rotateImage(image, withAngle: angle)
                imageView.image = image
            }
        }
    }
    
    ///[Array]Set default image for items of the array.
    private func setImage(defaultArray:[MCircleItemType]) {
        let allCount = defaultArray.count
        
        if allcount == allCount {
            for index in 0 ..< defaultArray.count {
                let imageType = defaultArray[index]
                
                let imageView = getImageView(index: index)
                var image:UIImage!
                image = UIImage(named: imageType.rawValue)
                
                let angle = basicAngle * Double(index) * clockwise
                image = rotateImage(image, withAngle: angle)
                imageView.image = image
            }
        } else {
            //The length of the array has been changed.
            let allCount = defaultArray.count
            
            for index in 0 ..< allcount {
                let imageView = getImageView(index: index)
                imageView.removeFromSuperview()
            }
            allcount = allCount
            
            for index in 0 ..< defaultArray.count {
                let imageType = defaultArray[index]
                
                let imageView = UIImageView()
                imageView.tag = 1000 + index
                addSubview(imageView)
                var image:UIImage!
                image = UIImage(named: imageType.rawValue)
                
                let angle = basicAngle * Double(index) * clockwise
                image = rotateImage(image, withAngle: angle)
                imageView.image = image
            }
        }
    }
    
    //Get the center point of the rotated item.
    private func borderItemCenter(circleCenter:CGPoint, radius:Double, index: Int) -> CGPoint {
        
        //Center of the view.
        let xc:Double = Double(circleCenter.x)
        let yc:Double = Double(circleCenter.y)
        //Center of the circle.
        let x0 = Double(bounds.size.width) / 2.0
        let y0 = Double(bounds.size.height) / 2.0
        
        //Relative coordinates
        let x1 = xc - x0
        let y1 = yc - y0
        
        let angle = basicAngle * Double(index) * clockwise
        let rAngle = angle * Double.pi / 180
        
        let x2 = x1*cos(rAngle) - y1*sin(rAngle)
        let y2 = y1*cos(rAngle) + x1*sin(rAngle)
        
        let x3 = x2 + x0
        let y3 = y2 + y0
        
        let itemPoint = CGPoint(x: x3, y: y3)
        
        return itemPoint
    }
    
    //Get imageView with tag.
    private func getImageView(index:Int) -> UIImageView {
        let imageView = viewWithTag(index + 1000) as! UIImageView
        return imageView
    }
    
    ///Rotate the image with angle(℃)
    private func rotateImage(_ image: UIImage, withAngle angle: Double) -> UIImage? {
        let imageSize = CGSize(width: image.size.width * image.scale, height: image.size.height * image.scale)
        
        UIGraphicsBeginImageContext(imageSize)
        let context = UIGraphicsGetCurrentContext()
        
        context?.translateBy(x: imageSize.width / 2.0, y: imageSize.height / 2.0)
        context?.rotate(by: CGFloat(angle * Double.pi / 180.0))
        context?.translateBy(x: -imageSize.width / 2.0, y: -imageSize.height / 2.0)
        
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rotatedImage
    }
}
