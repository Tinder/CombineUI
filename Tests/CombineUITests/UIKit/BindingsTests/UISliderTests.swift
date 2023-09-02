//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UISliderTests: XCTestCase {

    func testValue() {
        let slider: UISlider = .init()
        expect(slider.value) == 0
        slider.bindable.value.receiveValue(1)
        expect(slider.value) == 1
    }

    func testValueAnimated() {
        let slider: UISlider = .init()
        expect(slider.value) == 0
        slider.bindable.value(animated: true).receiveValue(1)
        expect(slider.value) == 1
    }
}
