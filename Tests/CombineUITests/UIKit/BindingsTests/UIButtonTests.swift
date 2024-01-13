//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UIButtonTests: XCTestCase {

    func testTitleColor() {
        let button: UIButton = .init()
        button.setTitleColor(.systemMint, for: .normal)
        expect(button.titleColor(for: .normal)) == .systemMint
        button.bindable.titleColor(for: .normal).receiveValue(.systemPink)
        expect(button.titleColor(for: .normal)) == .systemPink
    }

    func testTitleShadowColor() {
        let button: UIButton = .init()
        button.setTitleShadowColor(.systemMint, for: .normal)
        expect(button.titleShadowColor(for: .normal)) == .systemMint
        button.bindable.titleShadowColor(for: .normal).receiveValue(.systemPink)
        expect(button.titleShadowColor(for: .normal)) == .systemPink
    }

    func testTitle() {
        let button: UIButton = .init()
        expect(button.title(for: .normal)) == nil
        button.bindable.title(for: .normal).receiveValue("Title")
        expect(button.title(for: .normal)) == "Title"
    }

    func testAttributedTitle() {
        let button: UIButton = .init()
        expect(button.attributedTitle(for: .normal)?.string) == nil
        button.bindable.attributedTitle(for: .normal).receiveValue(AttributedString("Attributed Title"))
        expect(button.attributedTitle(for: .normal)?.string) == "Attributed Title"
    }

    func testImage() {
        let button: UIButton = .init()
        expect(button.image(for: .normal)) == nil
        button.bindable.image(for: .normal).receiveValue(.checkmark)
        expect(button.image(for: .normal)) == .checkmark
    }

    func testBackgroundImage() {
        let button: UIButton = .init()
        expect(button.backgroundImage(for: .normal)) == nil
        button.bindable.backgroundImage(for: .normal).receiveValue(.checkmark)
        expect(button.backgroundImage(for: .normal)) == .checkmark
    }
}
