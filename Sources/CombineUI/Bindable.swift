//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

public struct Bindable<Target: CombineUI.Target> {

    internal private(set) weak var target: Target?

    internal init(_ target: Target) {
        self.target = target
    }
}
