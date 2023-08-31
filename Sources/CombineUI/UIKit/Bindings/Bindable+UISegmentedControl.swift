//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UISegmentedControl {

    @preconcurrency @MainActor public var selectedSegmentIndex: Binding<Int> {
        Binding(self, for: \.selectedSegmentIndex)
    }

    @preconcurrency
    @MainActor
    public func isEnabledForSegment(at index: Int) -> Binding<Bool> {
        Binding(self) { $0.setEnabled($1, forSegmentAt: index) }
    }
}
