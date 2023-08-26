//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

public typealias ScrollViewWillEndDragging = (velocity: CGPoint, targetContentOffset: CGPoint)
public typealias ScrollViewDidEndZooming = (view: UIView?, scale: CGFloat)

@MainActor
public struct ScrollViewInterface<T: UIScrollView> {

    // MARK: - UIScrollViewDelegate

    public private(set) lazy var didScroll: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.didScroll)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var didZoom: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.didZoom)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var willBeginDragging: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.willBeginDragging)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var willEndDragging: AnyPublisher<ScrollViewWillEndDragging, Never> = delegate
        .delegatePublisher(for: \.willEndDragging)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var didEndDragging: AnyPublisher<Bool, Never> = delegate
        .delegatePublisher(for: \.didEndDragging)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var willBeginDecelerating: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.willBeginDecelerating)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var didEndDecelerating: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.didEndDecelerating)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var didEndScrollingAnimation: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.didEndScrollingAnimation)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var willBeginZooming: AnyPublisher<UIView?, Never> = delegate
        .delegatePublisher(for: \.willBeginZooming)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var didEndZooming: AnyPublisher<ScrollViewDidEndZooming, Never> = delegate
        .delegatePublisher(for: \.didEndZooming)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var didScrollToTop: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.didScrollToTop)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var didChangeAdjustedContentInset: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.didChangeAdjustedContentInset)
        .share()
        .eraseToAnyPublisher()

    private let delegate: ScrollViewDelegate = .init()

    internal init(scrollView: T) {
        scrollView.delegate = delegate
    }
}
