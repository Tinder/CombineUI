//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UIStepperTests: XCTestCase {

    func testIsContinuous() {
        let stepper: UIStepper = .init()
        expect(stepper.isContinuous) == true
        stepper.bindable.isContinuous.receiveValue(false)
        expect(stepper.isContinuous) == false
    }

    func testAutorepeat() {
        let stepper: UIStepper = .init()
        expect(stepper.autorepeat) == true
        stepper.bindable.autorepeat.receiveValue(false)
        expect(stepper.autorepeat) == false
    }

    func testWraps() {
        let stepper: UIStepper = .init()
        expect(stepper.wraps) == false
        stepper.bindable.wraps.receiveValue(true)
        expect(stepper.wraps) == true
    }

    func testMinimumValue() {
        let stepper: UIStepper = .init()
        expect(stepper.minimumValue) == 0
        stepper.bindable.minimumValue.receiveValue(1)
        expect(stepper.minimumValue) == 1
    }

    func testMaximumValue() {
        let stepper: UIStepper = .init()
        expect(stepper.maximumValue) == 100
        stepper.bindable.maximumValue.receiveValue(200)
        expect(stepper.maximumValue) == 200
    }

    func testStepValue() {
        let stepper: UIStepper = .init()
        expect(stepper.stepValue) == 1
        stepper.bindable.stepValue.receiveValue(10)
        expect(stepper.stepValue) == 10
    }

    func testValue() {
        let stepper: UIStepper = .init()
        expect(stepper.value) == 0
        stepper.bindable.value.receiveValue(1)
        expect(stepper.value) == 1
    }
}
