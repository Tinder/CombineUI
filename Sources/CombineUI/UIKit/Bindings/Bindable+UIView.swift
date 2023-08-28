//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UIView {

    @MainActor public var alpha: Binding<CGFloat> {
        Binding(self, for: \.alpha)
    }

    @MainActor public var isHidden: Binding<Bool> {
        Binding(self, for: \.isHidden)
    }
}
