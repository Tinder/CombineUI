//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UIPageControlTests: XCTestCase {

    @MainActor
    func testPageIndicatorTintColor() {
        let pageControl: UIPageControl = .init()
        pageControl.pageIndicatorTintColor = .systemMint
        expect(pageControl.pageIndicatorTintColor) == .systemMint
        pageControl.bindable.pageIndicatorTintColor.receiveValue(.systemPink)
        expect(pageControl.pageIndicatorTintColor) == .systemPink
    }

    @MainActor
    func testCurrentPageIndicatorTintColor() {
        let pageControl: UIPageControl = .init()
        pageControl.currentPageIndicatorTintColor = .systemMint
        expect(pageControl.currentPageIndicatorTintColor) == .systemMint
        pageControl.bindable.currentPageIndicatorTintColor.receiveValue(.systemPink)
        expect(pageControl.currentPageIndicatorTintColor) == .systemPink
    }

    @MainActor
    func testCurrentPage() {
        let pageControl: UIPageControl = .init()
        pageControl.numberOfPages = 2
        expect(pageControl.currentPage) == 0
        pageControl.bindable.currentPage.receiveValue(1)
        expect(pageControl.currentPage) == 1
    }

    @MainActor
    func testNumberOfPages() {
        let pageControl: UIPageControl = .init()
        expect(pageControl.numberOfPages) == 0
        pageControl.bindable.numberOfPages.receiveValue(2)
        expect(pageControl.numberOfPages) == 2
    }

    @MainActor
    func testHidesForSinglePage() {
        let pageControl: UIPageControl = .init()
        expect(pageControl.hidesForSinglePage) == false
        pageControl.bindable.hidesForSinglePage.receiveValue(true)
        expect(pageControl.hidesForSinglePage) == true
    }
}
