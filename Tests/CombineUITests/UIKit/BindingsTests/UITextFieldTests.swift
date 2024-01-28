//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

@MainActor
final class UITextFieldTests: XCTestCase {

    func testFont() {
        let textField: UITextField = .init()
        expect(textField.font) == .systemFont(ofSize: 17)
        textField.bindable.font.receiveValue(.systemFont(ofSize: 23))
        expect(textField.font) == .systemFont(ofSize: 23)
    }

    func testTextColor() {
        let textField: UITextField = .init()
        textField.textColor = .systemMint
        expect(textField.textColor) == .systemMint
        textField.bindable.textColor.receiveValue(.systemPink)
        expect(textField.textColor) == .systemPink
    }

    func testTextAlignment() {
        let textField: UITextField = .init()
        expect(textField.textAlignment) == .natural
        textField.bindable.textAlignment.receiveValue(.left)
        expect(textField.textAlignment) == .left
    }

    func testPlaceholder() {
        let textField: UITextField = .init()
        expect(textField.placeholder) == nil
        textField.bindable.placeholder.receiveValue("Text")
        expect(textField.placeholder) == "Text"
    }

    func testAttributedPlaceholder() {
        let textField: UITextField = .init()
        expect(textField.attributedPlaceholder?.string) == nil
        textField.bindable.attributedPlaceholder.receiveValue(AttributedString("Attributed Text"))
        expect(textField.attributedPlaceholder?.string) == "Attributed Text"
    }

    func testText() {
        let textField: UITextField = .init()
        expect(textField.text?.isEmpty) == true
        textField.bindable.text.receiveValue("Text")
        expect(textField.text) == "Text"
    }

    func testAttributedText() {
        let textField: UITextField = .init()
        expect(textField.attributedText?.string.isEmpty) == true
        textField.bindable.attributedText.receiveValue(AttributedString("Attributed Text"))
        expect(textField.attributedText?.string) == "Attributed Text"
    }
}
