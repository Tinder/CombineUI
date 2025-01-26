//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@MainActor
internal final class ScrollViewDelegate: NSObject, UIScrollViewDelegate {

    // swiftlint:disable private_subject

    internal let didScroll: PassthroughSubject<Void, Never> = .init()
    internal let didZoom: PassthroughSubject<Void, Never> = .init()
    internal let willBeginDragging: PassthroughSubject<Void, Never> = .init()
    internal let willEndDragging: PassthroughSubject<ScrollViewWillEndDragging, Never> = .init()
    internal let didEndDragging: PassthroughSubject<Bool, Never> = .init()
    internal let willBeginDecelerating: PassthroughSubject<Void, Never> = .init()
    internal let didEndDecelerating: PassthroughSubject<Void, Never> = .init()
    internal let didEndScrollingAnimation: PassthroughSubject<Void, Never> = .init()
    internal let willBeginZooming: PassthroughSubject<UIView?, Never> = .init()
    internal let didEndZooming: PassthroughSubject<ScrollViewDidEndZooming, Never> = .init()
    internal let didScrollToTop: PassthroughSubject<Void, Never> = .init()
    internal let didChangeAdjustedContentInset: PassthroughSubject<Void, Never> = .init()

    // swiftlint:enable private_subject

    // MARK: - UIScrollViewDelegate

    // swiftlint:disable unused_parameter

    internal func scrollViewDidScroll(
        _ scrollView: UIScrollView
    ) {
        didScroll.send()
    }

    internal func scrollViewDidZoom(
        _ scrollView: UIScrollView
    ) {
        didZoom.send()
    }

    internal func scrollViewWillBeginDragging(
        _ scrollView: UIScrollView
    ) {
        willBeginDragging.send()
    }

    internal func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let targetContentOffsetX: CGFloat = targetContentOffset.pointee.x
        let targetContentOffsetY: CGFloat = targetContentOffset.pointee.y
        willEndDragging.send((velocity, CGPoint(x: targetContentOffsetX, y: targetContentOffsetY)))
    }

    internal func scrollViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool
    ) {
        didEndDragging.send(decelerate)
    }

    internal func scrollViewWillBeginDecelerating(
        _ scrollView: UIScrollView
    ) {
        willBeginDecelerating.send()
    }

    internal func scrollViewDidEndDecelerating(
        _ scrollView: UIScrollView
    ) {
        didEndDecelerating.send()
    }

    internal func scrollViewDidEndScrollingAnimation(
        _ scrollView: UIScrollView
    ) {
        didEndScrollingAnimation.send()
    }

    internal func scrollViewWillBeginZooming(
        _ scrollView: UIScrollView,
        with view: UIView?
    ) {
        willBeginZooming.send(view)
    }

    internal func scrollViewDidEndZooming(
        _ scrollView: UIScrollView,
        with view: UIView?,
        atScale scale: CGFloat
    ) {
        didEndZooming.send((view, scale))
    }

    internal func scrollViewDidScrollToTop(
        _ scrollView: UIScrollView
    ) {
        didScrollToTop.send()
    }

    internal func scrollViewDidChangeAdjustedContentInset(
        _ scrollView: UIScrollView
    ) {
        didChangeAdjustedContentInset.send()
    }

    // swiftlint:enable unused_parameter
}
