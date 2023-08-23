//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

internal final class TextFieldDelegate: NSObject, UITextFieldDelegate {

    // swiftlint:disable private_subject

    internal let didBeginEditing: PassthroughSubject<Void, Never> = .init()
    internal let didEndEditing: PassthroughSubject<Void, Never> = .init()
    internal let didChangeSelection: PassthroughSubject<Void, Never> = .init()

    // swiftlint:enable private_subject

    internal func delegatePublisher<T, U>(
        for keyPath: KeyPath<TextFieldDelegate, PassthroughSubject<T, U>>
    ) -> AnyPublisher<T, U> {
        self[keyPath: keyPath].eraseToAnyPublisher()
    }

    // MARK: - UITextFieldDelegate

    internal func textFieldDidBeginEditing(
        _ textField: UITextField
    ) {
        didBeginEditing.send()
    }

    internal func textFieldDidEndEditing(
        _ textField: UITextField
    ) {
        didEndEditing.send()
    }

    internal func textFieldDidChangeSelection(
        _ textField: UITextField
    ) {
        didChangeSelection.send()
    }
}
