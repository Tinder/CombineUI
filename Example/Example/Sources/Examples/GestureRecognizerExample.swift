//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import UIKit

class GestureRecognizerExample: UIViewController {

    @GestureRecognizer var pinch: UIPinchGestureRecognizer = .init()
    @GestureRecognizer var tap: UITapGestureRecognizer = .init()

    let tintedView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .tintColor
        return view
    }()

    let label: UILabel = {
        let label: UILabel = .init()
        label.text = "Pinch Here"
        label.textColor = .white
        return label
    }()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [tintedView, label].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            tintedView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            tintedView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            tintedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tintedView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: tintedView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: tintedView.centerYAnchor, constant: -10)
        ])
        $pinch
            .attaching(to: tintedView)
            .sink { [weak self] in
                guard let self else { return }
                transformTintedView(with: $0.scale)
                print(Date(), "$pinch.attaching(to:)", "...", $0.scale, $0.state.stringValue)
            }
            .store(in: &cancellables)
        tap
            .publisher(attachingTo: tintedView)
            .sink { print(Date(), "tap.publisher(attachingTo:)", "...", $0.state.stringValue) }
            .store(in: &cancellables)
    }

    func transformTintedView(with scale: CGFloat) {
        let scale: CGFloat = min(max(0.4, scale), 1.2)
        tintedView.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
}

extension UIGestureRecognizer.State {

    var stringValue: String {
        let stringValue: String
        switch self {
        case .possible:
            stringValue = "possible"
        case .began:
            stringValue = "began"
        case .changed:
            stringValue = "changed"
        case .ended:
            stringValue = "ended"
        case .cancelled:
            stringValue = "cancelled"
        case .failed:
            stringValue = "failed"
        @unknown default:
            return "UNKNOWN"
        }
        return self == .recognized ? "\(stringValue) (recognized)" : stringValue
    }
}
