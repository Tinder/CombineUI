//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

public struct Bindable<View: CombineUI.View> {

    internal private(set) weak var view: View?

    internal init(_ view: View) {
        self.view = view
    }
}
