//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

@testable import CombineUI
import Nimble
import XCTest

final class UIDatePickerTests: XCTestCase {

    @MainActor
    func testCountDownDuration() {
        let datePicker: UIDatePicker = .init()
        datePicker.datePickerMode = .countDownTimer
        let duration: TimeInterval = 120
        expect(datePicker.countDownDuration) != duration
        datePicker.bindable.countDownDuration.receiveValue(duration)
        expect(datePicker.countDownDuration) == duration
    }

    @MainActor
    func testDate() {
        let datePicker: UIDatePicker = .init()
        let date: Date = .init(timeIntervalSinceReferenceDate: 0)
        expect(datePicker.date) != date
        datePicker.bindable.date.receiveValue(date)
        expect(datePicker.date) == date
    }

    @MainActor
    func testDateAnimated() {
        let datePicker: UIDatePicker = .init()
        let date: Date = .init(timeIntervalSinceReferenceDate: 0)
        expect(datePicker.date) != date
        datePicker.bindable.date(animated: true).receiveValue(date)
        expect(datePicker.date) == date
    }
}
