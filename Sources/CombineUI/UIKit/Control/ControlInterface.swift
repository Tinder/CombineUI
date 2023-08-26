//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@MainActor
public struct ControlInterface<T: UIControl> {

    public private(set) lazy var touchDown: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDown)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDownRepeat: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDownRepeat)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDragInside: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDragInside)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDragOutside: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDragOutside)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDragEnter: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDragEnter)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDragExit: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDragExit)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchUpInside: AnyPublisher<Void, Never> = control
        .publisher(for: .touchUpInside)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchUpOutside: AnyPublisher<Void, Never> = control
        .publisher(for: .touchUpOutside)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchCancel: AnyPublisher<Void, Never> = control
        .publisher(for: .touchCancel)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var valueChanged: AnyPublisher<Void, Never> = control
        .publisher(for: .valueChanged)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var menuActionTriggered: AnyPublisher<Void, Never> = control
        .publisher(for: .menuActionTriggered)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var primaryActionTriggered: AnyPublisher<Void, Never> = control
        .publisher(for: .primaryActionTriggered)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var editingDidBegin: AnyPublisher<Void, Never> = control
        .publisher(for: .editingDidBegin)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var editingChanged: AnyPublisher<Void, Never> = control
        .publisher(for: .editingChanged)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var editingDidEnd: AnyPublisher<Void, Never> = control
        .publisher(for: .editingDidEnd)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var editingDidEndOnExit: AnyPublisher<Void, Never> = control
        .publisher(for: .editingDidEndOnExit)
        .voidPublisher()
        .share()
        .eraseToAnyPublisher()

    private let control: T

    internal init(control: T) {
        self.control = control
    }
}
