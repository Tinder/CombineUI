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

final class UITextFieldTests: XCTestCase {

    @MainActor
    func testFont() {
        let textField: UITextField = .init()
        expect(textField.font) == .systemFont(ofSize: 17)
        textField.bindable.font.receiveValue(.systemFont(ofSize: 23))
        expect(textField.font) == .systemFont(ofSize: 23)
    }

    @MainActor
    func testTextColor() {
        let textField: UITextField = .init()
        textField.textColor = .systemMint
        expect(textField.textColor) == .systemMint
        textField.bindable.textColor.receiveValue(.systemPink)
        expect(textField.textColor) == .systemPink
    }

    @MainActor
    func testTextAlignment() {
        let textField: UITextField = .init()
        expect(textField.textAlignment) == .natural
        textField.bindable.textAlignment.receiveValue(.left)
        expect(textField.textAlignment) == .left
    }

    @MainActor
    func testPlaceholder() {
        let textField: UITextField = .init()
        expect(textField.placeholder) == nil
        textField.bindable.placeholder.receiveValue("Text")
        expect(textField.placeholder) == "Text"
    }

    @MainActor
    func testAttributedPlaceholder() {
        let textField: UITextField = .init()
        expect(textField.attributedPlaceholder?.string) == nil
        textField.bindable.attributedPlaceholder.receiveValue(AttributedString("Attributed Text"))
        expect(textField.attributedPlaceholder?.string) == "Attributed Text"
    }

    @MainActor
    func testText() {
        let textField: UITextField = .init()
        expect(textField.text?.isEmpty) == true
        textField.bindable.text.receiveValue("Text")
        expect(textField.text) == "Text"
    }

    @MainActor
    func testAttributedText() {
        let textField: UITextField = .init()
        expect(textField.attributedText?.string.isEmpty) == true
        textField.bindable.attributedText.receiveValue(AttributedString("Attributed Text"))
        expect(textField.attributedText?.string) == "Attributed Text"
    }
}
