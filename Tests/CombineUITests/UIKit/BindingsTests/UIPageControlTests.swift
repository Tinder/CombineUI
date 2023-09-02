//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UIPageControlTests: XCTestCase {

    func testPageControl() {
        let pageControl: UIPageControl = .init()
        pageControl.numberOfPages = 2
        expect(pageControl.currentPage) == 0
        pageControl.bindable.currentPage.receiveValue(1)
        expect(pageControl.currentPage) == 1
    }
}
