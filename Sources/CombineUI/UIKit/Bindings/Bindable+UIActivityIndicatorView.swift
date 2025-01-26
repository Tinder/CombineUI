//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import UIKit

extension Bindable where Target: UIActivityIndicatorView {

    @preconcurrency
    @MainActor
    public var style: Binding<UIActivityIndicatorView.Style> {
        Binding(self, for: \.style)
    }

    @preconcurrency
    @MainActor
    public var color: Binding<UIColor> {
        Binding(self, for: \.color)
    }

    @preconcurrency
    @MainActor
    public var hidesWhenStopped: Binding<Bool> {
        Binding(self, for: \.hidesWhenStopped)
    }

    @preconcurrency
    @MainActor
    public var isAnimating: Binding<Bool> {
        Binding(self) { activityIndicatorView, isAnimating in
            if isAnimating {
                activityIndicatorView.startAnimating()
            } else {
                activityIndicatorView.stopAnimating()
            }
        }
    }
}
