//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import UIKit

class ButtonExample: UIViewController {

    @Button var button: UIButton = {
        let button: UIButton = .init()
        button.configuration = .filled()
        button.setTitle("Tap Here", for: .normal)
        return button
    }()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [button].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10)
        ])
        $button
            .sink { print(Date(), "$button") }
            .store(in: &cancellables)
        button
            .tapPublisher()
            .sink { print(Date(), "button.tapPublisher()") }
            .store(in: &cancellables)
    }
}
