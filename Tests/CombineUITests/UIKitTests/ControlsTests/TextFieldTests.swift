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
import Nimble
import XCTest

final class TextFieldTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @TextField var textField: TestTextField = .init()
    }

    private final class TestTextField: UITextField {

        private(set) var targets: [ObjectIdentifier: ControlTarget] = [:]

        func invoke(_ text: String) {
            self.text = text
            targets.values.forEach { $0.editingChanged() }
        }

        func invoke(_ attributedText: AttributedString) {
            self.attributedText = NSAttributedString(attributedText)
            targets.values.forEach { $0.editingChanged() }
        }

        override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
            if let target: ControlTarget = target as? ControlTarget {
                targets[ObjectIdentifier(target)] = target
            }
            super.addTarget(target, action: action, for: controlEvents)
        }
    }

    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = Set()
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    @MainActor
    func testText() {
        let viewController: TestViewController = .init()
        let textField: TestTextField = viewController.textField
        var receivedValues: [String] = []
        viewController
            .$textField
            .text
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(textField.targets.count) == 1
        expect(receivedValues) == [""]
        textField.invoke("Hello")
        expect(receivedValues) == ["", "Hello"]
        textField.invoke("World")
        expect(receivedValues) == ["", "Hello", "World"]
    }

    @MainActor
    func testAttributedText() {
        let viewController: TestViewController = .init()
        let textField: TestTextField = viewController.textField
        var receivedValues: [String] = []
        viewController
            .$textField
            .attributedText
            .map(\.characters)
            .map { $0[...] }
            .map(String.init)
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(textField.targets.count) == 1
        expect(receivedValues) == [""]
        textField.invoke(AttributedString("Hello"))
        expect(receivedValues) == ["", "Hello"]
        textField.invoke(AttributedString("World"))
        expect(receivedValues) == ["", "Hello", "World"]
    }

    @MainActor
    func testDidBeginEditing() {
        let viewController: TestViewController = .init()
        let textField: TestTextField = viewController.textField
        var count: Int = 0
        viewController
            .$textField
            .didBeginEditing
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        textField.delegate?.textFieldDidBeginEditing?(textField)
        expect(count) == 1
        textField.delegate?.textFieldDidBeginEditing?(textField)
        expect(count) == 2
    }

    @MainActor
    func testDidEndEditing() {
        let viewController: TestViewController = .init()
        let textField: TestTextField = viewController.textField
        var count: Int = 0
        viewController
            .$textField
            .didEndEditing
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        textField.delegate?.textFieldDidEndEditing?(textField)
        expect(count) == 1
        textField.delegate?.textFieldDidEndEditing?(textField)
        expect(count) == 2
    }

    @MainActor
    func testDidChangeSelection() {
        let viewController: TestViewController = .init()
        let textField: TestTextField = viewController.textField
        var count: Int = 0
        viewController
            .$textField
            .didChangeSelection
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        textField.delegate?.textFieldDidChangeSelection?(textField)
        expect(count) == 1
        textField.delegate?.textFieldDidChangeSelection?(textField)
        expect(count) == 2
    }
}
