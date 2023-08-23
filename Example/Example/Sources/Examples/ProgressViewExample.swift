//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import UIKit

class ProgressViewExample: UIViewController {

    class MonkeyPatchedProgressView: UIProgressView {

        override func setProgress(_ progress: Float, animated: Bool) {
            willChangeValue(for: \.progress)
            super.setProgress(progress, animated: animated)
            didChangeValue(for: \.progress)
        }
    }

    @ProgressView var progressView: MonkeyPatchedProgressView = .init()

    var cancellables: Set<AnyCancellable> = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        [progressView].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            progressView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10)
        ])
        $progressView
            .sink { print(Date(), "$progressView", "...", $0) }
            .store(in: &cancellables)
        progressView
            .progressPublisher()
            .sink { print(Date(), "progressView.progressPublisher()", "...", $0) }
            .store(in: &cancellables)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        simulateProgress()
    }

    func simulateProgress() {
        progressView.setProgress(0.5, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak progressView] in
            progressView?.setProgress(1, animated: true)
        }
    }
}
