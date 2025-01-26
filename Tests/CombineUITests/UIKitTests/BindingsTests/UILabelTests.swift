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

final class UILabelTests: XCTestCase {

    @MainActor
    func testIsEnabled() {
        let label: UILabel = .init()
        expect(label.isEnabled) == true
        label.bindable.isEnabled.receiveValue(false)
        expect(label.isEnabled) == false
    }

    @MainActor
    func testFont() {
        let label: UILabel = .init()
        expect(label.font) == .systemFont(ofSize: 17)
        label.bindable.font.receiveValue(.systemFont(ofSize: 23))
        expect(label.font) == .systemFont(ofSize: 23)
    }

    @MainActor
    func testTextColor() {
        let label: UILabel = .init()
        label.textColor = .systemMint
        expect(label.textColor) == .systemMint
        label.bindable.textColor.receiveValue(.systemPink)
        expect(label.textColor) == .systemPink
    }

    @MainActor
    func testText() {
        let label: UILabel = .init()
        expect(label.text) == nil
        label.bindable.text.receiveValue("Text")
        expect(label.text) == "Text"
    }

    @MainActor
    func testAttributedText() {
        let label: UILabel = .init()
        expect(label.attributedText) == nil
        label.bindable.attributedText.receiveValue(AttributedString("Attributed Text"))
        expect(label.attributedText?.string) == "Attributed Text"
    }
}
