//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@preconcurrency
@MainActor
public struct ControlInterface<T: UIControl> {

    public private(set) lazy var touchDown: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDown)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDownRepeat: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDownRepeat)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDragInside: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDragInside)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDragOutside: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDragOutside)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDragEnter: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDragEnter)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDragExit: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDragExit)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchUpInside: AnyPublisher<Void, Never> = control
        .publisher(for: .touchUpInside)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchUpOutside: AnyPublisher<Void, Never> = control
        .publisher(for: .touchUpOutside)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchCancel: AnyPublisher<Void, Never> = control
        .publisher(for: .touchCancel)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var valueChanged: AnyPublisher<Void, Never> = control
        .publisher(for: .valueChanged)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var menuActionTriggered: AnyPublisher<Void, Never> = control
        .publisher(for: .menuActionTriggered)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var primaryActionTriggered: AnyPublisher<Void, Never> = control
        .publisher(for: .primaryActionTriggered)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var editingDidBegin: AnyPublisher<Void, Never> = control
        .publisher(for: .editingDidBegin)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var editingChanged: AnyPublisher<Void, Never> = control
        .publisher(for: .editingChanged)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var editingDidEnd: AnyPublisher<Void, Never> = control
        .publisher(for: .editingDidEnd)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var editingDidEndOnExit: AnyPublisher<Void, Never> = control
        .publisher(for: .editingDidEndOnExit)
        .map(to: Void())
        .share()
        .eraseToAnyPublisher()

    private let control: T

    internal init(control: T) {
        self.control = control
    }
}
