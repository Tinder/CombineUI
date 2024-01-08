//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UIStepper {

    @preconcurrency
    @MainActor
    public var value: Binding<Double> {
        Binding(self, for: \.value)
    }
}
