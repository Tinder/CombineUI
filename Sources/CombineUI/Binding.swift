//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine

public struct Binding<Output> {

    internal let receiveValue: (Output) -> Void

    public init<T: Target>(_ bindable: Bindable<T>, for changes: @escaping (T, Output) -> Void) {
        receiveValue = { value in
            guard let target: T = bindable.target
            else { return }
            changes(target, value)
        }
    }

    public init<T: Target>(_ bindable: Bindable<T>, for keyPath: ReferenceWritableKeyPath<T, Output>) {
        self.init(bindable) { $0[keyPath: keyPath] = $1 }
    }

    public init<T: Target>(_ bindable: Bindable<T>, for keyPath: ReferenceWritableKeyPath<T, Output?>) {
        self.init(bindable) { $0[keyPath: keyPath] = $1 }
    }
}

extension Publisher where Failure == Never {

    public func bind(
        to binding: Binding<Output>
    ) -> AnyCancellable {
        sink(receiveValue: binding.receiveValue)
    }
}
