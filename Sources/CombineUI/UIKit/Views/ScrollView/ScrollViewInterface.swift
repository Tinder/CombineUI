//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

public typealias ScrollViewWillEndDragging = (velocity: CGPoint, targetContentOffset: CGPoint)
public typealias ScrollViewDidEndZooming = (view: UIView?, scale: CGFloat)

@preconcurrency
@MainActor
public struct ScrollViewInterface<T: UIScrollView> {

    // MARK: - UIScrollViewDelegate

    public private(set) lazy var didScroll: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .didScroll
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var didZoom: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .didZoom
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var willBeginDragging: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .willBeginDragging
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var willEndDragging: AnyPublisher<ScrollViewWillEndDragging, Never> = { @MainActor in
        delegate
            .willEndDragging
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var didEndDragging: AnyPublisher<Bool, Never> = { @MainActor in
        delegate
            .didEndDragging
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var willBeginDecelerating: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .willBeginDecelerating
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var didEndDecelerating: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .didEndDecelerating
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var didEndScrollingAnimation: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .didEndScrollingAnimation
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var willBeginZooming: AnyPublisher<UIView?, Never> = { @MainActor in
        delegate
            .willBeginZooming
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var didEndZooming: AnyPublisher<ScrollViewDidEndZooming, Never> = { @MainActor in
        delegate
            .didEndZooming
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var didScrollToTop: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .didScrollToTop
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var didChangeAdjustedContentInset: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .didChangeAdjustedContentInset
            .share()
            .eraseToAnyPublisher()
    }()

    private let delegate: ScrollViewDelegate = .init()

    internal init(scrollView: T) {
        scrollView.delegate = delegate
    }
}
