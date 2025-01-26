//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

@testable import CombineUI

internal protocol GestureRecognizerTarget: AnyObject {

    func action()
}

extension GestureRecognizerSubscription: GestureRecognizerTarget {}
