//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UISegmentedControl {

    @preconcurrency
    @MainActor
    public var isMomentary: Binding<Bool> {
        Binding(self, for: \.isMomentary)
    }

    @preconcurrency
    @MainActor
    public var selectedSegmentIndex: Binding<Int> {
        Binding(self, for: \.selectedSegmentIndex)
    }

    @preconcurrency
    @MainActor
    public func isEnabledForSegment(at index: Int) -> Binding<Bool> {
        Binding(self) { $0.setEnabled($1, forSegmentAt: index) }
    }

    @preconcurrency
    @MainActor
    public func widthForSegment(at index: Int) -> Binding<CGFloat> {
        Binding(self) { $0.setWidth($1, forSegmentAt: index) }
    }

    @preconcurrency
    @MainActor
    public func titleForSegment(at index: Int) -> Binding<String> {
        Binding(self) { $0.setTitle($1, forSegmentAt: index) }
    }

    @preconcurrency
    @MainActor
    public func imageForSegment(at index: Int) -> Binding<UIImage?> {
        Binding(self) { $0.setImage($1, forSegmentAt: index) }
    }
}
