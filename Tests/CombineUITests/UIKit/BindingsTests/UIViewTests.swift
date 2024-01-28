//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

@MainActor
final class UIViewTests: XCTestCase {

    func testIsUserInteractionEnabled() {
        let view: UIView = .init()
        expect(view.isUserInteractionEnabled) == true
        view.bindable.isUserInteractionEnabled.receiveValue(false)
        expect(view.isUserInteractionEnabled) == false
    }

    func testIsMultipleTouchEnabled() {
        let view: UIView = .init()
        expect(view.isMultipleTouchEnabled) == false
        view.bindable.isMultipleTouchEnabled.receiveValue(true)
        expect(view.isMultipleTouchEnabled) == true
    }

    func testIsExclusiveTouch() {
        let view: UIView = .init()
        expect(view.isExclusiveTouch) == false
        view.bindable.isExclusiveTouch.receiveValue(true)
        expect(view.isExclusiveTouch) == true
    }

    func testClipsToBounds() {
        let view: UIView = .init()
        expect(view.clipsToBounds) == false
        view.bindable.clipsToBounds.receiveValue(true)
        expect(view.clipsToBounds) == true
    }

    func testTintColor() {
        let view: UIView = .init()
        view.tintColor = .systemMint
        expect(view.tintColor) == .systemMint
        view.bindable.tintColor.receiveValue(.systemPink)
        expect(view.tintColor) == .systemPink
    }

    func testBackgroundColor() {
        let view: UIView = .init()
        view.backgroundColor = .systemMint
        expect(view.backgroundColor) == .systemMint
        view.bindable.backgroundColor.receiveValue(.systemPink)
        expect(view.backgroundColor) == .systemPink
    }

    func testBorderColor() {
        let view: UIView = .init()
        view.layer.borderColor = UIColor.systemMint.cgColor
        expect(view.layer.borderColor) == UIColor.systemMint.cgColor
        view.bindable.borderColor.receiveValue(.systemPink)
        expect(view.layer.borderColor) == UIColor.systemPink.cgColor
    }

    func testShadowColor() {
        let view: UIView = .init()
        view.layer.shadowColor = UIColor.systemMint.cgColor
        expect(view.layer.shadowColor) == UIColor.systemMint.cgColor
        view.bindable.shadowColor.receiveValue(.systemPink)
        expect(view.layer.shadowColor) == UIColor.systemPink.cgColor
    }

    func testAlpha() {
        let view: UIView = .init()
        expect(view.alpha) == 1
        view.bindable.alpha.receiveValue(0.5)
        expect(view.alpha) == 0.5
    }

    func testIsOpaque() {
        let view: UIView = .init()
        expect(view.isOpaque) == true
        view.bindable.isOpaque.receiveValue(false)
        expect(view.isOpaque) == false
    }

    func testIsHidden() {
        let view: UIView = .init()
        expect(view.isHidden) == false
        view.bindable.isHidden.receiveValue(true)
        expect(view.isHidden) == true
    }
}
