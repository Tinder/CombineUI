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
public struct TextFieldInterface<T: UITextField> {

    public private(set) lazy var text: AnyPublisher<String, Never> = textField
        .textPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var attributedText: AnyPublisher<AttributedString, Never> = textField
        .attributedTextPublisher()
        .share()
        .eraseToAnyPublisher()

    // MARK: - UITextFieldDelegate

    public private(set) lazy var didBeginEditing: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .didBeginEditing
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var didEndEditing: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .didEndEditing
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var didChangeSelection: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .didChangeSelection
            .share()
            .eraseToAnyPublisher()
    }()

    private let textField: T
    private let delegate: TextFieldDelegate = .init()

    internal init(textField: T) {
        self.textField = textField
        textField.delegate = delegate
    }
}
