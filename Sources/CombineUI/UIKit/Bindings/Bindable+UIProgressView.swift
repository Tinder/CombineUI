//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UIProgressView {

    @preconcurrency @MainActor public var progress: Binding<Float> {
        Binding(self, for: \.progress)
    }

    @preconcurrency
    @MainActor
    public func progress(animated: Bool) -> Binding<Float> {
        Binding(self) { $0.setProgress($1, animated: animated) }
    }
}
