//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UIView {

    @preconcurrency
    @MainActor
    public var isUserInteractionEnabled: Binding<Bool> {
        Binding(self, for: \.isUserInteractionEnabled)
    }

    @preconcurrency
    @MainActor
    public var isMultipleTouchEnabled: Binding<Bool> {
        Binding(self, for: \.isMultipleTouchEnabled)
    }

    @preconcurrency
    @MainActor
    public var isExclusiveTouch: Binding<Bool> {
        Binding(self, for: \.isExclusiveTouch)
    }

    @preconcurrency
    @MainActor
    public var clipsToBounds: Binding<Bool> {
        Binding(self, for: \.clipsToBounds)
    }

    @preconcurrency
    @MainActor
    public var tintColor: Binding<UIColor> {
        Binding(self, for: \.tintColor)
    }

    @preconcurrency
    @MainActor
    public var backgroundColor: Binding<UIColor> {
        Binding(self, for: \.backgroundColor)
    }

    @preconcurrency
    @MainActor
    public var borderColor: Binding<UIColor> {
        Binding(self) { $0.layer.borderColor = $1.cgColor }
    }

    @preconcurrency
    @MainActor
    public var shadowColor: Binding<UIColor> {
        Binding(self) { $0.layer.shadowColor = $1.cgColor }
    }

    @preconcurrency
    @MainActor
    public var alpha: Binding<CGFloat> {
        Binding(self, for: \.alpha)
    }

    @preconcurrency
    @MainActor
    public var isOpaque: Binding<Bool> {
        Binding(self, for: \.isOpaque)
    }

    @preconcurrency
    @MainActor
    public var isHidden: Binding<Bool> {
        Binding(self, for: \.isHidden)
    }
}
