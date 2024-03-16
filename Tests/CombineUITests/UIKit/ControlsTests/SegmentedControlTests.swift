//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import Nimble
import XCTest

final class SegmentedControlTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @SegmentedControl var segmentedControl: TestSegmentedControl = .init(items: ["one", "two", "three"])
    }

    private final class TestSegmentedControl: UISegmentedControl {

        private(set) var targets: [ObjectIdentifier: ControlTarget] = [:]

        func invoke(_ selectedSegmentIndex: Int) {
            self.selectedSegmentIndex = selectedSegmentIndex
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
    func testSegmentedControl() {
        let viewController: TestViewController = .init()
        let segmentedControl: TestSegmentedControl = viewController.segmentedControl
        var receivedValues: [Int] = []
        viewController
            .$segmentedControl
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(segmentedControl.targets.count) == 1
        expect(receivedValues) == [-1]
        segmentedControl.invoke(1)
        expect(receivedValues) == [-1, 1]
        segmentedControl.invoke(2)
        expect(receivedValues) == [-1, 1, 2]
    }
}
