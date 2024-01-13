//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI
import Nimble
import XCTest

final class UISegmentedControlTests: XCTestCase {

    func testIsMomentary() {
        let segmentedControl: UISegmentedControl = .init(items: ["item"])
        expect(segmentedControl.isMomentary) == false
        segmentedControl.bindable.isMomentary.receiveValue(true)
        expect(segmentedControl.isMomentary) == true
    }

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

    func testWidthForSegmentAtIndex() {
        let segmentedControl: UISegmentedControl = .init(items: ["item"])
        expect(segmentedControl.widthForSegment(at: 0)) == 0
        segmentedControl.bindable.widthForSegment(at: 0).receiveValue(10)
        expect(segmentedControl.widthForSegment(at: 0)) == 10
    }

    func testTitleForSegmentAtIndex() {
        let segmentedControl: UISegmentedControl = .init(items: ["item"])
        expect(segmentedControl.titleForSegment(at: 0)) == "item"
        segmentedControl.bindable.titleForSegment(at: 0).receiveValue("Title")
        expect(segmentedControl.titleForSegment(at: 0)) == "Title"
    }

    func testImageForSegmentAtIndex() {
        let segmentedControl: UISegmentedControl = .init(items: ["item"])
        expect(segmentedControl.imageForSegment(at: 0)) == nil
        segmentedControl.bindable.imageForSegment(at: 0).receiveValue(.checkmark)
        expect(segmentedControl.imageForSegment(at: 0)) == .checkmark
    }
}
