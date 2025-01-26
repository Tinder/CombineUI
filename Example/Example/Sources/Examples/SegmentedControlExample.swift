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

class SegmentedControlExample: UIViewController {

    @SegmentedControl var segmentedControl: UISegmentedControl = {
        let segmentedControl: UISegmentedControl = .init(items: ["One", "Two", "Three"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [segmentedControl].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10)
        ])
        $segmentedControl
            .sink { print(Date(), "$segmentedControl", "...", $0) }
            .store(in: &cancellables)
        segmentedControl
            .selectedSegmentIndexPublisher()
            .sink { print(Date(), "segmentedControl.selectedSegmentIndexPublisher()", "...", $0) }
            .store(in: &cancellables)
    }
}
