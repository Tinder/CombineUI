//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import Combine
import CombineUI
import UIKit

class DatePickerExample: UIViewController {

    @DatePicker(mode: .countDownTimer)
    var datePicker1: UIDatePicker = .init()

    @DatePicker var datePicker2: UIDatePicker = .init()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [datePicker2, datePicker1].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            datePicker1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker1.bottomAnchor.constraint(equalTo: datePicker2.topAnchor, constant: -30),
            datePicker2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        ])
        $datePicker1
            .countDownDuration
            .sink { print(Date(), "$datePicker2.countDownDuration", "...", $0) }
            .store(in: &cancellables)
        $datePicker2
            .date
            .sink { print(Date(), "$datePicker1.date", "...", $0) }
            .store(in: &cancellables)
        datePicker1
            .countDownDurationPublisher()
            .sink { print(Date(), "datePicker2.countDownDurationPublisher()", "...", $0) }
            .store(in: &cancellables)
        datePicker2
            .datePublisher()
            .sink { print(Date(), "datePicker1.datePublisher()", "...", $0) }
            .store(in: &cancellables)
    }
}
