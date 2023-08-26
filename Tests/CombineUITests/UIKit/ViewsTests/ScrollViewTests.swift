//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import Nimble
import XCTest

@MainActor
final class ScrollViewTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @ScrollView var scrollView: UIScrollView = .init()
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

    func testDidScroll() {
        let viewController: TestViewController = .init()
        let scrollView: UIScrollView = viewController.scrollView
        var count: Int = 0
        viewController
            .$scrollView
            .didScroll
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        scrollView.delegate?.scrollViewDidScroll?(scrollView)
        expect(count) == 1
        scrollView.delegate?.scrollViewDidScroll?(scrollView)
        expect(count) == 2
    }

    func testDidZoom() {
        let viewController: TestViewController = .init()
        let scrollView: UIScrollView = viewController.scrollView
        var count: Int = 0
        viewController
            .$scrollView
            .didZoom
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        scrollView.delegate?.scrollViewDidZoom?(scrollView)
        expect(count) == 1
        scrollView.delegate?.scrollViewDidZoom?(scrollView)
        expect(count) == 2
    }

    func testWillBeginDragging() {
        let viewController: TestViewController = .init()
        let scrollView: UIScrollView = viewController.scrollView
        var count: Int = 0
        viewController
            .$scrollView
            .willBeginDragging
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        scrollView.delegate?.scrollViewWillBeginDragging?(scrollView)
        expect(count) == 1
        scrollView.delegate?.scrollViewWillBeginDragging?(scrollView)
        expect(count) == 2
    }

    func testWillEndDragging() {
        let viewController: TestViewController = .init()
        let scrollView: UIScrollView = viewController.scrollView
        var receivedValues: [ScrollViewWillEndDragging] = []
        viewController
            .$scrollView
            .willEndDragging
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(receivedValues.isEmpty) == true
        var point1: CGPoint = .init(x: 5, y: 17)
        withUnsafeMutablePointer(to: &point1) { targetContentOffset in
            scrollView.delegate?.scrollViewWillEndDragging?(scrollView,
                                                            withVelocity: CGPoint(x: 100, y: 23),
                                                            targetContentOffset: targetContentOffset)
        }
        expect(receivedValues) == [
            (CGPoint(x: 100, y: 23), CGPoint(x: 5, y: 17))
        ]
        var point2: CGPoint = .init(x: 7, y: 15)
        withUnsafeMutablePointer(to: &point2) { targetContentOffset in
            scrollView.delegate?.scrollViewWillEndDragging?(scrollView,
                                                            withVelocity: CGPoint(x: 23, y: 100),
                                                            targetContentOffset: targetContentOffset)
        }
        expect(receivedValues) == [
            (CGPoint(x: 100, y: 23), CGPoint(x: 5, y: 17)),
            (CGPoint(x: 23, y: 100), CGPoint(x: 7, y: 15))
        ]
    }

    func testDidEndDragging() {
        let viewController: TestViewController = .init()
        let scrollView: UIScrollView = viewController.scrollView
        var receivedValues: [Bool] = []
        viewController
            .$scrollView
            .didEndDragging
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(receivedValues.isEmpty) == true
        scrollView.delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: true)
        expect(receivedValues) == [true]
        scrollView.delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: false)
        expect(receivedValues) == [true, false]
    }

    func testWillBeginDecelerating() {
        let viewController: TestViewController = .init()
        let scrollView: UIScrollView = viewController.scrollView
        var count: Int = 0
        viewController
            .$scrollView
            .willBeginDecelerating
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        scrollView.delegate?.scrollViewWillBeginDecelerating?(scrollView)
        expect(count) == 1
        scrollView.delegate?.scrollViewWillBeginDecelerating?(scrollView)
        expect(count) == 2
    }

    func testDidEndDecelerating() {
        let viewController: TestViewController = .init()
        let scrollView: UIScrollView = viewController.scrollView
        var count: Int = 0
        viewController
            .$scrollView
            .didEndDecelerating
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        scrollView.delegate?.scrollViewDidEndDecelerating?(scrollView)
        expect(count) == 1
        scrollView.delegate?.scrollViewDidEndDecelerating?(scrollView)
        expect(count) == 2
    }

    func testDidEndScrollingAnimation() {
        let viewController: TestViewController = .init()
        let scrollView: UIScrollView = viewController.scrollView
        var count: Int = 0
        viewController
            .$scrollView
            .didEndScrollingAnimation
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        scrollView.delegate?.scrollViewDidEndScrollingAnimation?(scrollView)
        expect(count) == 1
        scrollView.delegate?.scrollViewDidEndScrollingAnimation?(scrollView)
        expect(count) == 2
    }

    func testWillBeginZooming() {
        let viewController: TestViewController = .init()
        let scrollView: UIScrollView = viewController.scrollView
        var receivedValues: [UIView?] = []
        viewController
            .$scrollView
            .willBeginZooming
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(receivedValues.isEmpty) == true
        let view: UIView = .init()
        scrollView.delegate?.scrollViewWillBeginZooming?(scrollView, with: view)
        expect(receivedValues) == [view]
        scrollView.delegate?.scrollViewWillBeginZooming?(scrollView, with: nil)
        expect(receivedValues) == [view, nil]
    }

    func testDidEndZooming() {
        let viewController: TestViewController = .init()
        let scrollView: UIScrollView = viewController.scrollView
        var receivedValues: [ScrollViewDidEndZooming] = []
        viewController
            .$scrollView
            .didEndZooming
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(receivedValues.isEmpty) == true
        let view: UIView = .init()
        scrollView.delegate?.scrollViewDidEndZooming?(scrollView, with: view, atScale: 100)
        expect(receivedValues) == [(view, CGFloat(100))]
        scrollView.delegate?.scrollViewDidEndZooming?(scrollView, with: nil, atScale: 23)
        expect(receivedValues) == [(view, CGFloat(100)), (nil, CGFloat(23))]
    }

    func testDidScrollToTop() {
        let viewController: TestViewController = .init()
        let scrollView: UIScrollView = viewController.scrollView
        var count: Int = 0
        viewController
            .$scrollView
            .didScrollToTop
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        scrollView.delegate?.scrollViewDidScrollToTop?(scrollView)
        expect(count) == 1
        scrollView.delegate?.scrollViewDidScrollToTop?(scrollView)
        expect(count) == 2
    }

    func testDidChangeAdjustedContentInset() {
        let viewController: TestViewController = .init()
        let scrollView: UIScrollView = viewController.scrollView
        var count: Int = 0
        viewController
            .$scrollView
            .didChangeAdjustedContentInset
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        scrollView.delegate?.scrollViewDidChangeAdjustedContentInset?(scrollView)
        expect(count) == 1
        scrollView.delegate?.scrollViewDidChangeAdjustedContentInset?(scrollView)
        expect(count) == 2
    }
}
