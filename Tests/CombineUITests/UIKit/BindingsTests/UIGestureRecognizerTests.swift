//
//  Copyright © 2023 Tinder (Match Group, LLC)
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
