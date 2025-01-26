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
public struct ViewControllerInterface<T: UIViewController> {

    public private(set) lazy var isVisible: AnyPublisher<Bool, Never> = { @MainActor in
        lifecycle
            .isVisiblePublisher()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var viewWillAppear: AnyPublisher<Void, Never> = { @MainActor in
        lifecycle
            .filter { $0 == .viewWillAppear }
            .replaceOutput(with: Void())
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var viewDidAppear: AnyPublisher<Void, Never> = { @MainActor in
        lifecycle
            .filter { $0 == .viewDidAppear }
            .replaceOutput(with: Void())
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var viewWillDisappear: AnyPublisher<Void, Never> = { @MainActor in
        lifecycle
            .filter { $0 == .viewWillDisappear }
            .replaceOutput(with: Void())
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var viewDidDisappear: AnyPublisher<Void, Never> = { @MainActor in
        lifecycle
            .filter { $0 == .viewDidDisappear }
            .replaceOutput(with: Void())
            .eraseToAnyPublisher()
    }()

    private let lifecycle: AnyPublisher<ViewControllerLifecycleEvent, Never>

    internal init(viewController: T) {
        lifecycle = viewController
            .lifecyclePublisher()
            .share()
            .eraseToAnyPublisher()
    }
}
