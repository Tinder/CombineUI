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
internal final class TextViewDelegate: NSObject, UITextViewDelegate {

    // swiftlint:disable private_subject

    internal let didChange: PassthroughSubject<UITextView, Never> = .init()
    internal let didBeginEditing: PassthroughSubject<Void, Never> = .init()
    internal let didEndEditing: PassthroughSubject<Void, Never> = .init()
    internal let didChangeSelection: PassthroughSubject<Void, Never> = .init()

    // swiftlint:enable private_subject

    // MARK: - UITextViewDelegate

    // swiftlint:disable unused_parameter

    internal func textViewDidChange(
        _ textView: UITextView
    ) {
        didChange.send(textView)
    }

    internal func textViewDidBeginEditing(
        _ textView: UITextView
    ) {
        didBeginEditing.send()
    }

    internal func textViewDidEndEditing(
        _ textView: UITextView
    ) {
        didEndEditing.send()
    }

    internal func textViewDidChangeSelection(
        _ textView: UITextView
    ) {
        didChangeSelection.send()
    }

    // swiftlint:enable unused_parameter
}
