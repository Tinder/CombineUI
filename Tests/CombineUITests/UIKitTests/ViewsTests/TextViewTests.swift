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

final class TextViewTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @TextView var textView: UITextView = .init()
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
        let textView: UITextView = viewController.textView
        var receivedValues: [String] = []
        viewController
            .$textView
            .text
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(receivedValues) == [""]
        textView.text = "Hello"
        textView.delegate?.textViewDidChange?(textView)
        expect(receivedValues) == ["", "Hello"]
        textView.text = "World"
        textView.delegate?.textViewDidChange?(textView)
        expect(receivedValues) == ["", "Hello", "World"]
    }

    @MainActor
    func testAttributedText() {
        let viewController: TestViewController = .init()
        let textView: UITextView = viewController.textView
        var receivedValues: [String] = []
        viewController
            .$textView
            .attributedText
            .map(\.characters)
            .map { $0[...] }
            .map(String.init)
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(receivedValues) == [""]
        textView.attributedText = NSAttributedString("Hello")
        textView.delegate?.textViewDidChange?(textView)
        expect(receivedValues) == ["", "Hello"]
        textView.attributedText = NSAttributedString("World")
        textView.delegate?.textViewDidChange?(textView)
        expect(receivedValues) == ["", "Hello", "World"]
    }

    @MainActor
    func testDidChange() {
        let viewController: TestViewController = .init()
        let textView: UITextView = viewController.textView
        var count: Int = 0
        viewController
            .$textView
            .didChange
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        textView.delegate?.textViewDidChange?(textView)
        expect(count) == 1
        textView.delegate?.textViewDidChange?(textView)
        expect(count) == 2
    }

    @MainActor
    func testDidBeginEditing() {
        let viewController: TestViewController = .init()
        let textView: UITextView = viewController.textView
        var count: Int = 0
        viewController
            .$textView
            .didBeginEditing
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        textView.delegate?.textViewDidBeginEditing?(textView)
        expect(count) == 1
        textView.delegate?.textViewDidBeginEditing?(textView)
        expect(count) == 2
    }

    @MainActor
    func testDidEndEditing() {
        let viewController: TestViewController = .init()
        let textView: UITextView = viewController.textView
        var count: Int = 0
        viewController
            .$textView
            .didEndEditing
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        textView.delegate?.textViewDidEndEditing?(textView)
        expect(count) == 1
        textView.delegate?.textViewDidEndEditing?(textView)
        expect(count) == 2
    }

    @MainActor
    func testDidChangeSelection() {
        let viewController: TestViewController = .init()
        let textView: UITextView = viewController.textView
        var count: Int = 0
        viewController
            .$textView
            .didChangeSelection
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        textView.delegate?.textViewDidChangeSelection?(textView)
        expect(count) == 1
        textView.delegate?.textViewDidChangeSelection?(textView)
        expect(count) == 2
    }
}
