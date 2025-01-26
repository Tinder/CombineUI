//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
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
