//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@MainActor
internal final class TextFieldDelegate: NSObject, UITextFieldDelegate {

    // swiftlint:disable private_subject

    internal let didBeginEditing: PassthroughSubject<Void, Never> = .init()
    internal let didEndEditing: PassthroughSubject<Void, Never> = .init()
    internal let didChangeSelection: PassthroughSubject<Void, Never> = .init()

    // swiftlint:enable private_subject

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
