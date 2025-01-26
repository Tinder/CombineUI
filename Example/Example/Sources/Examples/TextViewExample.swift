//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import Combine
import CombineUI
import UIKit

class TextViewExample: UIViewController {

    @TextView var textView: UITextView = {
        let textView: UITextView = .init()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.font = .preferredFont(forTextStyle: .body)
        textView.text = "Hello World"
        return textView
    }()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [textView].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            textView.heightAnchor.constraint(equalToConstant: 80),
            textView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10)
        ])
        $textView
            .text
            .sink { print(Date(), "$textView.text", "...", "\"\($0)\"") }
            .store(in: &cancellables)
        $textView
            .attributedText
            .map(\.characters)
            .map { $0[...] }
            .map(String.init)
            .sink { print(Date(), "$textView.attributedText", "...", "\"\($0)\"") }
            .store(in: &cancellables)
        $textView
            .didChange
            .sink { print(Date(), "$textView.didChange") }
            .store(in: &cancellables)
        $textView
            .didBeginEditing
            .sink { print(Date(), "$textView.didBeginEditing") }
            .store(in: &cancellables)
        $textView
            .didEndEditing
            .sink { print(Date(), "$textView.didEndEditing") }
            .store(in: &cancellables)
        $textView
            .didChangeSelection
            .sink { print(Date(), "$textView.didChangeSelection") }
            .store(in: &cancellables)
        textView.becomeFirstResponder()
    }
}
