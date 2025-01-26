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

final class UIControlTests: XCTestCase {

    @MainActor
    func testControl() {
        let control: UIControl = .init()
        expect(control.isEnabled) == true
        control.bindable.isEnabled.receiveValue(false)
        expect(control.isEnabled) == false
    }
}
