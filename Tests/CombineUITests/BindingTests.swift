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

final class BindingTests: XCTestCase {

    // swiftlint:disable:next strict_fileprivate
    fileprivate class TestObject: Target {

        var value: Int = 0
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

    func testBinding() {
        let subject: PassthroughSubject<Int, Never> = .init()
        var object: TestObject? = .init()
        weak var weakObject: TestObject? = object
        expect(weakObject) != nil
        if let object: TestObject {
            subject
                .bind(to: object.bindable.value)
                .store(in: &cancellables)
        }
        expect(object?.value) == 0
        subject.send(1)
        expect(object?.value) == 1
        subject.send(2)
        expect(object?.value) == 2
        object = nil
        subject.send(3)
        expect(weakObject) == nil
    }
}

extension Bindable where Target: BindingTests.TestObject {

    // swiftlint:disable:next strict_fileprivate
    fileprivate var value: Binding<Int> {
        Binding(self, for: \.value)
    }
}
