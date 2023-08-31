//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@preconcurrency
@MainActor
public struct DatePickerInterface<T: UIDatePicker> {

    public private(set) lazy var date: AnyPublisher<Date, Never> = datePicker
        .datePublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var countDownDuration: AnyPublisher<TimeInterval, Never> = datePicker
        .countDownDurationPublisher()
        .share()
        .eraseToAnyPublisher()

    private let datePicker: T

    internal init(datePicker: T) {
        self.datePicker = datePicker
    }
}
