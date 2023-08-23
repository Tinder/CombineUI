//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import UIKit

class ViewControllerExample: UIViewController {

    class SheetViewController: UIViewController {

        let label: UILabel = {
            let label: UILabel = .init()
            label.text = "Drag to Dimiss"
            return label
        }()

        var cancellables: Set<AnyCancellable> = .init()

        init() {
            super.init(nibName: nil, bundle: nil)
            modalPresentationStyle = .pageSheet
        }

        required init?(coder: NSCoder) {
            preconditionFailure("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            [label].forEach { subview in
                subview.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(subview)
            }
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10)
            ])
            let lifecycle = self
                .lifecyclePublisher()
                .share()
            lifecycle
                .sink { print(Date(), ">>>", "lifecyclePublisher()", "...", $0) }
                .store(in: &cancellables)
            lifecycle
                .isVisiblePublisher()
                .sink { print(Date(), ">>>", "isVisiblePublisher()", "...", $0) }
                .store(in: &cancellables)
        }
    }

    @ViewController var sheetViewController: SheetViewController = .init()

    @Button var button: UIButton = {
        let button: UIButton = .init()
        button.configuration = .filled()
        button.setTitle("Present Sheet", for: .normal)
        return button
    }()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [button].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10)
        ])
        $sheetViewController
            .isVisible
            .sink { print(Date(), "$sheetViewController.isVisible", "...", $0) }
            .store(in: &cancellables)
        $sheetViewController
            .viewWillAppear
            .sink { print(Date(), "$sheetViewController.viewWillAppear") }
            .store(in: &cancellables)
        $sheetViewController
            .viewDidAppear
            .sink { print(Date(), "$sheetViewController.viewDidAppear") }
            .store(in: &cancellables)
        $sheetViewController
            .viewWillDisappear
            .sink { print(Date(), "$sheetViewController.viewWillDisappear") }
            .store(in: &cancellables)
        $sheetViewController
            .viewDidDisappear
            .sink { print(Date(), "$sheetViewController.viewDidDisappear") }
            .store(in: &cancellables)
        let lifecycle = sheetViewController
            .lifecyclePublisher()
            .share()
        lifecycle
            .sink { print(Date(), "sheetViewController.lifecyclePublisher()", "...", $0) }
            .store(in: &cancellables)
        lifecycle
            .isVisiblePublisher()
            .sink { print(Date(), "sheetViewController.isVisiblePublisher()", "...", $0) }
            .store(in: &cancellables)
        $button
            .sink { [weak self] in
                guard let self else { return }
                present(sheetViewController, animated: true)
            }
            .store(in: &cancellables)
    }
}
