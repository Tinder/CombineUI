//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UIProgressViewTests: XCTestCase {

    func testProgress() {
        let progressView: UIProgressView = .init()
        expect(progressView.progress) == 0
        progressView.bindable.progress.receiveValue(1)
        expect(progressView.progress) == 1
    }

    func testProgressAnimated() {
        let progressView: UIProgressView = .init()
        expect(progressView.progress) == 0
        progressView.bindable.progress(animated: true).receiveValue(1)
        expect(progressView.progress) == 1
    }
}
