//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

public protocol Target: AnyObject {}

extension Target {

    public var bindable: Bindable<Self> {
        Bindable(self)
    }
}
