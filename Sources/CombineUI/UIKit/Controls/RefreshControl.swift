//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@propertyWrapper
public struct RefreshControl<T: UIRefreshControl> {

    public var wrappedValue: T
    public var projectedValue: AnyPublisher<Void, Never>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = wrappedValue
            .refreshPublisher()
            .share()
            .eraseToAnyPublisher()
    }
}

extension UIRefreshControl {

    public func refreshPublisher() -> AnyPublisher<Void, Never> {
        publisher(for: .valueChanged)
            .compactMap(bindable)
            .map(\.isRefreshing)
            .filter { $0 }
            .voidPublisher()
            .eraseToAnyPublisher()
    }
}
