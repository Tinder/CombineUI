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

class SearchBarExample: UIViewController {

    @SearchBar var searchBar: UISearchBar = {
        let searchBar: UISearchBar = .init()
        searchBar.placeholder = "Search..."
        searchBar.showsCancelButton = true
        return searchBar
    }()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [searchBar].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        $searchBar
            .textDidBeginEditing
            .sink { print(Date(), "$searchBar.textDidBeginEditing") }
            .store(in: &cancellables)
        $searchBar
            .textDidEndEditing
            .sink { print(Date(), "$searchBar.textDidEndEditing") }
            .store(in: &cancellables)
        $searchBar
            .textDidChange
            .sink { print(Date(), "$searchBar.textDidChange", "...", $0) }
            .store(in: &cancellables)
        $searchBar
            .searchButtonClicked
            .sink { print(Date(), "$searchBar.searchButtonClicked") }
            .store(in: &cancellables)
        $searchBar
            .bookmarkButtonClicked
            .sink { print(Date(), "$searchBar.bookmarkButtonClicked") }
            .store(in: &cancellables)
        $searchBar
            .cancelButtonClicked
            .sink { print(Date(), "$searchBar.cancelButtonClicked") }
            .store(in: &cancellables)
        $searchBar
            .resultsListButtonClicked
            .sink { print(Date(), "$searchBar.resultsListButtonClicked") }
            .store(in: &cancellables)
        $searchBar
            .selectedScopeButtonIndexDidChange
            .sink { print(Date(), "$searchBar.selectedScopeButtonIndexDidChange", "...", $0) }
            .store(in: &cancellables)
        searchBar.becomeFirstResponder()
    }
}
