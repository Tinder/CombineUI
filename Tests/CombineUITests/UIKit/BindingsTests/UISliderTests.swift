//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UISliderTests: XCTestCase {

    func testIsContinuous() {
        let slider: UISlider = .init()
        expect(slider.isContinuous) == true
        slider.bindable.isContinuous.receiveValue(false)
        expect(slider.isContinuous) == false
    }

    func testMinimumValue() {
        let slider: UISlider = .init()
        expect(slider.minimumValue) == 0
        slider.bindable.minimumValue.receiveValue(1)
        expect(slider.minimumValue) == 1
    }

    func testMaximumValue() {
        let slider: UISlider = .init()
        expect(slider.maximumValue) == 1
        slider.bindable.maximumValue.receiveValue(10)
        expect(slider.maximumValue) == 10
    }

    func testMinimumTrackTintColor() {
        let slider: UISlider = .init()
        expect(slider.minimumTrackTintColor) == nil
        slider.bindable.minimumTrackTintColor.receiveValue(.systemPink)
        expect(slider.minimumTrackTintColor) == .systemPink
    }

    func testMaximumTrackTintColor() {
        let slider: UISlider = .init()
        expect(slider.maximumTrackTintColor) == nil
        slider.bindable.maximumTrackTintColor.receiveValue(.systemPink)
        expect(slider.maximumTrackTintColor) == .systemPink
    }

    func testThumbTintColor() {
        let slider: UISlider = .init()
        expect(slider.thumbTintColor) == nil
        slider.bindable.thumbTintColor.receiveValue(.systemPink)
        expect(slider.thumbTintColor) == .systemPink
    }

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
