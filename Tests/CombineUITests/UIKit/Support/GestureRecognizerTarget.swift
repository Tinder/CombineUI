//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

@testable import CombineUI

internal protocol GestureRecognizerTarget: AnyObject {

    func action()
}

extension GestureRecognizerSubscription: GestureRecognizerTarget {}
