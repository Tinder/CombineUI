//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UISwitchTests: XCTestCase {

    func testIsOn() {
        let `switch`: UISwitch = .init()
        expect(`switch`.isOn) == false
        `switch`.bindable.isOn.receiveValue(true)
        expect(`switch`.isOn) == true
    }

    func testIsOnAnimated() {
        let `switch`: UISwitch = .init()
        expect(`switch`.isOn) == false
        `switch`.bindable.isOn(animated: true).receiveValue(true)
        expect(`switch`.isOn) == true
    }
}
