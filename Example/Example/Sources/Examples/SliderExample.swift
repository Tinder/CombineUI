//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import UIKit

class SliderExample: UIViewController {

    @Slider var slider: UISlider = .init()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [slider].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            slider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10)
        ])
        $slider
            .sink { print(Date(), "$slider", "...", $0) }
            .store(in: &cancellables)
        slider
            .valuePublisher()
            .sink { print(Date(), "slider.valuePublisher()", "...", $0) }
            .store(in: &cancellables)
    }
}
