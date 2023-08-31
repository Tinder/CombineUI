//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import UIKit

@preconcurrency
@MainActor
public struct SearchBarInterface<T: UISearchBar> {

    // MARK: - UISearchBarDelegate

    public private(set) lazy var textDidBeginEditing: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.textDidBeginEditing)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var textDidEndEditing: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.textDidEndEditing)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var textDidChange: AnyPublisher<String, Never> = delegate
        .delegatePublisher(for: \.textDidChange)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var searchButtonClicked: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.searchButtonClicked)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var bookmarkButtonClicked: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.bookmarkButtonClicked)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var cancelButtonClicked: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.cancelButtonClicked)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var resultsListButtonClicked: AnyPublisher<Void, Never> = delegate
        .delegatePublisher(for: \.resultsListButtonClicked)
        .share()
        .eraseToAnyPublisher()

    public private(set) lazy var selectedScopeButtonIndexDidChange: AnyPublisher<Int, Never> = delegate
        .delegatePublisher(for: \.selectedScopeButtonIndexDidChange)
        .share()
        .eraseToAnyPublisher()

    private let delegate: SearchBarDelegate = .init()

    internal init(searchBar: T) {
        searchBar.delegate = delegate
    }
}
