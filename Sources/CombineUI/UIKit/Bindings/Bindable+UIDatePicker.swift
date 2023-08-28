//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UIDatePicker {

    @MainActor public var date: Binding<Date> {
        Binding(self, for: \.date)
    }

    @MainActor public var countDownDuration: Binding<TimeInterval> {
        Binding(self, for: \.countDownDuration)
    }

    @MainActor
    public func date(animated: Bool) -> Binding<Date> {
        Binding(self) { $0.setDate($1, animated: animated) }
    }
}
