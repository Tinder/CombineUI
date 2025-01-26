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

class RefreshControlExample: UIViewController {

    @RefreshControl var refreshControl: UIRefreshControl = .init()

    let contentView: UIView = .init()

    let label: UILabel = {
        let label: UILabel = .init()
        label.text = "Pull to Refresh"
        return label
    }()

    var cancellables: Set<AnyCancellable> = .init()

    override func loadView() {
        let scrollView = UIScrollView()
        scrollView.refreshControl = refreshControl
        view = scrollView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [contentView, label].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        view.addSubview(contentView)
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 200),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 150)
        ])
        $refreshControl
            .sink { [weak self] in
                guard let self else { return }
                simulateRefresh()
                print(Date(), "$refreshControl")
            }
            .store(in: &cancellables)
        refreshControl
            .refreshPublisher()
            .sink { print(Date(), "refreshControl.refreshPublisher()") }
            .store(in: &cancellables)
    }

    func simulateRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak refreshControl] in
            refreshControl?.endRefreshing()
        }
    }
}
