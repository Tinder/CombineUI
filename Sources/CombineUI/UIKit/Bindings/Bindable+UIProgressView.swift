//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import UIKit

extension Bindable where Target: UIProgressView {

    @preconcurrency
    @MainActor
    public var trackTintColor: Binding<UIColor> {
        Binding(self, for: \.trackTintColor)
    }

    @preconcurrency
    @MainActor
    public var progressTintColor: Binding<UIColor> {
        Binding(self, for: \.progressTintColor)
    }

    @preconcurrency
    @MainActor
    public var progress: Binding<Float> {
        Binding(self, for: \.progress)
    }

    @preconcurrency
    @MainActor
    public func progress(animated: Bool) -> Binding<Float> {
        Binding(self) { $0.setProgress($1, animated: animated) }
    }
}
