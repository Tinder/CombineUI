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

        private var _isRefreshing: Bool = false

        override func beginRefreshing() {
            _isRefreshing = true
        }

        override func endRefreshing() {
            _isRefreshing = false
        }
    }

    @MainActor
    func testTintColor() {
        let refreshControl: TestRefreshControl = .init()
        refreshControl.tintColor = .systemMint
        expect(refreshControl.tintColor) == .systemMint
        refreshControl.bindable.tintColor.receiveValue(.systemPink)
        expect(refreshControl.tintColor) == .systemPink
    }

    @MainActor
    func testAttributedTitle() {
        let refreshControl: TestRefreshControl = .init()
        expect(refreshControl.attributedTitle) == nil
        refreshControl.bindable.attributedTitle.receiveValue(AttributedString("Attributed Text"))
        expect(refreshControl.attributedTitle?.string) == "Attributed Text"
    }

    @MainActor
    func testIsRefreshing() {
        let refreshControl: TestRefreshControl = .init()
        expect(refreshControl.isRefreshing) == false
        refreshControl.bindable.isRefreshing.receiveValue(true)
        expect(refreshControl.isRefreshing) == true
        refreshControl.bindable.isRefreshing.receiveValue(false)
        expect(refreshControl.isRefreshing) == false
    }
}
