//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UIButtonTests: XCTestCase {

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
}
