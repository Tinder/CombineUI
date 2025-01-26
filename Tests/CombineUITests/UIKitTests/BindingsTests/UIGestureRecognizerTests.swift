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

final class UIGestureRecognizerTests: XCTestCase {

    @MainActor
    func testGestureRecognizer() {
        let gestureRecognizer: UIGestureRecognizer = .init()
        expect(gestureRecognizer.isEnabled) == true
        gestureRecognizer.bindable.isEnabled.receiveValue(false)
        expect(gestureRecognizer.isEnabled) == false
    }
}
