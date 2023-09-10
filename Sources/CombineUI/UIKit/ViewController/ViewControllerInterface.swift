//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@preconcurrency
@MainActor
public struct ViewControllerInterface<T: UIViewController> {

    public private(set) lazy var isVisible: AnyPublisher<Bool, Never> = lifecycle
        .isVisiblePublisher()
        .eraseToAnyPublisher()

    public private(set) lazy var viewWillAppear: AnyPublisher<Void, Never> = lifecycle
        .filter { $0 == .viewWillAppear }
        .map(to: Void())
        .eraseToAnyPublisher()

    public private(set) lazy var viewDidAppear: AnyPublisher<Void, Never> = lifecycle
        .filter { $0 == .viewDidAppear }
        .map(to: Void())
        .eraseToAnyPublisher()

    public private(set) lazy var viewWillDisappear: AnyPublisher<Void, Never> = lifecycle
        .filter { $0 == .viewWillDisappear }
        .map(to: Void())
        .eraseToAnyPublisher()

    public private(set) lazy var viewDidDisappear: AnyPublisher<Void, Never> = lifecycle
        .filter { $0 == .viewDidDisappear }
        .map(to: Void())
        .eraseToAnyPublisher()

    private let lifecycle: AnyPublisher<ViewControllerLifecycleEvent, Never>

    internal init(viewController: T) {
        lifecycle = viewController
            .lifecyclePublisher()
            .share()
            .eraseToAnyPublisher()
    }
}
