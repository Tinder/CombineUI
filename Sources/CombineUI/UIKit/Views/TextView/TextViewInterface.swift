//
//  Copyright © 2024 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@preconcurrency
@MainActor
public struct TextViewInterface<T: UITextView> {

    public private(set) lazy var text: AnyPublisher<String, Never> = { @MainActor in
        delegate
            .didChange
            .map(\.text)
            .prepend(textView.text)
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var attributedText: AnyPublisher<AttributedString, Never> = { @MainActor in
        delegate
            .didChange
            .map(\.attributedText)
            .prepend(textView.attributedText)
            .map { $0.flatMap { AttributedString($0) } ?? AttributedString("") }
            .share()
            .eraseToAnyPublisher()
    }()

    // MARK: - UITextViewDelegate

    public private(set) lazy var didChange: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .didChange
            .replaceOutput(with: Void())
            .share()
            .eraseToAnyPublisher()
    }()

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

    private let textView: T
    private let delegate: TextViewDelegate = .init()

    internal init(textView: T) {
        self.textView = textView
        textView.delegate = delegate
    }
}
