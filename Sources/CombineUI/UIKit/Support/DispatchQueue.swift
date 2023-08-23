//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Foundation

extension DispatchQueue {

    private enum MainQueue {

        static let key: DispatchSpecificKey<Void> = {
            let key: DispatchSpecificKey<Void> = .init()
            DispatchQueue.main.setSpecific(key: key, value: ())
            return key
        }()
    }

    internal static var isMainQueue: Bool {
        DispatchQueue.getSpecific(key: MainQueue.key) != nil
    }
}
