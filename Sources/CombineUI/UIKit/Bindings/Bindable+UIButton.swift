//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import UIKit

extension Bindable where Target: UIButton {

    @preconcurrency
    @MainActor
    public func titleColor(for state: UIControl.State = .normal) -> Binding<UIColor> {
        Binding(self) { $0.setTitleColor($1, for: state) }
    }

    @preconcurrency
    @MainActor
    public func titleShadowColor(for state: UIControl.State = .normal) -> Binding<UIColor> {
        Binding(self) { $0.setTitleShadowColor($1, for: state) }
    }

    @preconcurrency
    @MainActor
    public func title(for state: UIControl.State = .normal) -> Binding<String> {
        Binding(self) { $0.setTitle($1, for: state) }
    }

    @preconcurrency
    @MainActor
    public func attributedTitle(for state: UIControl.State = .normal) -> Binding<AttributedString> {
        Binding(self) { $0.setAttributedTitle(NSAttributedString($1), for: state) }
    }

    @preconcurrency
    @MainActor
    public func image(for state: UIControl.State = .normal) -> Binding<UIImage?> {
        Binding(self) { $0.setImage($1, for: state) }
    }

    @preconcurrency
    @MainActor
    public func backgroundImage(for state: UIControl.State = .normal) -> Binding<UIImage?> {
        Binding(self) { $0.setBackgroundImage($1, for: state) }
    }
}
