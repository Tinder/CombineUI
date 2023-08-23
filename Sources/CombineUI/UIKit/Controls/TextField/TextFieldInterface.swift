//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

public struct TextFieldInterface<T: UITextField> {

    public private(set) lazy var text: AnyPublisher<String, Never> = textField
        .textPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var attributedText: AnyPublisher<NSAttributedString, Never> = {
        guard #available(iOS 15, *)
        else { return Empty(completeImmediately: false).eraseToAnyPublisher() }
        return textField
            .attributedTextPublisher()
            .share()
            .eraseToAnyPublisher()
    }()

    // MARK: - UITextFieldDelegate

    public private(set) lazy var didBeginEditing: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.didBeginEditing)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var didEndEditing: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.didEndEditing)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var didChangeSelection: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.didChangeSelection)
        .share()
        .eraseToAnyPublisher()

    private let textField: T
    private let delegate: TextFieldDelegate = .init()

    internal init(textField: T) {
        self.textField = textField
        textField.delegate = delegate
    }
}
