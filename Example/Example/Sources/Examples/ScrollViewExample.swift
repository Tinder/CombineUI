//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import Combine
import CombineUI
import UIKit

class ScrollViewExample: UIViewController {

    @ScrollView var scrollView: UIScrollView = .init()

    let contentView: UIView = .init()

    let topLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "Scroll Down"
        return label
    }()

    let bottomLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "Scroll Up"
        return label
    }()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [scrollView, contentView, topLabel, bottomLabel].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topLabel)
        contentView.addSubview(bottomLabel)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2),
            topLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            topLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 150),
            bottomLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bottomLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -150)
        ])
        $scrollView
            .didScroll
            .sink { print(Date(), "$scrollView.didScroll") }
            .store(in: &cancellables)
        $scrollView
            .didZoom
            .sink { print(Date(), "$scrollView.didZoom") }
            .store(in: &cancellables)
        $scrollView
            .willBeginDragging
            .sink { print(Date(), "$scrollView.willBeginDragging") }
            .store(in: &cancellables)
        $scrollView
            .willEndDragging
            .sink { print(Date(), "$scrollView.willEndDragging", "...", $0) }
            .store(in: &cancellables)
        $scrollView
            .didEndDragging
            .sink { print(Date(), "$scrollView.didEndDragging", "...", $0) }
            .store(in: &cancellables)
        $scrollView
            .willBeginDecelerating
            .sink { print(Date(), "$scrollView.willBeginDecelerating") }
            .store(in: &cancellables)
        $scrollView
            .didEndDecelerating
            .sink { print(Date(), "$scrollView.didEndDecelerating") }
            .store(in: &cancellables)
        $scrollView
            .didEndScrollingAnimation
            .sink { print(Date(), "$scrollView.didEndScrollingAnimation") }
            .store(in: &cancellables)
        $scrollView
            .willBeginZooming
            .sink { print(Date(), "$scrollView.willBeginZooming", "...", $0 ?? "<nil>") }
            .store(in: &cancellables)
        $scrollView
            .didEndZooming
            .sink { print(Date(), "$scrollView.didEndZooming", "...", $0) }
            .store(in: &cancellables)
        $scrollView
            .didScrollToTop
            .sink { print(Date(), "$scrollView.didScrollToTop") }
            .store(in: &cancellables)
        $scrollView
            .didChangeAdjustedContentInset
            .sink { print(Date(), "$scrollView.didChangeAdjustedContentInset") }
            .store(in: &cancellables)
    }
}
