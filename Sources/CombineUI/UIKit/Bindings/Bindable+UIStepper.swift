//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import UIKit

extension Bindable where Target: UIStepper {

    @preconcurrency
    @MainActor
    public var isContinuous: Binding<Bool> {
        Binding(self, for: \.isContinuous)
    }

    @preconcurrency
    @MainActor
    public var autorepeat: Binding<Bool> {
        Binding(self, for: \.autorepeat)
    }

    @preconcurrency
    @MainActor
    public var wraps: Binding<Bool> {
        Binding(self, for: \.wraps)
    }

    @preconcurrency
    @MainActor
    public var minimumValue: Binding<Double> {
        Binding(self, for: \.minimumValue)
    }

    @preconcurrency
    @MainActor
    public var maximumValue: Binding<Double> {
        Binding(self, for: \.maximumValue)
    }

    @preconcurrency
    @MainActor
    public var stepValue: Binding<Double> {
        Binding(self, for: \.stepValue)
    }

    @preconcurrency
    @MainActor
    public var value: Binding<Double> {
        Binding(self, for: \.value)
    }
}
