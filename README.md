[![Swift](https://github.com/Tinder/CombineUI/actions/workflows/swift.yml/badge.svg?event=push)](https://github.com/Tinder/CombineUI/actions/workflows/swift.yml)

# CombineUI

Swift Property Wrappers and Combine Publishers for UI Gestures, Controls and Views

## Overview

CombineUI provides Swift property wrappers for select Apple types such as gestures, controls and views. These property wrappers project publishers for gesture recognition, control events, property changes and delegate callbacks.

Many types are also enhanced with Swift extensions providing publishers that may be used as an alternative to the property wrappers when needed.

UIKit is currently supported. CombineUI may support additional UI frameworks in the future.

## Code Examples

### `UIButton` Property Wrapper Example

```swift
@Button var button = UIButton()

button.setImage(UIImage(systemName: "heart"), for: .normal)

$button
    .sink { print("Tapped") }
    .store(in: &cancellables)
```

### `UIViewController` Extension Methods Example

```swift
let viewController = UIViewController()

let lifecycle = viewController
    .lifecyclePublisher()
    .share()

lifecycle
    .sink { print($0) } // .viewWillAppear | .viewDidAppear | .viewWillDisappear | .viewDidDisappear
    .store(in: &cancellables)

lifecycle
    .isVisiblePublisher()
    .sink { print($0) } // true | false
    .store(in: &cancellables)
```

### Comprehensive Examples

Additional examples are available within an Xcode project included in this repository. See the [example project README containing setup instructions](Example/) for guidance.

## Minimum Requirements

- iOS `14.0`
- Swift `5.8`

## Installation

**Swift Package Manager Dependency**

> Replace `<version>` with the desired minimum version.

```swift
.package(url: "https://github.com/Tinder/CombineUI.git", from: "<version>")
```

## API Documentation

- UIKit
  - [UIButton](#uibutton)
  - [UIControl](#uicontrol)
  - [UIDatePicker](#uidatepicker)
  - [UIGestureRecognizer](#uigesturerecognizer)
  - [UIPageControl](#uipagecontrol)
  - [UIProgressView](#uiprogressview)
  - [UIRefreshControl](#uirefreshcontrol)
  - [UIScrollView](#uiscrollview)
  - [UISearchBar](#uisearchbar)
  - [UISegmentedControl](#uisegmentedcontrol)
  - [UISlider](#uislider)
  - [UIStepper](#uistepper)
  - [UISwitch](#uiswitch)
  - [UITextField](#uitextfield)
  - [UIViewController](#uiviewcontroller)
- [Caveats](#caveats)

## `UIButton`

| Event |
| :-- |
| `.primaryActionTriggered` |

### Property Wrapper

```swift
@Button // Projected Value: AnyPublisher<Void, Never>
```

### Extension Method

```swift
func tapPublisher() -> AnyPublisher<Void, Never>
```

### Code Examples

Property Wrapper

```swift
@Button var button = UIButton()

button.setImage(UIImage(systemName: "heart"), for: .normal)

$button
    .sink { print("Tapped") }
    .store(in: &cancellables)
```

Extension Method

```swift
let button = UIButton()

button.setImage(UIImage(systemName: "heart"), for: .normal)

button
    .tapPublisher()
    .sink { print("Tapped") }
    .store(in: &cancellables)
```

## `UIControl`

### Property Wrapper

```swift
@Control // Projected Value: ControlInterface
```

`ControlInterface`

```swift
var touchDown: AnyPublisher<Void, Never>
var touchDownRepeat: AnyPublisher<Void, Never>
var touchDragInside: AnyPublisher<Void, Never>
var touchDragOutside: AnyPublisher<Void, Never>
var touchDragEnter: AnyPublisher<Void, Never>
var touchDragExit: AnyPublisher<Void, Never>
var touchUpInside: AnyPublisher<Void, Never>
var touchUpOutside: AnyPublisher<Void, Never>
var touchCancel: AnyPublisher<Void, Never>
var valueChanged: AnyPublisher<Void, Never>
var menuActionTriggered: AnyPublisher<Void, Never>
var primaryActionTriggered: AnyPublisher<Void, Never>
var editingDidBegin: AnyPublisher<Void, Never>
var editingChanged: AnyPublisher<Void, Never>
var editingDidEnd: AnyPublisher<Void, Never>
var editingDidEndOnExit: AnyPublisher<Void, Never>
```

### Extension Method

```swift
func publisher(for controlEvents: UIControl.Event) -> AnyPublisher<UIControl.Event, Never>
```

### Supported Types

As every CombineUI property wrapper may be used with subclasses of its supported wrapped type, this property wrapper is compatible with `UIControl` subclasses, including (but not limited to) the following:

  - `UIButton`
  - `UIDatePicker`
  - `UIPageControl`
  - `UIRefreshControl`
  - `UISegmentedControl`
  - `UISlider`
  - `UIStepper`
  - `UISwitch`
  - `UITextField`

### Code Examples

Property Wrapper

```swift
@Control var control = UIButton()

control.setImage(UIImage(systemName: "heart"), for: .normal)

$control
    .primaryActionTriggered
    .sink { print("Triggered") }
    .store(in: &cancellables)
```

Extension Method

```swift
let control = UIButton()

control.setImage(UIImage(systemName: "heart"), for: .normal)

control
    .publisher(for: .primaryActionTriggered)
    .sink { print($0.contains(.primaryActionTriggered)) } // true
    .store(in: &cancellables)
```

### Notes

- Use the `@Control` property wrapper only when publishers for the `UIControl.Event` types are needed, otherwise the type specific property wrappers should be preferred.

## `UIDatePicker`

| Property | Event |
| :-- | :-- |
| `.date` | `.valueChanged` |
| `.countDownDuration` | `.valueChanged` |

### Property Wrapper

```swift
@DatePicker(mode: UIDatePicker.Mode = .dateAndTime) // Projected Value: DatePickerInterface
```

`DatePickerInterface`

```swift
var date: AnyPublisher<Date, Never>
var countDownDuration: AnyPublisher<TimeInterval, Never>
```

### Extension Methods

```swift
func datePublisher() -> AnyPublisher<Date, Never>
func countDownDurationPublisher() -> AnyPublisher<TimeInterval, Never>
```

### Code Examples

Property Wrapper

```swift
@DatePicker var datePicker = UIDatePicker()

$datePicker
    .date
    .sink { date in }
    .store(in: &cancellables)

$datePicker
    .countDownDuration
    .sink { countDownDuration in }
    .store(in: &cancellables)
```

Extension Methods

```swift
let datePicker = UIDatePicker()

datePicker
    .datePublisher()
    .sink { date in }
    .store(in: &cancellables)

datePicker
    .countDownDurationPublisher()
    .sink { countDownDuration in }
    .store(in: &cancellables)
```

## `UIGestureRecognizer`

### Property Wrapper

```swift
@GestureRecognizer // Projected Value: GestureRecognizerInterface
```

`GestureRecognizerInterface`

```swift
func attaching(to view: UIView) -> AnyPublisher<UIGestureRecognizer, Never>
```

### Extension Method

```swift
func publisher(attachingTo view: UIView) -> AnyPublisher<UIGestureRecognizer, Never>
```

### Code Examples

Property Wrapper

```swift
@GestureRecognizer var swipe = UISwipeGestureRecognizer()

$swipe
    .attaching(to: view)
    .sink { swipe in }
    .store(in: &cancellables)
```

Extension Method

```swift
let swipe = UISwipeGestureRecognizer()

swipe
    .publisher(attachingTo: view)
    .sink { swipe in }
    .store(in: &cancellables)
```

### Notes

- The gesture recognizer will be added to the provided view automatically.

## `UIPageControl`

| Property | Event |
| :-- | :-- |
| `.currentPage` | `.valueChanged` |

### Property Wrapper

```swift
@PageControl // Projected Value: AnyPublisher<Int, Never>
```

### Extension Method

```swift
func currentPagePublisher() -> AnyPublisher<Int, Never>
```

### Code Examples

Property Wrapper

```swift
@PageControl var pageControl = UIPageControl()

$pageControl
    .sink { currentPage in }
    .store(in: &cancellables)
```

Extension Method

```swift
let pageControl = UIPageControl()

pageControl
    .currentPagePublisher()
    .sink { currentPage in }
    .store(in: &cancellables)
```

## `UIProgressView`

| Property |
| :-- |
| `.progress` |

### Property Wrapper

```swift
@ProgressView // Projected Value: AnyPublisher<Float, Never>
```

### Extension Method

```swift
func progressPublisher() -> AnyPublisher<Float, Never>
```

### Code Examples

Property Wrapper

```swift
@ProgressView var progressView = UIProgressView()

$progressView
    .sink { progress in }
    .store(in: &cancellables)
```

Extension Method

```swift
let progressView = UIProgressView()

progressView
    .progressPublisher()
    .sink { progress in }
    .store(in: &cancellables)
```

### Notes

- Due to `UIProgressView` behavior, only non-animated progress is supported unless monkey-patched, for example:

```swift
class ProgressView: UIProgressView {

    override func setProgress(_ progress: Float, animated: Bool) {
        willChangeValue(for: \.progress)
        super.setProgress(progress, animated: animated)
        didChangeValue(for: \.progress)
    }
}
```

## `UIRefreshControl`

| Property | Event | Value |
| :-- | :-- | :-- |
| `.isRefreshing` | `.valueChanged` | `true` |

### Property Wrapper

```swift
@RefreshControl // Projected Value: AnyPublisher<Void, Never>
```

### Extension Method

```swift
func refreshPublisher() -> AnyPublisher<Void, Never>
```

### Code Examples

Property Wrapper

```swift
@RefreshControl var refreshControl = UIRefreshControl()

$refreshControl
    .sink { print("Refreshing") }
    .store(in: &cancellables)
```

Extension Method

```swift
let refreshControl = UIRefreshControl()

refreshControl
    .refreshPublisher()
    .sink { print("Refreshing") }
    .store(in: &cancellables)
```

## `UIScrollView`

| Protocol |
| :-- |
| `UIScrollViewDelegate` |

### Property Wrapper

```swift
@ScrollView // Projected Value: ScrollViewInterface
```

`ScrollViewInterface`

```swift
var didScroll: AnyPublisher<Void, Never>
var didZoom: AnyPublisher<Void, Never>
var willBeginDragging: AnyPublisher<Void, Never>
var willEndDragging: AnyPublisher<ScrollViewWillEndDragging, Never>
var didEndDragging: AnyPublisher<Bool, Never>
var willBeginDecelerating: AnyPublisher<Void, Never>
var didEndDecelerating: AnyPublisher<Void, Never>
var didEndScrollingAnimation: AnyPublisher<Void, Never>
var willBeginZooming: AnyPublisher<UIView?, Never>
var didEndZooming: AnyPublisher<ScrollViewDidEndZooming, Never>
var didScrollToTop: AnyPublisher<Void, Never>
var didChangeAdjustedContentInset: AnyPublisher<Void, Never>
```

### Code Example

```swift
@ScrollView var scrollView = UIScrollView()

$scrollView
    .didScroll
    .sink { print("Scrolling") }
    .store(in: &cancellables)
```

## `UISearchBar`

| Protocol |
| :-- |
| `UISearchBarDelegate` |

### Property Wrapper

```swift
@SearchBar // Projected Value: SearchBarInterface
```

`SearchBarInterface`

```swift
var textDidBeginEditing: AnyPublisher<Void, Never>
var textDidEndEditing: AnyPublisher<Void, Never>
var textDidChange: AnyPublisher<String, Never>
var searchButtonClicked: AnyPublisher<Void, Never>
var bookmarkButtonClicked: AnyPublisher<Void, Never>
var cancelButtonClicked: AnyPublisher<Void, Never>
var resultsListButtonClicked: AnyPublisher<Void, Never>
var selectedScopeButtonIndexDidChange: AnyPublisher<Int, Never>
```

### Code Example

```swift
@SearchBar var searchBar = UISearchBar()

$searchBar
    .textDidChange
    .sink { text in }
    .store(in: &cancellables)
```

## `UISegmentedControl`

| Property | Event |
| :-- | :-- |
| `.selectedSegmentIndex` | `.valueChanged` |

### Property Wrapper

```swift
@SegmentedControl // Projected Value: AnyPublisher<Int, Never>
```

### Extension Method

```swift
func selectedSegmentIndexPublisher() -> AnyPublisher<Int, Never>
```

### Code Examples

Property Wrapper

```swift
@SegmentedControl var segmentedControl = UISegmentedControl(items: items)

$segmentedControl
    .sink { selectedSegmentIndex in }
    .store(in: &cancellables)
```

Extension Method

```swift
let segmentedControl = UISegmentedControl(items: items)

segmentedControl
    .selectedSegmentIndexPublisher()
    .sink { selectedSegmentIndex in }
    .store(in: &cancellables)
```

## `UISlider`

| Property | Event |
| :-- | :-- |
| `.value` | `.valueChanged` |

### Property Wrapper

```swift
@Slider // Projected Value: AnyPublisher<Float, Never>
```

### Extension Method

```swift
func valuePublisher() -> AnyPublisher<Float, Never>
```

### Code Examples

Property Wrapper

```swift
@Slider var slider = UISlider()

$slider
    .sink { value in }
    .store(in: &cancellables)
```

Extension Method

```swift
let slider = UISlider()

slider
    .valuePublisher()
    .sink { value in }
    .store(in: &cancellables)
```

## `UIStepper`

| Property | Event |
| :-- | :-- |
| `.value` | `.valueChanged` |

### Property Wrapper

```swift
@Stepper // Projected Value: AnyPublisher<Double, Never>
```

### Extension Method

```swift
func valuePublisher() -> AnyPublisher<Double, Never>
```

### Code Examples

Property Wrapper

```swift
@Stepper var stepper = UIStepper()

$stepper
    .sink { value in }
    .store(in: &cancellables)
```

Extension Method

```swift
let stepper = UIStepper()

stepper
    .valuePublisher()
    .sink { value in }
    .store(in: &cancellables)
```

## `UISwitch`

| Property | Event |
| :-- | :-- |
| `.isOn` | `.valueChanged` |

### Property Wrapper

```swift
@Switch // Projected Value: AnyPublisher<Bool, Never>
```

### Extension Method

```swift
func isOnPublisher() -> AnyPublisher<Bool, Never>
```

### Code Examples

Property Wrapper

```swift
@Switch var `switch` = UISwitch()

$switch
    .sink { isOn in }
    .store(in: &cancellables)
```

Extension Method

```swift
let `switch` = UISwitch()

`switch`
    .isOnPublisher()
    .sink { isOn in }
    .store(in: &cancellables)
```

## `UITextField`

| Property | Events |
| :-- | :-- |
| `.text` | `.allEditingEvents` |
| `.attributedText` | `.allEditingEvents` |

| Protocol |
| :-- |
| `UITextFieldDelegate` |

### Property Wrapper

```swift
@TextField // Projected Value: TextFieldInterface
```

`TextFieldInterface`

```swift
// Properties

var text: AnyPublisher<String, Never>
var attributedText: AnyPublisher<NSAttributedString, Never>

// UITextFieldDelegate

var didBeginEditing: AnyPublisher<Void, Never>
var didEndEditing: AnyPublisher<Void, Never>
var didChangeSelection: AnyPublisher<Void, Never>
```

### Extension Methods

```swift
func textPublisher() -> AnyPublisher<String, Never>

@available(iOS 15, *)
func attributedTextPublisher() -> AnyPublisher<NSAttributedString, Never>
```

### Code Examples

Property Wrapper

```swift
@TextField var textField = UITextField()

$textField
    .text
    .sink { text in }
    .store(in: &cancellables)

$textField
    .attributedText
    .sink { attributedText in }
    .store(in: &cancellables)

$textField
    .didChangeSelection
    .sink { print("Selecting") }
    .store(in: &cancellables)
```

Extension Methods

```swift
let textField = UITextField()

textField
    .textPublisher()
    .sink { text in }
    .store(in: &cancellables)

textField
    .attributedTextPublisher()
    .sink { attributedText in }
    .store(in: &cancellables)
```

## `UIViewController`

### Property Wrapper

```swift
@ViewController // Projected Value: ViewControllerInterface
```

`ViewControllerInterface`

```swift
var isVisible: AnyPublisher<Bool, Never>
var viewWillAppear: AnyPublisher<Void, Never>
var viewDidAppear: AnyPublisher<Void, Never>
var viewWillDisappear: AnyPublisher<Void, Never>
var viewDidDisappear: AnyPublisher<Void, Never>
```

### Extension Method

```swift
func lifecyclePublisher() -> AnyPublisher<ViewControllerLifecycleEvent, Never>
```

### Publisher Extension

```swift
func isVisiblePublisher() -> AnyPublisher<Bool, Failure> where Output == ViewControllerLifecycleEvent
```

### Code Examples

Property Wrapper

```swift
@ViewController var viewController = UIViewController()

$viewController
    .isVisible
    .sink { isVisible in }
    .store(in: &cancellables)

$viewController
    .viewWillAppear
    .sink { print("Appearing") }
    .store(in: &cancellables)

$viewController
    .viewDidAppear
    .sink { print("Appeared") }
    .store(in: &cancellables)

$viewController
    .viewWillDisappear
    .sink { print("Disappearing") }
    .store(in: &cancellables)

$viewController
    .viewDidDisappear
    .sink { print("Disappeared") }
    .store(in: &cancellables)
```

Extension Methods

```swift
let viewController = UIViewController()

let lifecycle = viewController
    .lifecyclePublisher()
    .share()

lifecycle
    .sink { event in }
    .store(in: &cancellables)

lifecycle
    .isVisiblePublisher()
    .sink { isVisible in }
    .store(in: &cancellables)
```

### Notes

- Every subscription adds a helper view (of zero size) to the view hierarchy using view controller containment, therefore consider [sharing the subscription](https://developer.apple.com/documentation/combine/publisher/share()) when there are multiple subscribers (as demonstrated in the example above).

- In stark contrast to the other property wrappers, the `@ViewController` property wrapper is considered to be less useful than the extension methods. This is because the extension methods may be used within a view controller instance to subscribe to its own lifecycle events, for example:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    lifecyclePublisher()
        .isVisiblePublisher()
        .sink { isVisible in }
        .store(in: &cancellables)
}
```

## Caveats

### Delegation

CombineUI provides publishers for common delegate protocol methods, however due to the nature of publishers, delegate methods that have return values are not available as publishers. Furthermore, the delegate method publishers provided by CombineUI are available as a convenience only. For complex setups, or even when more than just a few delegate methods are required, it is recommended to use an actual delegate class instance.

Note too that setting a delegate property will disable the delegate publisher(s). This means it is not possible to use an actual delegate class instance along with the delegate publishers. Therefore select one pattern or the other for each specific use case.
