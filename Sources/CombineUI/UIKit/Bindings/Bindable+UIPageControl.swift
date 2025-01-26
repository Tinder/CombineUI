//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import UIKit

extension Bindable where Target: UIPageControl {

    @preconcurrency
    @MainActor
    public var pageIndicatorTintColor: Binding<UIColor> {
        Binding(self, for: \.pageIndicatorTintColor)
    }

    @preconcurrency
    @MainActor
    public var currentPageIndicatorTintColor: Binding<UIColor> {
        Binding(self, for: \.currentPageIndicatorTintColor)
    }

    @preconcurrency
    @MainActor
    public var currentPage: Binding<Int> {
        Binding(self, for: \.currentPage)
    }

    @preconcurrency
    @MainActor
    public var numberOfPages: Binding<Int> {
        Binding(self, for: \.numberOfPages)
    }

    @preconcurrency
    @MainActor
    public var hidesForSinglePage: Binding<Bool> {
        Binding(self, for: \.hidesForSinglePage)
    }
}
