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
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDownRepeat: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDownRepeat)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDragInside: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDragInside)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDragOutside: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDragOutside)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDragEnter: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDragEnter)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchDragExit: AnyPublisher<Void, Never> = control
        .publisher(for: .touchDragExit)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchUpInside: AnyPublisher<Void, Never> = control
        .publisher(for: .touchUpInside)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchUpOutside: AnyPublisher<Void, Never> = control
        .publisher(for: .touchUpOutside)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var touchCancel: AnyPublisher<Void, Never> = control
        .publisher(for: .touchCancel)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var valueChanged: AnyPublisher<Void, Never> = control
        .publisher(for: .valueChanged)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var menuActionTriggered: AnyPublisher<Void, Never> = control
        .publisher(for: .menuActionTriggered)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var primaryActionTriggered: AnyPublisher<Void, Never> = control
        .publisher(for: .primaryActionTriggered)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var editingDidBegin: AnyPublisher<Void, Never> = control
        .publisher(for: .editingDidBegin)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var editingChanged: AnyPublisher<Void, Never> = control
        .publisher(for: .editingChanged)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var editingDidEnd: AnyPublisher<Void, Never> = control
        .publisher(for: .editingDidEnd)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var editingDidEndOnExit: AnyPublisher<Void, Never> = control
        .publisher(for: .editingDidEndOnExit)
        .replaceOutput(with: Void())
        .share()
        .eraseToAnyPublisher()

    private let control: T

    internal init(control: T) {
        self.control = control
    }
}
