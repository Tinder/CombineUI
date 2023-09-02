//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UIViewTests: XCTestCase {

    func testAlpha() {
        let view: UIView = .init()
        expect(view.alpha) == 1
        view.bindable.alpha.receiveValue(0.5)
        expect(view.alpha) == 0.5
    }

    func testIsHidden() {
        let view: UIView = .init()
        expect(view.isHidden) == false
        view.bindable.isHidden.receiveValue(true)
        expect(view.isHidden) == true
    }
}
