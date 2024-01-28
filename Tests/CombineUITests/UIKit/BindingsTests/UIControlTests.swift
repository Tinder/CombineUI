//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

@MainActor
final class UIControlTests: XCTestCase {

    func testControl() {
        let control: UIControl = .init()
        expect(control.isEnabled) == true
        control.bindable.isEnabled.receiveValue(false)
        expect(control.isEnabled) == false
    }
}
