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

class PageControlExample: UIViewController {

    @PageControl var pageControl: UIPageControl = {
        let pageControl: UIPageControl = .init()
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .placeholderText
        pageControl.currentPageIndicatorTintColor = .tintColor
        return pageControl
    }()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [pageControl].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10)
        ])
        $pageControl
            .sink { print(Date(), "$pageControl", "...", $0) }
            .store(in: &cancellables)
        pageControl
            .currentPagePublisher()
            .sink { print(Date(), "pageControl.currentPagePublisher()", "...", $0) }
            .store(in: &cancellables)
    }
}
