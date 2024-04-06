//
//  Copyright © 2024 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UIActivityIndicatorViewTests: XCTestCase {

    @MainActor
    func testStyle() {
        let activityIndicatorView: UIActivityIndicatorView = .init()
        expect(activityIndicatorView.style) == .medium
        activityIndicatorView.bindable.style.receiveValue(.large)
        expect(activityIndicatorView.style) == .large
    }

    @MainActor
    func testColor() {
        let activityIndicatorView: UIActivityIndicatorView = .init()
        activityIndicatorView.color = .systemMint
        expect(activityIndicatorView.color) == .systemMint
        activityIndicatorView.bindable.color.receiveValue(.systemPink)
        expect(activityIndicatorView.color) == .systemPink
    }

    @MainActor
    func testHidesWhenStopped() {
        let activityIndicatorView: UIActivityIndicatorView = .init()
        expect(activityIndicatorView.hidesWhenStopped) == true
        activityIndicatorView.bindable.hidesWhenStopped.receiveValue(false)
        expect(activityIndicatorView.hidesWhenStopped) == false
    }

    @MainActor
    func testIsAnimating() {
        let activityIndicatorView: UIActivityIndicatorView = .init()
        expect(activityIndicatorView.isAnimating) == false
        activityIndicatorView.bindable.isAnimating.receiveValue(true)
        expect(activityIndicatorView.isAnimating) == true
        activityIndicatorView.bindable.isAnimating.receiveValue(false)
        expect(activityIndicatorView.isAnimating) == false
    }
}
