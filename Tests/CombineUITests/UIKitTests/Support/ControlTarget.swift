//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI

internal protocol ControlTarget: AnyObject {

    func touchDown()
    func touchDownRepeat()
    func touchDragInside()
    func touchDragOutside()
    func touchDragEnter()
    func touchDragExit()
    func touchUpInside()
    func touchUpOutside()
    func touchCancel()
    func valueChanged()
    func menuActionTriggered()
    func primaryActionTriggered()
    func editingDidBegin()
    func editingChanged()
    func editingDidEnd()
    func editingDidEndOnExit()
}

extension ControlSubscription: ControlTarget {}
