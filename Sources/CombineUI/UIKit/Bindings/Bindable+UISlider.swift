//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UISlider {

    @preconcurrency @MainActor public var value: Binding<Float> {
        Binding(self, for: \.value)
    }

    @preconcurrency
    @MainActor
    public func value(animated: Bool) -> Binding<Float> {
        Binding(self) { $0.setValue($1, animated: animated) }
    }
}
