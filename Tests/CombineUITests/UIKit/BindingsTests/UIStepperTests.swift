//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UIStepperTests: XCTestCase {

    func testStepper() {
        let stepper: UIStepper = .init()
        expect(stepper.value) == 0
        stepper.bindable.value.receiveValue(1)
        expect(stepper.value) == 1
    }
}
