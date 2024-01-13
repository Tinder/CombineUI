//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UILabelTests: XCTestCase {

    func testIsEnabled() {
        let label: UILabel = .init()
        expect(label.isEnabled) == true
        label.bindable.isEnabled.receiveValue(false)
        expect(label.isEnabled) == false
    }

    func testFont() {
        let label: UILabel = .init()
        expect(label.font) == .systemFont(ofSize: 17)
        label.bindable.font.receiveValue(.systemFont(ofSize: 23))
        expect(label.font) == .systemFont(ofSize: 23)
    }

    func testTextColor() {
        let label: UILabel = .init()
        label.textColor = .systemMint
        expect(label.textColor) == .systemMint
        label.bindable.textColor.receiveValue(.systemPink)
        expect(label.textColor) == .systemPink
    }

    func testText() {
        let label: UILabel = .init()
        expect(label.text) == nil
        label.bindable.text.receiveValue("Text")
        expect(label.text) == "Text"
    }

    func testAttributedText() {
        let label: UILabel = .init()
        expect(label.attributedText) == nil
        label.bindable.attributedText.receiveValue(AttributedString("Attributed Text"))
        expect(label.attributedText?.string) == "Attributed Text"
    }
}
