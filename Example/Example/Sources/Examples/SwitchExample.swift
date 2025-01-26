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

class SwitchExample: UIViewController {

    @Switch var `switch`: UISwitch = .init()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [`switch`].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            `switch`.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            `switch`.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10)
        ])
        $switch
            .sink { print(Date(), "$switch", "...", $0) }
            .store(in: &cancellables)
        `switch`
            .isOnPublisher()
            .sink { print(Date(), "switch.isOnPublisher()", "...", $0) }
            .store(in: &cancellables)
    }
}
