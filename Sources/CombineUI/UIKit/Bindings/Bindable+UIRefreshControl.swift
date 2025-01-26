//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import UIKit

extension Bindable where Target: UIRefreshControl {

    @preconcurrency
    @MainActor
    public var tintColor: Binding<UIColor> {
        Binding(self, for: \.tintColor)
    }

    @preconcurrency
    @MainActor
    public var attributedTitle: Binding<AttributedString> {
        Binding(self) { $0.attributedTitle = NSAttributedString($1) }
    }

    @preconcurrency
    @MainActor
    public var isRefreshing: Binding<Bool> {
        Binding(self) { refreshControl, isRefreshing in
            if isRefreshing {
                refreshControl.beginRefreshing()
            } else {
                refreshControl.endRefreshing()
            }
        }
    }
}
