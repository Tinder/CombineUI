//
//  All Contributions by Match Group
//
//  Copyright © 2025 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/CombineUI/blob/main/LICENSE for license information.
//

import Combine
import UIKit

@preconcurrency
@MainActor
public struct SearchBarInterface<T: UISearchBar> {

    // MARK: - UISearchBarDelegate

    public private(set) lazy var textDidBeginEditing: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .textDidBeginEditing
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var textDidEndEditing: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .textDidEndEditing
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var textDidChange: AnyPublisher<String, Never> = { @MainActor in
        delegate
            .textDidChange
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var searchButtonClicked: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .searchButtonClicked
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var bookmarkButtonClicked: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .bookmarkButtonClicked
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var cancelButtonClicked: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .cancelButtonClicked
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var resultsListButtonClicked: AnyPublisher<Void, Never> = { @MainActor in
        delegate
            .resultsListButtonClicked
            .share()
            .eraseToAnyPublisher()
    }()

    public private(set) lazy var selectedScopeButtonIndexDidChange: AnyPublisher<Int, Never> = { @MainActor in
        delegate
            .selectedScopeButtonIndexDidChange
            .share()
            .eraseToAnyPublisher()
    }()

    private let delegate: SearchBarDelegate = .init()

    internal init(searchBar: T) {
        searchBar.delegate = delegate
    }
}
