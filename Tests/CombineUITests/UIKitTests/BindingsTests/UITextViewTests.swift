//
//  Copyright © 2024 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UITextViewTests: XCTestCase {

    @MainActor
    func testIsEditable() {
        let textView: UITextView = .init()
        expect(textView.isEditable) == true
        textView.bindable.isEditable.receiveValue(false)
        expect(textView.isEditable) == false
    }

    @MainActor
    func testFont() {
        let textView: UITextView = .init()
        expect(textView.font) == nil
        textView.bindable.font.receiveValue(.systemFont(ofSize: 23))
        expect(textView.font) == .systemFont(ofSize: 23)
    }

    @MainActor
    func testTextColor() {
        let textView: UITextView = .init()
        textView.textColor = .systemMint
        expect(textView.textColor) == .systemMint
        textView.bindable.textColor.receiveValue(.systemPink)
        expect(textView.textColor) == .systemPink
    }

    @MainActor
    func testTextAlignment() {
        let textView: UITextView = .init()
        expect(textView.textAlignment) == .natural
        textView.bindable.textAlignment.receiveValue(.left)
        expect(textView.textAlignment) == .left
    }

    @MainActor
    func testText() {
        let textView: UITextView = .init()
        expect(textView.text?.isEmpty) == true
        textView.bindable.text.receiveValue("Text")
        expect(textView.text) == "Text"
    }

    @MainActor
    func testAttributedText() {
        let textView: UITextView = .init()
        expect(textView.attributedText?.string.isEmpty) == true
        textView.bindable.attributedText.receiveValue(AttributedString("Attributed Text"))
        expect(textView.attributedText?.string) == "Attributed Text"
    }
}
