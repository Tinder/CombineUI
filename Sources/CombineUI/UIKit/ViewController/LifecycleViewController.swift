//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import UIKit

public enum ViewControllerLifecycleEvent {

    case viewWillAppear
    case viewDidAppear
    case viewWillDisappear
    case viewDidDisappear
}

internal protocol LifecycleViewControllerDelegate: AnyObject {

    func lifecycle(_ event: ViewControllerLifecycleEvent)
}

internal final class LifecycleViewController: UIViewController {

    internal weak var delegate: LifecycleViewControllerDelegate?

    override internal func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.lifecycle(.viewWillAppear)
    }

    override internal func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.lifecycle(.viewDidAppear)
    }

    override internal func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.lifecycle(.viewWillDisappear)
    }

    override internal func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.lifecycle(.viewDidDisappear)
    }
}
