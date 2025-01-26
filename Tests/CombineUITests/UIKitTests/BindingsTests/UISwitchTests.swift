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

final class UISwitchTests: XCTestCase {

    @MainActor
    func testOnTintColor() {
        let `switch`: UISwitch = .init()
        expect(`switch`.onTintColor) == nil
        `switch`.bindable.onTintColor.receiveValue(.systemPink)
        expect(`switch`.onTintColor) == .systemPink
    }

    @MainActor
    func testThumbTintColor() {
        let `switch`: UISwitch = .init()
        expect(`switch`.thumbTintColor) == nil
        `switch`.bindable.thumbTintColor.receiveValue(.systemPink)
        expect(`switch`.thumbTintColor) == .systemPink
    }

    @MainActor
    func testIsOn() {
        let `switch`: UISwitch = .init()
        expect(`switch`.isOn) == false
        `switch`.bindable.isOn.receiveValue(true)
        expect(`switch`.isOn) == true
    }

    @MainActor
    func testIsOnAnimated() {
        let `switch`: UISwitch = .init()
        expect(`switch`.isOn) == false
        `switch`.bindable.isOn(animated: true).receiveValue(true)
        expect(`switch`.isOn) == true
    }
}
