//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import Nimble
import XCTest

final class ViewControllerTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @ViewController var viewController: UIViewController = .init()
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

    @MainActor
    func testLifecyclePublisher() {
        let testViewController: TestViewController = .init()
        let viewController: UIViewController = testViewController.viewController
        var receivedValues: [ViewControllerLifecycleEvent] = []
        viewController
            .lifecyclePublisher()
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(viewController.children.count) == 1
        expect(receivedValues.isEmpty) == true
        viewController.children.first?.viewWillAppear(false)
        viewController.children.first?.viewDidAppear(false)
        viewController.children.first?.viewWillDisappear(false)
        viewController.children.first?.viewDidDisappear(false)
        expect(receivedValues) == [
            .viewWillAppear,
            .viewDidAppear,
            .viewWillDisappear,
            .viewDidDisappear
        ]
        cancellables.removeAll()
        viewController.children.first?.viewWillAppear(false)
        viewController.children.first?.viewDidAppear(false)
        viewController.children.first?.viewWillDisappear(false)
        viewController.children.first?.viewDidDisappear(false)
        expect(receivedValues) == [
            .viewWillAppear,
            .viewDidAppear,
            .viewWillDisappear,
            .viewDidDisappear
        ]
    }

    @MainActor
    func testIsVisiblePublisher() {
        let testViewController: TestViewController = .init()
        let viewController: UIViewController = testViewController.viewController
        var receivedValues: [Bool] = []
        viewController
            .lifecyclePublisher()
            .isVisiblePublisher()
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(viewController.children.count) == 1
        expect(receivedValues.isEmpty) == true
        viewController.children.first?.viewWillAppear(false)
        expect(receivedValues) == [true]
        viewController.children.first?.viewDidAppear(false)
        expect(receivedValues) == [true]
        viewController.children.first?.viewWillDisappear(false)
        expect(receivedValues) == [true]
        viewController.children.first?.viewDidAppear(false)
        expect(receivedValues) == [true]
        viewController.children.first?.viewWillDisappear(false)
        expect(receivedValues) == [true]
        viewController.children.first?.viewDidDisappear(false)
        expect(receivedValues) == [true, false]
        viewController.children.first?.viewWillAppear(false)
        expect(receivedValues) == [true, false, true]
        viewController.children.first?.viewDidDisappear(false)
        expect(receivedValues) == [true, false, true, false]
        viewController.children.first?.viewWillAppear(false)
        expect(receivedValues) == [true, false, true, false, true]
        viewController.children.first?.viewDidAppear(false)
        expect(receivedValues) == [true, false, true, false, true]
    }

    @MainActor
    func testIsVisible() {
        let testViewController: TestViewController = .init()
        let viewController: UIViewController = testViewController.viewController
        var receivedValues: [Bool] = []
        testViewController
            .$viewController
            .isVisible
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(viewController.children.count) == 1
        expect(receivedValues.isEmpty) == true
        viewController.children.first?.viewWillAppear(false)
        expect(receivedValues) == [true]
        viewController.children.first?.viewDidAppear(false)
        expect(receivedValues) == [true]
        viewController.children.first?.viewWillDisappear(false)
        expect(receivedValues) == [true]
        viewController.children.first?.viewDidAppear(false)
        expect(receivedValues) == [true]
        viewController.children.first?.viewWillDisappear(false)
        expect(receivedValues) == [true]
        viewController.children.first?.viewDidDisappear(false)
        expect(receivedValues) == [true, false]
        viewController.children.first?.viewWillAppear(false)
        expect(receivedValues) == [true, false, true]
        viewController.children.first?.viewDidDisappear(false)
        expect(receivedValues) == [true, false, true, false]
        viewController.children.first?.viewWillAppear(false)
        expect(receivedValues) == [true, false, true, false, true]
        viewController.children.first?.viewDidAppear(false)
        expect(receivedValues) == [true, false, true, false, true]
    }

    @MainActor
    func testViewWillAppear() {
        let testViewController: TestViewController = .init()
        let viewController: UIViewController = testViewController.viewController
        var count: Int = 0
        testViewController
            .$viewController
            .viewWillAppear
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(viewController.children.count) == 1
        expect(count) == 0
        viewController.children.first?.viewWillAppear(false)
        expect(count) == 1
        viewController.children.first?.viewWillAppear(false)
        expect(count) == 2
    }

    @MainActor
    func testViewDidAppear() {
        let testViewController: TestViewController = .init()
        let viewController: UIViewController = testViewController.viewController
        var count: Int = 0
        testViewController
            .$viewController
            .viewDidAppear
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(viewController.children.count) == 1
        expect(count) == 0
        viewController.children.first?.viewDidAppear(false)
        expect(count) == 1
        viewController.children.first?.viewDidAppear(false)
        expect(count) == 2
    }

    @MainActor
    func testViewWillDisappear() {
        let testViewController: TestViewController = .init()
        let viewController: UIViewController = testViewController.viewController
        var count: Int = 0
        testViewController
            .$viewController
            .viewWillDisappear
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(viewController.children.count) == 1
        expect(count) == 0
        viewController.children.first?.viewWillDisappear(false)
        expect(count) == 1
        viewController.children.first?.viewWillDisappear(false)
        expect(count) == 2
    }

    @MainActor
    func testViewDidDisappear() {
        let testViewController: TestViewController = .init()
        let viewController: UIViewController = testViewController.viewController
        var count: Int = 0
        testViewController
            .$viewController
            .viewDidDisappear
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(viewController.children.count) == 1
        expect(count) == 0
        viewController.children.first?.viewDidDisappear(false)
        expect(count) == 1
        viewController.children.first?.viewDidDisappear(false)
        expect(count) == 2
    }
}
