//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import Combine
import UIKit

@preconcurrency
@MainActor
@propertyWrapper
public struct DatePicker<T: UIDatePicker> {

    public var wrappedValue: T
    public var projectedValue: DatePickerInterface<T>

    public init(wrappedValue: T, mode: UIDatePicker.Mode = .dateAndTime) {
        wrappedValue.datePickerMode = mode
        self.wrappedValue = wrappedValue
        self.projectedValue = DatePickerInterface(datePicker: wrappedValue)
    }
}

extension UIDatePicker {

    @preconcurrency
    @MainActor
    public func countDownDurationPublisher() -> AnyPublisher<TimeInterval, Never> {
        publisher(for: .valueChanged)
            .compactMap(bindable)
            .map(\.countDownDuration)
            .prepend(countDownDuration)
            .eraseToAnyPublisher()
    }

    @preconcurrency
    @MainActor
    public func datePublisher() -> AnyPublisher<Date, Never> {
        publisher(for: .valueChanged)
            .compactMap(bindable)
            .map(\.date)
            .prepend(date)
            .eraseToAnyPublisher()
    }
}
