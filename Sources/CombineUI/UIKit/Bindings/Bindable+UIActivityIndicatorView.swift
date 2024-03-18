//
//  Copyright © 2024 Tinder (Match Group, LLC)
//

import Combine
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
