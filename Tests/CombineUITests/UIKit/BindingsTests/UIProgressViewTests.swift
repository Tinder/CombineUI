//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UIProgressViewTests: XCTestCase {

    @MainActor
    func testTrackTintColor() {
        let progressView: UIProgressView = .init()
        progressView.trackTintColor = .systemMint
        expect(progressView.trackTintColor) == .systemMint
        progressView.bindable.trackTintColor.receiveValue(.systemPink)
        expect(progressView.trackTintColor) == .systemPink
    }

    @MainActor
    func testProgressTintColor() {
        let progressView: UIProgressView = .init()
        progressView.progressTintColor = .systemMint
        expect(progressView.progressTintColor) == .systemMint
        progressView.bindable.progressTintColor.receiveValue(.systemPink)
        expect(progressView.progressTintColor) == .systemPink
    }

    @MainActor
    func testProgress() {
        let progressView: UIProgressView = .init()
        expect(progressView.progress) == 0
        progressView.bindable.progress.receiveValue(1)
        expect(progressView.progress) == 1
    }

    @MainActor
    func testProgressAnimated() {
        let progressView: UIProgressView = .init()
        expect(progressView.progress) == 0
        progressView.bindable.progress(animated: true).receiveValue(1)
        expect(progressView.progress) == 1
    }
}
