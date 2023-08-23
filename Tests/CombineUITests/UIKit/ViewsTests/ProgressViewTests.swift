//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import Nimble
import XCTest

final class ProgressViewTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @ProgressView var progressView: UIProgressView = .init()
    }

    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = Set()
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    func testProgressView() {
        let viewController: TestViewController = .init()
        let progressView: UIProgressView = viewController.progressView
        var receivedValues: [Float] = []
        viewController
            .$progressView
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(receivedValues) == [0]
        progressView.progress = 0.5
        expect(receivedValues) == [0, 0.5]
        progressView.progress = 1
        expect(receivedValues) == [0, 0.5, 1]
    }
}
