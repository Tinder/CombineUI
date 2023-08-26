//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import Nimble
import XCTest

@MainActor
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

        func invoke(_ attributedText: NSAttributedString) {
            self.attributedText = attributedText
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

    func testText() {
        let viewController: TestViewController = .init()
        let textField: TestTextField = viewController.textField
        var receivedValues: [String?] = []
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

    @available(iOS 15, *)
    func testAttributedText() {
        let viewController: TestViewController = .init()
        let textField: TestTextField = viewController.textField
        var receivedValues: [String?] = []
        viewController
            .$textField
            .attributedText
            .map(\.string)
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(textField.targets.count) == 1
        expect(receivedValues) == [""]
        textField.invoke(NSAttributedString("Hello"))
        expect(receivedValues) == ["", "Hello"]
        textField.invoke(NSAttributedString("World"))
        expect(receivedValues) == ["", "Hello", "World"]
    }

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
