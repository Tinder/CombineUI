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

final class PageControlTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @PageControl var pageControl: TestPageControl = {
            let pageControl: TestPageControl = .init()
            pageControl.numberOfPages = 3
            return pageControl
        }()
    }

    private final class TestPageControl: UIPageControl {

        private(set) var targets: [ObjectIdentifier: ControlTarget] = [:]

        func invoke(_ currentPage: Int) {
            self.currentPage = currentPage
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
    func testPageControl() {
        let viewController: TestViewController = .init()
        let pageControl: TestPageControl = viewController.pageControl
        var receivedValues: [Int] = []
        viewController
            .$pageControl
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(pageControl.targets.count) == 1
        expect(receivedValues) == [0]
        pageControl.invoke(1)
        expect(receivedValues) == [0, 1]
        pageControl.invoke(2)
        expect(receivedValues) == [0, 1, 2]
    }
}
