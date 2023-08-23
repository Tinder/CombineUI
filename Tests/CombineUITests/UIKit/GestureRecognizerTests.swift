//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import Nimble
import XCTest

final class GestureRecognizerTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @GestureRecognizer var gestureRecognizer: TestGestureRecognizer = .init()
    }

    private final class TestGestureRecognizer: UIGestureRecognizer {

        private(set) var targets: [ObjectIdentifier: GestureRecognizerTarget] = [:]

        func invoke() {
            targets.values.forEach { $0.action() }
        }

        override func addTarget(_ target: Any, action: Selector) {
            if let target: GestureRecognizerTarget = target as? GestureRecognizerTarget {
                targets[ObjectIdentifier(target)] = target
            }
            super.addTarget(target, action: action)
        }
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

    func testGestureRecognizer() {
        let viewController: TestViewController = .init()
        let gestureRecognizer: TestGestureRecognizer = viewController.gestureRecognizer
        var receivedValues: [TestGestureRecognizer] = []
        viewController
            .$gestureRecognizer
            .attaching(to: viewController.view)
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(gestureRecognizer.targets.count) == 1
        expect(receivedValues.isEmpty) == true
        gestureRecognizer.invoke()
        expect(receivedValues) == [gestureRecognizer]
        gestureRecognizer.invoke()
        expect(receivedValues) == [gestureRecognizer, gestureRecognizer]
        cancellables.removeAll()
        gestureRecognizer.invoke()
        expect(receivedValues) == [gestureRecognizer, gestureRecognizer]
    }
}
