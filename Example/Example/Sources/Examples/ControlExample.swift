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

class ControlExample: UIViewController {

    @Control var control: UIButton = {
        let button: UIButton = .init()
        button.configuration = .filled()
        button.setTitle("Touch and Drag Here", for: .normal)
        return button
    }()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [control].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            control.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            control.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10)
        ])
        $control
            .touchDown
            .sink { print(Date(), "$control.touchDown") }
            .store(in: &cancellables)
        $control
            .touchDownRepeat
            .sink { print(Date(), "$control.touchDownRepeat") }
            .store(in: &cancellables)
        $control
            .touchDragInside
            .sink { print(Date(), "$control.touchDragInside") }
            .store(in: &cancellables)
        $control
            .touchDragOutside
            .sink { print(Date(), "$control.touchDragOutside") }
            .store(in: &cancellables)
        $control
            .touchDragEnter
            .sink { print(Date(), "$control.touchDragEnter") }
            .store(in: &cancellables)
        $control
            .touchDragExit
            .sink { print(Date(), "$control.touchDragExit") }
            .store(in: &cancellables)
        $control
            .touchUpInside
            .sink { print(Date(), "$control.touchUpInside") }
            .store(in: &cancellables)
        $control
            .touchUpOutside
            .sink { print(Date(), "$control.touchUpOutside") }
            .store(in: &cancellables)
        $control
            .touchCancel
            .sink { print(Date(), "$control.touchCancel") }
            .store(in: &cancellables)
        $control
            .valueChanged
            .sink { print(Date(), "$control.valueChanged") }
            .store(in: &cancellables)
        $control
            .menuActionTriggered
            .sink { print(Date(), "$control.menuActionTriggered") }
            .store(in: &cancellables)
        $control
            .primaryActionTriggered
            .sink { print(Date(), "$control.primaryActionTriggered") }
            .store(in: &cancellables)
        $control
            .editingDidBegin
            .sink { print(Date(), "$control.editingDidBegin") }
            .store(in: &cancellables)
        $control
            .editingChanged
            .sink { print(Date(), "$control.editingChanged") }
            .store(in: &cancellables)
        $control
            .editingDidEnd
            .sink { print(Date(), "$control.editingDidEnd") }
            .store(in: &cancellables)
        $control
            .editingDidEndOnExit
            .sink { print(Date(), "$control.editingDidEndOnExit") }
            .store(in: &cancellables)
        control
            .publisher(for: .allEvents)
            .map(\.stringValue)
            .sink { print(Date(), "control.publisher(for: .allEvents)", "...", $0) }
            .store(in: &cancellables)
    }
}

extension UIControl.Event {

    var stringValue: String {
        switch self {
        case let controlEvents where controlEvents.contains(.touchDown):
            return "touchDown"
        case let controlEvents where controlEvents.contains(.touchDownRepeat):
            return "touchDownRepeat"
        case let controlEvents where controlEvents.contains(.touchDragInside):
            return "touchDragInside"
        case let controlEvents where controlEvents.contains(.touchDragOutside):
            return "touchDragOutside"
        case let controlEvents where controlEvents.contains(.touchDragEnter):
            return "touchDragEnter"
        case let controlEvents where controlEvents.contains(.touchDragExit):
            return "touchDragExit"
        case let controlEvents where controlEvents.contains(.touchUpInside):
            return "touchUpInside"
        case let controlEvents where controlEvents.contains(.touchUpOutside):
            return "touchUpOutside"
        case let controlEvents where controlEvents.contains(.touchCancel):
            return "touchCancel"
        case let controlEvents where controlEvents.contains(.valueChanged):
            return "valueChanged"
        case let controlEvents where controlEvents.contains(.menuActionTriggered):
            return "menuActionTriggered"
        case let controlEvents where controlEvents.contains(.primaryActionTriggered):
            return "primaryActionTriggered"
        case let controlEvents where controlEvents.contains(.editingDidBegin):
            return "editingDidBegin"
        case let controlEvents where controlEvents.contains(.editingChanged):
            return "editingChanged"
        case let controlEvents where controlEvents.contains(.editingDidEnd):
            return "editingDidEnd"
        case let controlEvents where controlEvents.contains(.editingDidEndOnExit):
            return "editingDidEndOnExit"
        default:
            return "UNKNOWN"
        }
    }
}
