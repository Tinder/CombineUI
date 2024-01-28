//
//  Copyright © 2024 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

@MainActor
final class UIImageViewTests: XCTestCase {

    func testImage() {
        let imageView: UIImageView = .init()
        expect(imageView.image) == nil
        imageView.bindable.image.receiveValue(.checkmark)
        expect(imageView.image) == .checkmark
    }

    func testHighlightedImage() {
        let imageView: UIImageView = .init()
        expect(imageView.highlightedImage) == nil
        imageView.bindable.highlightedImage.receiveValue(.checkmark)
        expect(imageView.highlightedImage) == .checkmark
    }

    func testIsHighlighted() {
        let imageView: UIImageView = .init()
        expect(imageView.isHighlighted) == false
        imageView.bindable.isHighlighted.receiveValue(true)
        expect(imageView.isHighlighted) == true
    }
}
