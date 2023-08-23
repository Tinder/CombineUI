//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Combine
import CombineUI
import UIKit

class MenuViewController: UICollectionViewController {

    let examples: [(name: String, type: UIViewController.Type)] = [
        ("UIButton", ButtonExample.self),
        ("UIControl", ControlExample.self),
        ("UIDatePicker", DatePickerExample.self),
        ("UIGestureRecognizer", GestureRecognizerExample.self),
        ("UIPageControl", PageControlExample.self),
        ("UIProgressView", ProgressViewExample.self),
        ("UIRefreshControl", RefreshControlExample.self),
        ("UIScrollView", ScrollViewExample.self),
        ("UISearchBar", SearchBarExample.self),
        ("UISegmentedControl", SegmentedControlExample.self),
        ("UISlider", SliderExample.self),
        ("UIStepper", StepperExample.self),
        ("UISwitch", SwitchExample.self),
        ("UITextField", TextFieldExample.self),
        ("UIViewController", ViewControllerExample.self)
    ]

    init() {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        super.init(collectionViewLayout: layout)
        title = "CombineUI"
    }

    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: "example")
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        examples.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "example", for: indexPath)
        if let cell = cell as? UICollectionViewListCell {
            var content = cell.defaultContentConfiguration()
            content.text = examples[indexPath.row].name
            cell.contentConfiguration = content
            cell.accessories = [.disclosureIndicator(displayed: .always)]
        }
        return cell
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let example = examples[indexPath.row]
        let viewController = example.type.init()
        viewController.title = example.name
        navigationController?.pushViewController(viewController, animated: true)
    }
}
