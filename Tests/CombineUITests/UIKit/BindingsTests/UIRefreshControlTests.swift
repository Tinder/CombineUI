//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UIRefreshControlTests: XCTestCase {

    func testRefreshControl() {
        let refreshControl: UIRefreshControl = .init()
        expect(refreshControl.isRefreshing) == false
        refreshControl.bindable.isRefreshing.receiveValue(true)
        expect(refreshControl.isRefreshing) == true
        refreshControl.bindable.isRefreshing.receiveValue(false)
        expect(refreshControl.isRefreshing) == false
    }
}
