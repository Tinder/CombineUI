//
//  Copyright © 2023 Tinder (Match Group, LLC)
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
