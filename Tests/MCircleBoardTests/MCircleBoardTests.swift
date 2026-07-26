import UIKit
import XCTest

@testable import MCircleBoard

final class MCircleBoardTests: XCTestCase {
    @MainActor
    func testDefaultImageLoadsFromPackageResources() {
        let board = MCircleBoard(array: [MCircleItemType.black])
        let imageView = board.subviews.first as? UIImageView

        XCTAssertEqual(board.allCount, 1)
        XCTAssertNotNil(imageView?.image)
    }

    @MainActor
    func testSetupInterfaceUpdatesItemCount() {
        let board = MCircleBoard()

        board.setupInterface(
            array: [
                (imageType: MCircleItemType.black, count: 2),
                (imageType: MCircleItemType.red, count: 3)
            ]
        )

        XCTAssertEqual(board.allCount, 5)
        XCTAssertEqual(board.subviews.count, 5)
    }
}
