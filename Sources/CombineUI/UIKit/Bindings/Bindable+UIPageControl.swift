//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

extension Bindable where Target: UIPageControl {

    @MainActor public var currentPage: Binding<Int> {
        Binding(self, for: \.currentPage)
    }
}
