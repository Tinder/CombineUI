//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

@MainActor
final class UISwitchTests: XCTestCase {

    func testOnTintColor() {
        let `switch`: UISwitch = .init()
        expect(`switch`.onTintColor) == nil
        `switch`.bindable.onTintColor.receiveValue(.systemPink)
        expect(`switch`.onTintColor) == .systemPink
    }

    func testThumbTintColor() {
        let `switch`: UISwitch = .init()
        expect(`switch`.thumbTintColor) == nil
        `switch`.bindable.thumbTintColor.receiveValue(.systemPink)
        expect(`switch`.thumbTintColor) == .systemPink
    }

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
