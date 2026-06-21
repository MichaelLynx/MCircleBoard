//
//  MCircleBoard.swift
//  MCircleBoard
//
//  Created by Lynx on 2019/1/15.
//  Copyright © 2019年 Lynx. All rights reserved.
//

import UIKit

public enum MCircleItemType: String {
    case white      = "circleicon_white"
    case black      = "circleicon_black"
    case grey       = "circleicon_grey"
    case red        = "circleicon_red"
    case yellow     = "circleicon_yellow"
    case blue       = "circleicon_blue"
    case lightblue  = "circleicon_lightblue"
    case green      = "circleicon_green"
    case purple     = "circleicon_purple"
}

public class MCircleBoard: UIView {
    @objc public private(set) var allcount: Int = 0
    @objc public var isclockwise: Bool = true {
        didSet {
            guard oldValue != isclockwise else { return }
            updateImageViewTransforms()
            setNeedsLayout()
        }
    }
    @objc public var itemwidth: Double = 24 {
        didSet {
            guard oldValue != itemwidth else { return }
            setNeedsLayout()
        }
    }
    @objc public var basicAngle: Double {
        guard allcount > 0 else { return 0 }
        return 360.0 / Double(allcount)
    }

    //The direction of the circle.
    private var clockwise: Double {
        //The tag of clockwise.
        return isclockwise ? 1.0 : -1.0
    }

    private enum MCircleImageSource {
        case imageName(String)
        case imageType(MCircleItemType)
    }

    private var imageSources: [MCircleImageSource] = []
    private var imageViews: [UIImageView] = []

    private static let bundleImageCache = NSCache<NSString, UIImage>()
    private static let resourceBundle: Bundle = {
        let bundle = Bundle(for: MCircleBoard.self)
        if let resourcePath = bundle.path(forResource: "MCircleBoard", ofType: "bundle"),
           let resourceBundle = Bundle(path: resourcePath) {
            return resourceBundle
        }
        return bundle
    }()

    public init() {
        super.init(frame: CGRect.zero)
    }

    ///[Tuple]Init.
    public init(array: [(imageName: String, count: Int)], itemWidth: Double = 24, isClockWise: Bool = true) {
        super.init(frame: CGRect.zero)

        itemwidth = itemWidth
        isclockwise = isClockWise
        setupImage(array: array)
    }

    ///[Tuple]Init with default image.
    public init(array: [(imageType: MCircleItemType, count: Int)], itemWidth: Double = 24, isClockWise: Bool = true) {
        super.init(frame: CGRect.zero)

        itemwidth = itemWidth
        isclockwise = isClockWise
        setupImage(defaultArray: array)
    }

    ///[Array]Init.
    @objc public init(array: [String], itemWidth: Double = 24, isClockWise: Bool = true) {
        super.init(frame: CGRect.zero)

        itemwidth = itemWidth
        isclockwise = isClockWise
        setupImage(array: array)
    }

    ///[Array]Init.Item width: 24,direction: clockwise.
    @objc public init(array: [String]) {
        super.init(frame: CGRect.zero)

        setupImage(array: array)
    }

    ///[Array]Init with default image.
    public init(array: [MCircleItemType], itemWidth: Double = 24, isClockWise: Bool = true) {
        super.init(frame: CGRect.zero)

        itemwidth = itemWidth
        isclockwise = isClockWise
        setupImage(defaultArray: array)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //Setup frame.
    override public func layoutSubviews() {
        super.layoutSubviews()

        guard allcount > 0 else { return }

        //The first item is the bottom one.And the default direction is clockwise.
        let itemWidth = max(0, CGFloat(itemwidth))
        let side = min(bounds.width, bounds.height)
        let radius = max(0, (side - itemWidth) / 2.0)
        let bottomCenter = CGPoint(x: bounds.midX, y: bounds.midY + radius)

        for index in 0 ..< allcount {
            let aImageView = getImageView(index: index)
            aImageView.bounds = CGRect(x: 0, y: 0, width: itemWidth, height: itemWidth)
            aImageView.center = borderItemCenter(circleCenter: bottomCenter, radius: Double(radius), index: index)
        }
    }

    //MARK: - Public Method

    ///[Tuple]Reset the item array.
    public func setupInterface(array: [(imageName: String, count: Int)], isClockWise: Bool? = nil) {
        updateClockWise(isClockWise)
        setupImage(array: array)
    }

    ///[Tuple]Reset the item array with default image.
    public func setupInterface(array: [(imageType: MCircleItemType, count: Int)], isClockWise: Bool? = nil) {
        updateClockWise(isClockWise)
        setupImage(defaultArray: array)
    }

    ///[Array]Reset the item array.
    public func setupInterface(array: [String], isClockWise: Bool? = nil) {
        updateClockWise(isClockWise)
        setupImage(array: array)
    }

    ///[Array]Reset the item array.
    @objc public func setupInterface(array: [String]) {
        setupImage(array: array)
    }

    //[Array]Reset the item array with default image.
    public func setupInterface(array: [MCircleItemType], isClockWise: Bool? = nil) {
        updateClockWise(isClockWise)
        setupImage(defaultArray: array)
    }

    //MARK: - Private Method

    private func updateClockWise(_ isClockWise: Bool?) {
        if let isClockWise = isClockWise {
            isclockwise = isClockWise
        }
    }

    ///[Tuple]Setup image for items of the array.
    private func setupImage(array: [(imageName: String, count: Int)]) {
        let sources = array.flatMap { item -> [MCircleImageSource] in
            guard item.count > 0 else { return [] }
            return Array(repeating: MCircleImageSource.imageName(item.imageName), count: item.count)
        }
        setupImageSources(array: sources)
    }

    ///[Tuple]Setup default image for items of the array.
    private func setupImage(defaultArray: [(imageType: MCircleItemType, count: Int)]) {
        let sources = defaultArray.flatMap { item -> [MCircleImageSource] in
            guard item.count > 0 else { return [] }
            return Array(repeating: MCircleImageSource.imageType(item.imageType), count: item.count)
        }
        setupImageSources(array: sources)
    }

    ///[Array]Setup image for items of the array.
    private func setupImage(array: [String]) {
        let sources = array.map { MCircleImageSource.imageName($0) }
        setupImageSources(array: sources)
    }

    ///[Array]Setup default image for items of the array.
    private func setupImage(defaultArray: [MCircleItemType]) {
        let sources = defaultArray.map { MCircleImageSource.imageType($0) }
        setupImageSources(array: sources)
    }

    private func setupImageSources(array: [MCircleImageSource]) {
        imageSources = array
        allcount = array.count
        updateImageViews()
        updateImageViewImages()
        updateImageViewTransforms()
        setNeedsLayout()
    }

    private func updateImageViews() {
        while imageViews.count > allcount {
            let imageView = imageViews.removeLast()
            imageView.removeFromSuperview()
        }

        while imageViews.count < allcount {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = false
            imageViews.append(imageView)
            addSubview(imageView)
        }
    }

    private func updateImageViewImages() {
        for index in 0 ..< allcount {
            let imageView = getImageView(index: index)
            imageView.image = getImage(imageSource: imageSources[index])
        }
    }

    private func updateImageViewTransforms() {
        guard allcount > 0 else { return }

        for index in 0 ..< allcount {
            let imageView = getImageView(index: index)
            let angle = basicAngle * Double(index) * clockwise
            let radians = CGFloat(angle * Double.pi / 180.0)
            imageView.transform = CGAffineTransform(rotationAngle: radians)
        }
    }

    private func getImage(imageSource: MCircleImageSource) -> UIImage? {
        switch imageSource {
        case .imageName(let imageName):
            return UIImage(named: imageName)
        case .imageType(let imageType):
            return getBundleImage(imageType: imageType)
        }
    }

    //Get the center point of the rotated item.
    private func borderItemCenter(circleCenter: CGPoint, radius: Double, index: Int) -> CGPoint {
        //Center of the view.
        let xc = Double(circleCenter.x)
        let yc = Double(circleCenter.y)
        //Center of the circle.
        let x0 = Double(bounds.midX)
        let y0 = Double(bounds.midY)

        //Relative coordinates
        let x1 = xc - x0
        let y1 = yc - y0

        let angle = basicAngle * Double(index) * clockwise
        let rAngle = angle * Double.pi / 180

        let x2 = x1 * cos(rAngle) - y1 * sin(rAngle)
        let y2 = y1 * cos(rAngle) + x1 * sin(rAngle)

        let x3 = x2 + x0
        let y3 = y2 + y0

        let itemPoint = CGPoint(x: x3, y: y3)

        return itemPoint
    }

    //Get imageView with index.
    private func getImageView(index: Int) -> UIImageView {
        return imageViews[index]
    }

    private func getBundleImage(imageType: MCircleItemType) -> UIImage {
        let imageName = imageType.rawValue
        let cacheKey = imageName as NSString

        if let cachedImage = MCircleBoard.bundleImageCache.object(forKey: cacheKey) {
            return cachedImage
        }

        let image = UIImage(named: imageName, in: MCircleBoard.resourceBundle, compatibleWith: nil) ?? UIImage()
        MCircleBoard.bundleImageCache.setObject(image, forKey: cacheKey)

        return image
    }
}
