//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@MainActor
public struct ViewControllerInterface<T: UIViewController> {

    public private(set) lazy var isVisible: AnyPublisher<Bool, Never> = lifecycle
        .isVisiblePublisher()
        .eraseToAnyPublisher()

    public private(set) lazy var viewWillAppear: AnyPublisher<Void, Never> = lifecycle
        .filter { $0 == .viewWillAppear }
        .voidPublisher()
        .eraseToAnyPublisher()

    public private(set) lazy var viewDidAppear: AnyPublisher<Void, Never> = lifecycle
        .filter { $0 == .viewDidAppear }
        .voidPublisher()
        .eraseToAnyPublisher()

    public private(set) lazy var viewWillDisappear: AnyPublisher<Void, Never> = lifecycle
        .filter { $0 == .viewWillDisappear }
        .voidPublisher()
        .eraseToAnyPublisher()

    public private(set) lazy var viewDidDisappear: AnyPublisher<Void, Never> = lifecycle
        .filter { $0 == .viewDidDisappear }
        .voidPublisher()
        .eraseToAnyPublisher()

    private let lifecycle: AnyPublisher<ViewControllerLifecycleEvent, Never>

    internal init(viewController: T) {
        lifecycle = viewController
            .lifecyclePublisher()
            .share()
            .eraseToAnyPublisher()
    }
}
