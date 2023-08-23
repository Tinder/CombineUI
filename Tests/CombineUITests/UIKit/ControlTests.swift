//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import Nimble
import XCTest

final class ControlTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @Control var control: TestControl = .init()
    }

    private final class TestControl: UIControl {

        private(set) var targets: [ObjectIdentifier: ControlTarget] = [:]

        // swiftlint:disable:next cyclomatic_complexity
        func invoke(_ controlEvents: UIControl.Event) {
            for target: ControlTarget in targets.values {
                if controlEvents.contains(.touchDown) {
                    target.touchDown()
                }
                if controlEvents.contains(.touchDownRepeat) {
                    target.touchDownRepeat()
                }
                if controlEvents.contains(.touchDragInside) {
                    target.touchDragInside()
                }
                if controlEvents.contains(.touchDragOutside) {
                    target.touchDragOutside()
                }
                if controlEvents.contains(.touchDragEnter) {
                    target.touchDragEnter()
                }
                if controlEvents.contains(.touchDragExit) {
                    target.touchDragExit()
                }
                if controlEvents.contains(.touchUpInside) {
                    target.touchUpInside()
                }
                if controlEvents.contains(.touchUpOutside) {
                    target.touchUpOutside()
                }
                if controlEvents.contains(.touchCancel) {
                    target.touchCancel()
                }
                if controlEvents.contains(.valueChanged) {
                    target.valueChanged()
                }
                if controlEvents.contains(.menuActionTriggered) {
                    target.menuActionTriggered()
                }
                if controlEvents.contains(.primaryActionTriggered) {
                    target.primaryActionTriggered()
                }
                if controlEvents.contains(.editingDidBegin) {
                    target.editingDidBegin()
                }
                if controlEvents.contains(.editingChanged) {
                    target.editingChanged()
                }
                if controlEvents.contains(.editingDidEnd) {
                    target.editingDidEnd()
                }
                if controlEvents.contains(.editingDidEndOnExit) {
                    target.editingDidEndOnExit()
                }
            }
        }

        func invokeAllInDeterministicOrder() {
            invoke(.touchDown)
            invoke(.touchDownRepeat)
            invoke(.touchDragInside)
            invoke(.touchDragOutside)
            invoke(.touchDragEnter)
            invoke(.touchDragExit)
            invoke(.touchUpInside)
            invoke(.touchUpOutside)
            invoke(.touchCancel)
            invoke(.valueChanged)
            invoke(.menuActionTriggered)
            invoke(.primaryActionTriggered)
            invoke(.editingDidBegin)
            invoke(.editingChanged)
            invoke(.editingDidEnd)
            invoke(.editingDidEndOnExit)
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

    func testAllEvents() {
        let control: TestControl = .init()
        var events: [UIControl.Event] = []
        control
            .publisher(for: .allEvents)
            .sink { events.append($0) }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(events.isEmpty) == true
        control.invokeAllInDeterministicOrder()
        expect(events) == [
            .touchDown,
            .touchDownRepeat,
            .touchDragInside,
            .touchDragOutside,
            .touchDragEnter,
            .touchDragExit,
            .touchUpInside,
            .touchUpOutside,
            .touchCancel,
            .valueChanged,
            .menuActionTriggered,
            .primaryActionTriggered,
            .editingDidBegin,
            .editingChanged,
            .editingDidEnd,
            .editingDidEndOnExit
        ]
        cancellables.removeAll()
        control.invokeAllInDeterministicOrder()
        expect(events) == [
            .touchDown,
            .touchDownRepeat,
            .touchDragInside,
            .touchDragOutside,
            .touchDragEnter,
            .touchDragExit,
            .touchUpInside,
            .touchUpOutside,
            .touchCancel,
            .valueChanged,
            .menuActionTriggered,
            .primaryActionTriggered,
            .editingDidBegin,
            .editingChanged,
            .editingDidEnd,
            .editingDidEndOnExit
        ]
    }

    func testAllEditingEvents() {
        let control: TestControl = .init()
        var events: [UIControl.Event] = []
        control
            .publisher(for: .allEditingEvents)
            .sink { events.append($0) }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(events.isEmpty) == true
        control.invokeAllInDeterministicOrder()
        expect(events) == [
            .editingDidBegin,
            .editingChanged,
            .editingDidEnd,
            .editingDidEndOnExit
        ]
        cancellables.removeAll()
        control.invokeAllInDeterministicOrder()
        expect(events) == [
            .editingDidBegin,
            .editingChanged,
            .editingDidEnd,
            .editingDidEndOnExit
        ]
    }

    func testTouchDown() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .touchDown
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.touchDown)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testTouchDownRepeat() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .touchDownRepeat
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.touchDownRepeat)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testTouchDragInside() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .touchDragInside
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.touchDragInside)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testTouchDragOutside() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .touchDragOutside
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.touchDragOutside)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testTouchDragEnter() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .touchDragEnter
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.touchDragEnter)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testTouchDragExit() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .touchDragExit
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.touchDragExit)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testTouchUpInside() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .touchUpInside
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.touchUpInside)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testTouchUpOutside() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .touchUpOutside
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.touchUpOutside)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testTouchCancel() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .touchCancel
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.touchCancel)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testValueChanged() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .valueChanged
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.valueChanged)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testMenuActionTriggered() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .menuActionTriggered
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.menuActionTriggered)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testPrimaryActionTriggered() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .primaryActionTriggered
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.primaryActionTriggered)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testEditingDidBegin() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .editingDidBegin
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.editingDidBegin)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testEditingChanged() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .editingChanged
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.editingChanged)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testEditingDidEnd() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .editingDidEnd
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.editingDidEnd)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }

    func testEditingDidEndOnExit() {
        let viewController: TestViewController = .init()
        let control: TestControl = viewController.control
        var count: Int = 0
        viewController
            .$control
            .editingDidEndOnExit
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(control.targets.count) == 1
        expect(count) == 0
        control.invoke(.editingDidEndOnExit)
        expect(count) == 1
        control.invoke(.allEvents)
        expect(count) == 2
    }
}
