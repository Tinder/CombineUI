//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

public protocol View: AnyObject {}

extension View {

    public var bindable: Bindable<Self> {
        Bindable(self)
    }
}
