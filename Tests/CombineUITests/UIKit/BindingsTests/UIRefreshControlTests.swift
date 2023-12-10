//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UIRefreshControlTests: XCTestCase {

    private final class TestRefreshControl: UIRefreshControl {

        override var isRefreshing: Bool {
            _isRefreshing
        }

        // swiftlint:disable:next redundant_type_annotation
        private var _isRefreshing: Bool = false

        override func beginRefreshing() {
            _isRefreshing = true
        }

        override func endRefreshing() {
            _isRefreshing = false
        }
    }

    func testRefreshControl() {
        let refreshControl: TestRefreshControl = .init()
        expect(refreshControl.isRefreshing) == false
        refreshControl.bindable.isRefreshing.receiveValue(true)
        expect(refreshControl.isRefreshing) == true
        refreshControl.bindable.isRefreshing.receiveValue(false)
        expect(refreshControl.isRefreshing) == false
    }
}
