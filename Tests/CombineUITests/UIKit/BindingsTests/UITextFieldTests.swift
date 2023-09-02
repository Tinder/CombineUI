//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UITextFieldTests: XCTestCase {

    func testText() {
        let textField: UITextField = .init()
        expect(textField.text?.isEmpty) == true
        textField.bindable.text.receiveValue("Text")
        expect(textField.text) == "Text"
    }

    @available(iOS 15, *)
    func testAttributedText() {
        let textField: UITextField = .init()
        expect(textField.attributedText?.string.isEmpty) == true
        textField.bindable.attributedText.receiveValue(NSAttributedString("Attributed Text"))
        expect(textField.attributedText?.string) == "Attributed Text"
    }
}
