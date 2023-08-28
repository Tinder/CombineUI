//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UIRefreshControl {

    @MainActor public var isRefreshing: Binding<Bool> {
        Binding(self) { refreshControl, isRefreshing in
            if isRefreshing {
                refreshControl.beginRefreshing()
            } else {
                refreshControl.endRefreshing()
            }
        }
    }
}
