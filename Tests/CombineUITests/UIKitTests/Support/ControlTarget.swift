//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
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
