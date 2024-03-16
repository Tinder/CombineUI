//
//  Copyright © 2023 Tinder (Match Group, LLC)
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

        override var isRefreshing: Bool {
            _isRefreshing
        }

        // swiftlint:disable:next redundant_type_annotation
        private var _isRefreshing: Bool = false

        private(set) var targets: [ObjectIdentifier: ControlTarget] = [:]

        override func beginRefreshing() {
            _isRefreshing = true
        }

        override func endRefreshing() {
            _isRefreshing = false
        }

        func invoke(_ isRefreshing: Bool) {
            if isRefreshing {
                beginRefreshing()
            } else {
                endRefreshing()
            }
            targets.values.forEach { $0.valueChanged() }
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
