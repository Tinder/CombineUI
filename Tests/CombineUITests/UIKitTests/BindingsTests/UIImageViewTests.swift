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

final class UIImageViewTests: XCTestCase {

    @MainActor
    func testImage() {
        let imageView: UIImageView = .init()
        expect(imageView.image) == nil
        imageView.bindable.image.receiveValue(.checkmark)
        expect(imageView.image) == .checkmark
    }

    @MainActor
    func testHighlightedImage() {
        let imageView: UIImageView = .init()
        expect(imageView.highlightedImage) == nil
        imageView.bindable.highlightedImage.receiveValue(.checkmark)
        expect(imageView.highlightedImage) == .checkmark
    }

    @MainActor
    func testIsHighlighted() {
        let imageView: UIImageView = .init()
        expect(imageView.isHighlighted) == false
        imageView.bindable.isHighlighted.receiveValue(true)
        expect(imageView.isHighlighted) == true
    }
}
