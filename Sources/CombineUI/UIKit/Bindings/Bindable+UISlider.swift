//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import UIKit

extension Bindable where Target: UISlider {

    @preconcurrency
    @MainActor
    public var isContinuous: Binding<Bool> {
        Binding(self, for: \.isContinuous)
    }

    @preconcurrency
    @MainActor
    public var minimumValue: Binding<Float> {
        Binding(self, for: \.minimumValue)
    }

    @preconcurrency
    @MainActor
    public var maximumValue: Binding<Float> {
        Binding(self, for: \.maximumValue)
    }

    @preconcurrency
    @MainActor
    public var minimumTrackTintColor: Binding<UIColor> {
        Binding(self, for: \.minimumTrackTintColor)
    }

    @preconcurrency
    @MainActor
    public var maximumTrackTintColor: Binding<UIColor> {
        Binding(self, for: \.maximumTrackTintColor)
    }

    @preconcurrency
    @MainActor
    public var thumbTintColor: Binding<UIColor> {
        Binding(self, for: \.thumbTintColor)
    }

    @preconcurrency
    @MainActor
    public var value: Binding<Float> {
        Binding(self, for: \.value)
    }

    @preconcurrency
    @MainActor
    public func value(animated: Bool) -> Binding<Float> {
        Binding(self) { $0.setValue($1, animated: animated) }
    }
}
