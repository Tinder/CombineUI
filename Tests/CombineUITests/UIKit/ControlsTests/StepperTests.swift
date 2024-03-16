//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import Nimble
import XCTest

final class StepperTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @Stepper var stepper: TestStepper = .init()
    }

    private final class TestStepper: UIStepper {

        private(set) var targets: [ObjectIdentifier: ControlTarget] = [:]

        func invoke(_ value: Double) {
            self.value = value
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
    func testStepper() {
        let viewController: TestViewController = .init()
        let stepper: TestStepper = viewController.stepper
        var receivedValues: [Double] = []
        viewController
            .$stepper
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(stepper.targets.count) == 1
        expect(receivedValues) == [0]
        stepper.invoke(1)
        expect(receivedValues) == [0, 1]
        stepper.invoke(2)
        expect(receivedValues) == [0, 1, 2]
    }
}
