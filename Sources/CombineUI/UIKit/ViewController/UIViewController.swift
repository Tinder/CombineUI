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

extension UIViewController {

    public func lifecyclePublisher() -> AnyPublisher<ViewControllerLifecycleEvent, Never> {
        ViewControllerPublisher(viewController: self).eraseToAnyPublisher()
    }

    internal func contain(_ viewController: UIViewController) {
        addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewController.view)
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            viewController.view.widthAnchor.constraint(equalToConstant: 0),
            viewController.view.heightAnchor.constraint(equalToConstant: 0)
        ])
        viewController.didMove(toParent: self)
    }

    internal func uncontain(_ viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

extension Publisher {

    public func isVisiblePublisher() -> AnyPublisher<Bool, Failure> where Output == ViewControllerLifecycleEvent {
        self
            .compactMap { event in
                switch event {
                case .viewWillAppear:
                    return true
                case .viewDidAppear, .viewWillDisappear:
                    return nil
                case .viewDidDisappear:
                    return false
                }
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
