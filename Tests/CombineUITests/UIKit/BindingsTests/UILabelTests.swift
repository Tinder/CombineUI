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

    func testText() {
        let label: UILabel = .init()
        expect(label.text) == nil
        label.bindable.text.receiveValue("Text")
        expect(label.text) == "Text"
    }

    @available(iOS 15, *)
    func testAttributedText() {
        let label: UILabel = .init()
        expect(label.attributedText) == nil
        label.bindable.attributedText.receiveValue(NSAttributedString("Attributed Text"))
        expect(label.attributedText?.string) == "Attributed Text"
    }
}
