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

@MainActor
internal final class TextFieldDelegate: NSObject, UITextFieldDelegate {

    // swiftlint:disable private_subject

    internal let didBeginEditing: PassthroughSubject<Void, Never> = .init()
    internal let didEndEditing: PassthroughSubject<Void, Never> = .init()
    internal let didChangeSelection: PassthroughSubject<Void, Never> = .init()

    // swiftlint:enable private_subject

    // MARK: - UITextFieldDelegate

    // swiftlint:disable unused_parameter

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

    // swiftlint:enable unused_parameter
}
