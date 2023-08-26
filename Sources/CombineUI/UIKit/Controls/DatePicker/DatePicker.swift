//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

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

    public func datePublisher() -> AnyPublisher<Date, Never> {
        publisher(for: .valueChanged)
            .compactMap(bindable)
            .map(\.date)
            .prepend(date)
            .eraseToAnyPublisher()
    }

    public func countDownDurationPublisher() -> AnyPublisher<TimeInterval, Never> {
        publisher(for: .valueChanged)
            .compactMap(bindable)
            .map(\.countDownDuration)
            .prepend(countDownDuration)
            .eraseToAnyPublisher()
    }
}
