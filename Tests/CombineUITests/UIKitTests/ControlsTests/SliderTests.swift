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

final class SliderTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @Slider var slider: TestSlider = .init()
    }

    private final class TestSlider: UISlider {

        private(set) var targets: [ObjectIdentifier: ControlTarget] = [:]

        func invoke(_ value: Float) {
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
    func testSlider() {
        let viewController: TestViewController = .init()
        let slider: TestSlider = viewController.slider
        var receivedValues: [Float] = []
        viewController
            .$slider
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(slider.targets.count) == 1
        expect(receivedValues) == [0]
        slider.invoke(0.5)
        expect(receivedValues) == [0, 0.5]
        slider.invoke(1)
        expect(receivedValues) == [0, 0.5, 1]
    }
}
