//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import UIKit

extension Bindable where Target: UIImageView {

    @preconcurrency
    @MainActor
    public var image: Binding<UIImage?> {
        Binding(self, for: \.image)
    }

    @preconcurrency
    @MainActor
    public var highlightedImage: Binding<UIImage?> {
        Binding(self, for: \.highlightedImage)
    }

    @preconcurrency
    @MainActor
    public var isHighlighted: Binding<Bool> {
        Binding(self, for: \.isHighlighted)
    }
}
