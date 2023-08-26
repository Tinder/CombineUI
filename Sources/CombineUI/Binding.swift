//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine

public struct Binding<Output> {

    internal let receiveValue: (Output) -> Void

    public init<T: View>(_ bindable: Bindable<T>, for changes: @escaping (T, Output) -> Void) {
        receiveValue = { value in
            guard let view: T = bindable.view
            else { return }
            changes(view, value)
        }
    }

    public init<T: View>(_ bindable: Bindable<T>, for keyPath: ReferenceWritableKeyPath<T, Output>) {
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
