//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@MainActor
internal final class SearchBarDelegate: NSObject, UISearchBarDelegate {

    // swiftlint:disable private_subject

    internal let textDidBeginEditing: PassthroughSubject<Void, Never> = .init()
    internal let textDidEndEditing: PassthroughSubject<Void, Never> = .init()
    internal let textDidChange: PassthroughSubject<String, Never> = .init()
    internal let searchButtonClicked: PassthroughSubject<Void, Never> = .init()
    internal let bookmarkButtonClicked: PassthroughSubject<Void, Never> = .init()
    internal let cancelButtonClicked: PassthroughSubject<Void, Never> = .init()
    internal let resultsListButtonClicked: PassthroughSubject<Void, Never> = .init()
    internal let selectedScopeButtonIndexDidChange: PassthroughSubject<Int, Never> = .init()

    // swiftlint:enable private_subject

    // MARK: - UISearchBarDelegate

    // swiftlint:disable unused_parameter

    internal func searchBarTextDidBeginEditing(
        _ searchBar: UISearchBar
    ) {
        textDidBeginEditing.send()
    }

    internal func searchBarTextDidEndEditing(
        _ searchBar: UISearchBar
    ) {
        textDidEndEditing.send()
    }

    internal func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        textDidChange.send(searchText)
    }

    internal func searchBarSearchButtonClicked(
        _ searchBar: UISearchBar
    ) {
        searchButtonClicked.send()
    }

    internal func searchBarBookmarkButtonClicked(
        _ searchBar: UISearchBar
    ) {
        bookmarkButtonClicked.send()
    }

    internal func searchBarCancelButtonClicked(
        _ searchBar: UISearchBar
    ) {
        cancelButtonClicked.send()
    }

    internal func searchBarResultsListButtonClicked(
        _ searchBar: UISearchBar
    ) {
        resultsListButtonClicked.send()
    }

    internal func searchBar(
        _ searchBar: UISearchBar,
        selectedScopeButtonIndexDidChange selectedScope: Int
    ) {
        selectedScopeButtonIndexDidChange.send(selectedScope)
    }

    // swiftlint:enable unused_parameter
}
