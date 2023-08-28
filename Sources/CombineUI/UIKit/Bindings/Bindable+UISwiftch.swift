//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UISwitch {

    @MainActor public var isOn: Binding<Bool> {
        Binding(self, for: \.isOn)
    }

    @MainActor
    public func isOn(animated: Bool) -> Binding<Bool> {
        Binding(self) { $0.setOn($1, animated: animated) }
    }
}
