//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import UIKit

class DatePickerExample: UIViewController {

    @DatePicker var datePicker1: UIDatePicker = .init()

    @DatePicker(mode: .countDownTimer)
    var datePicker2: UIDatePicker = .init()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [datePicker1, datePicker2].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            datePicker1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker1.bottomAnchor.constraint(equalTo: datePicker2.topAnchor, constant: -30),
            datePicker2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
        $datePicker1
            .date
            .sink { print(Date(), "$datePicker1.date", "...", $0) }
            .store(in: &cancellables)
        $datePicker2
            .countDownDuration
            .sink { print(Date(), "$datePicker2.countDownDuration", "...", $0) }
            .store(in: &cancellables)
        datePicker1
            .datePublisher()
            .sink { print(Date(), "datePicker1.datePublisher()", "...", $0) }
            .store(in: &cancellables)
        datePicker2
            .countDownDurationPublisher()
            .sink { print(Date(), "datePicker2.countDownDurationPublisher()", "...", $0) }
            .store(in: &cancellables)
    }
}
