//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import UIKit

class TextFieldExample: UIViewController {

    @TextField var textField: UITextField = {
        let textField: UITextField = .init()
        textField.borderStyle = .roundedRect
        textField.text = "Hello World"
        return textField
    }()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [textField].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10)
        ])
        $textField
            .text
            .sink { print(Date(), "$textField.text", "...", "\"\($0)\"") }
            .store(in: &cancellables)
        $textField
            .attributedText
            .map(\.characters)
            .map { $0[...] }
            .map(String.init)
            .sink { print(Date(), "$textField.attributedText", "...", "\"\($0)\"") }
            .store(in: &cancellables)
        $textField
            .didBeginEditing
            .sink { print(Date(), "$textField.didBeginEditing") }
            .store(in: &cancellables)
        $textField
            .didEndEditing
            .sink { print(Date(), "$textField.didEndEditing") }
            .store(in: &cancellables)
        $textField
            .didChangeSelection
            .sink { print(Date(), "$textField.didChangeSelection") }
            .store(in: &cancellables)
        textField
            .textPublisher()
            .sink { print(Date(), "textField.textPublisher()", "...", "\"\($0)\"") }
            .store(in: &cancellables)
        textField
            .attributedTextPublisher()
            .map(\.characters)
            .map { $0[...] }
            .map(String.init)
            .sink { print(Date(), "textField.attributedTextPublisher()", "...", "\"\($0)\"") }
            .store(in: &cancellables)
        textField.becomeFirstResponder()
    }
}
