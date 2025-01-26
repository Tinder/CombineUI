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
public struct DatePickerInterface<T: UIDatePicker> {

    public private(set) lazy var countDownDuration: AnyPublisher<TimeInterval, Never> = datePicker
        .countDownDurationPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var date: AnyPublisher<Date, Never> = datePicker
        .datePublisher()
        .share()
        .eraseToAnyPublisher()

    private let datePicker: T

    internal init(datePicker: T) {
        self.datePicker = datePicker
    }
}
