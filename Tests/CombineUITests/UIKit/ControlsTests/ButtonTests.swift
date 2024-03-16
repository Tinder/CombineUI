//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import Nimble
import XCTest

final class ButtonTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @Button var button: TestButton = .init()
    }

    private final class TestButton: UIButton {

        private(set) var targets: [ObjectIdentifier: ControlTarget] = [:]

        func invoke() {
            targets.values.forEach { $0.primaryActionTriggered() }
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
    func testButton() {
        let viewController: TestViewController = .init()
        let button: TestButton = viewController.button
        var count: Int = 0
        viewController
            .$button
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(button.targets.count) == 1
        expect(count) == 0
        button.invoke()
        expect(count) == 1
        button.invoke()
        expect(count) == 2
    }
}
