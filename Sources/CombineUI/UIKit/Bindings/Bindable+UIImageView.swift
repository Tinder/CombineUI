//
//  Copyright © 2024 Tinder (Match Group, LLC)
//

import Combine
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
