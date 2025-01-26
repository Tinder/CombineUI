//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import UIKit

extension Bindable where Target: UIDatePicker {

    @preconcurrency
    @MainActor
    public var countDownDuration: Binding<TimeInterval> {
        Binding(self, for: \.countDownDuration)
    }

    @preconcurrency
    @MainActor
    public var date: Binding<Date> {
        Binding(self, for: \.date)
    }

    @preconcurrency
    @MainActor
    public func date(animated: Bool) -> Binding<Date> {
        Binding(self) { $0.setDate($1, animated: animated) }
    }
}
