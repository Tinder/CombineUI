//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import Combine
import CombineUI
import Nimble
import XCTest

final class RefreshControlTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @RefreshControl var refreshControl: TestRefreshControl = .init()
    }

    private final class TestRefreshControl: UIRefreshControl {

        private(set) var targets: [ObjectIdentifier: ControlTarget] = [:]

        func invoke(_ isRefreshing: Bool) {
            if isRefreshing {
                beginRefreshing()
                targets.values.forEach { $0.primaryActionTriggered() }
            } else {
                endRefreshing()
            }
        }

        override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
            if let target: ControlTarget = target as? ControlTarget {
                targets[ObjectIdentifier(target)] = target
            }
            super.addTarget(target, action: action, for: controlEvents)
        }
    }

    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = Set()
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    @MainActor
    func testRefreshControl() {
        let viewController: TestViewController = .init()
        let refreshControl: TestRefreshControl = viewController.refreshControl
        var count: Int = 0
        viewController
            .$refreshControl
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(refreshControl.targets.count) == 1
        expect(count) == 0
        refreshControl.invoke(true)
        expect(count) == 1
        refreshControl.invoke(false)
        expect(count) == 1
        refreshControl.invoke(true)
        expect(count) == 2
        refreshControl.invoke(false)
        expect(count) == 2
    }
}
