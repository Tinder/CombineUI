//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UISegmentedControlTests: XCTestCase {

    func testSelectedSegmentIndex() {
        let segmentedControl: UISegmentedControl = .init(items: ["item"])
        expect(segmentedControl.selectedSegmentIndex) == -1
        segmentedControl.bindable.selectedSegmentIndex.receiveValue(0)
        expect(segmentedControl.selectedSegmentIndex) == 0
    }

    func testIsEnabledForSegmentAtIndex() {
        let segmentedControl: UISegmentedControl = .init(items: ["item"])
        expect(segmentedControl.isEnabledForSegment(at: 0)) == true
        segmentedControl.bindable.isEnabledForSegment(at: 0).receiveValue(false)
        expect(segmentedControl.isEnabledForSegment(at: 0)) == false
    }
}
