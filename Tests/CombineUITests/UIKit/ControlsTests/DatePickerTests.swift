//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import Nimble
import XCTest

@MainActor
final class DatePickerTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @DatePicker var datePicker: TestDatePicker = .init()

        @DatePicker(mode: .countDownTimer)
        var countDownTimerDatePicker: TestDatePicker = .init()
    }

    private final class TestDatePicker: UIDatePicker {

        private(set) var targets: [ObjectIdentifier: ControlTarget] = [:]

        func invoke(_ date: Date) {
            self.date = date
            targets.values.forEach { $0.valueChanged() }
        }

        func invoke(_ countDownDuration: TimeInterval) {
            self.countDownDuration = countDownDuration
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

    func testDate() {
        let viewController: TestViewController = .init()
        let datePicker: TestDatePicker = viewController.datePicker
        var receivedValues: [Date] = []
        viewController
            .$datePicker
            .date
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(receivedValues.count) == 1
        expect(receivedValues[0].timeIntervalSinceNow) < 0.0001
        let date1: Date = .init()
        datePicker.invoke(date1)
        expect(receivedValues.dropFirst()) == [date1]
        let date2: Date = .init()
        datePicker.invoke(date2)
        expect(receivedValues.dropFirst()) == [date1, date2]
    }

    func testCountDownDuration() {
        let viewController: TestViewController = .init()
        let datePicker: TestDatePicker = viewController.countDownTimerDatePicker
        var receivedValues: [TimeInterval] = []
        viewController
            .$countDownTimerDatePicker
            .countDownDuration
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(receivedValues) == [60]
        datePicker.invoke(120)
        expect(receivedValues) == [60, 120]
        datePicker.invoke(180)
        expect(receivedValues) == [60, 120, 180]
    }
}
