//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import Nimble
import XCTest

@MainActor
final class SearchBarTests: XCTestCase {

    private final class TestViewController: UIViewController {

        @SearchBar var searchBar: UISearchBar = .init()
    }

    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = Set()
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    func testTextDidBeginEditing() {
        let viewController: TestViewController = .init()
        let searchBar: UISearchBar = viewController.searchBar
        var count: Int = 0
        viewController
            .$searchBar
            .textDidBeginEditing
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        searchBar.delegate?.searchBarTextDidBeginEditing?(searchBar)
        expect(count) == 1
        searchBar.delegate?.searchBarTextDidBeginEditing?(searchBar)
        expect(count) == 2
    }

    func testTextDidEndEditing() {
        let viewController: TestViewController = .init()
        let searchBar: UISearchBar = viewController.searchBar
        var count: Int = 0
        viewController
            .$searchBar
            .textDidEndEditing
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        searchBar.delegate?.searchBarTextDidEndEditing?(searchBar)
        expect(count) == 1
        searchBar.delegate?.searchBarTextDidEndEditing?(searchBar)
        expect(count) == 2
    }

    func testTextDidChange() {
        let viewController: TestViewController = .init()
        let searchBar: UISearchBar = viewController.searchBar
        var receivedValues: [String] = []
        viewController
            .$searchBar
            .textDidChange
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(receivedValues.isEmpty) == true
        searchBar.delegate?.searchBar?(searchBar, textDidChange: "Hello")
        expect(receivedValues) == ["Hello"]
        searchBar.delegate?.searchBar?(searchBar, textDidChange: "World")
        expect(receivedValues) == ["Hello", "World"]
    }

    func testSearchButtonClicked() {
        let viewController: TestViewController = .init()
        let searchBar: UISearchBar = viewController.searchBar
        var count: Int = 0
        viewController
            .$searchBar
            .searchButtonClicked
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)
        expect(count) == 1
        searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)
        expect(count) == 2
    }

    func testBookmarkButtonClicked() {
        let viewController: TestViewController = .init()
        let searchBar: UISearchBar = viewController.searchBar
        var count: Int = 0
        viewController
            .$searchBar
            .bookmarkButtonClicked
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        searchBar.delegate?.searchBarBookmarkButtonClicked?(searchBar)
        expect(count) == 1
        searchBar.delegate?.searchBarBookmarkButtonClicked?(searchBar)
        expect(count) == 2
    }

    func testCancelButtonClicked() {
        let viewController: TestViewController = .init()
        let searchBar: UISearchBar = viewController.searchBar
        var count: Int = 0
        viewController
            .$searchBar
            .cancelButtonClicked
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        searchBar.delegate?.searchBarCancelButtonClicked?(searchBar)
        expect(count) == 1
        searchBar.delegate?.searchBarCancelButtonClicked?(searchBar)
        expect(count) == 2
    }

    func testResultsListButtonClicked() {
        let viewController: TestViewController = .init()
        let searchBar: UISearchBar = viewController.searchBar
        var count: Int = 0
        viewController
            .$searchBar
            .resultsListButtonClicked
            .sink { count += 1 }
            .store(in: &cancellables)
        expect(count) == 0
        searchBar.delegate?.searchBarResultsListButtonClicked?(searchBar)
        expect(count) == 1
        searchBar.delegate?.searchBarResultsListButtonClicked?(searchBar)
        expect(count) == 2
    }

    func testSelectedScopeButtonIndexDidChange() {
        let viewController: TestViewController = .init()
        let searchBar: UISearchBar = viewController.searchBar
        var receivedValues: [Int] = []
        viewController
            .$searchBar
            .selectedScopeButtonIndexDidChange
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        expect(receivedValues.isEmpty) == true
        searchBar.delegate?.searchBar?(searchBar, selectedScopeButtonIndexDidChange: 100)
        expect(receivedValues) == [100]
        searchBar.delegate?.searchBar?(searchBar, selectedScopeButtonIndexDidChange: 23)
        expect(receivedValues) == [100, 23]
    }
}
