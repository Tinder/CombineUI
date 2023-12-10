//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@preconcurrency
@MainActor
@propertyWrapper
public struct TextField<T: UITextField> {

    public var wrappedValue: T
    public var projectedValue: TextFieldInterface<T>

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = TextFieldInterface(textField: wrappedValue)
    }
}

extension UITextField {

    @preconcurrency
    @MainActor
    public func textPublisher() -> AnyPublisher<String, Never> {
        publisher(for: .allEditingEvents)
            .compactMap(bindable)
            .map(\.text)
            .prepend(text)
            .map { $0 ?? "" }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    @preconcurrency
    @MainActor
    public func attributedTextPublisher() -> AnyPublisher<AttributedString, Never> {
        publisher(for: .allEditingEvents)
            .compactMap(bindable)
            .map(\.attributedText)
            .prepend(attributedText)
            .map { $0.flatMap { AttributedString($0) } ?? AttributedString("") }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
