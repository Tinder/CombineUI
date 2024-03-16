//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import Nimble
import XCTest

final class SwitchTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @Switch var `switch`: TestSwitch = .init()
    }

    private final class TestSwitch: UISwitch {

        private(set) var targets: [ObjectIdentifier: ControlTarget] = [:]

        func invoke(_ isOn: Bool) {
            self.isOn = isOn
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
    func testSwitch() {
        let viewController: TestViewController = .init()
        let `switch`: TestSwitch = viewController.switch
        var receivedValues: [Bool] = []
        viewController
            .$switch
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(`switch`.targets.count) == 1
        expect(receivedValues) == [false]
        `switch`.invoke(true)
        expect(receivedValues) == [false, true]
        `switch`.invoke(false)
        expect(receivedValues) == [false, true, false]
    }
}
