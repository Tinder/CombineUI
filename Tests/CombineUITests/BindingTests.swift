//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import Nimble
import XCTest

final class BindingTests: XCTestCase {

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
        let subject: PassthroughSubject<Bool, Never> = .init()
        var view: UIView? = .init()
        weak var weakView: UIView? = view
        expect(weakView) != nil
        if let view: UIView {
            subject
                .bind(to: view.bindable.isHidden)
                .store(in: &cancellables)
        }
        expect(view?.isHidden) == false
        subject.send(true)
        expect(view?.isHidden) == true
        subject.send(false)
        expect(view?.isHidden) == false
        view = nil
        subject.send(true)
        expect(weakView) == nil
    }
}
