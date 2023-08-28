//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import UIKit

class StepperExample: UIViewController {

    @Stepper var stepper: UIStepper = .init()

    let label: UILabel = .init()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [stepper, label].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            stepper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stepper.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: stepper.topAnchor, constant: -20)
        ])
        $stepper
            .map(Int.init)
            .map(String.init)
            .sink { [weak self] in
                guard let self else { return }
                label.text = $0
                print(Date(), "$stepper", "...", $0)
            }
            .store(in: &cancellables)
        stepper
            .valuePublisher()
            .map(Int.init)
            .sink { print(Date(), "stepper.valuePublisher()", "...", $0) }
            .store(in: &cancellables)
    }
}
