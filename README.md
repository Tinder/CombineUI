[![Swift](https://github.com/Tinder/CombineUI/actions/workflows/swift.yml/badge.svg?event=push)](https://github.com/Tinder/CombineUI/actions/workflows/swift.yml)
&nbsp;
[![Bazel](https://github.com/Tinder/CombineUI/actions/workflows/bazel.yml/badge.svg?event=push)](https://github.com/Tinder/CombineUI/actions/workflows/bazel.yml)

# CombineUI

Swift Property Wrappers, Bindings and Combine Publishers for UI Gestures, Controls and Views

## Overview

CombineUI provides [Swift property wrappers](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Property-Wrappers) for select Apple types such as gestures, controls and views. These property wrappers [project](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Projecting-a-Value-From-a-Property-Wrapper) Combine publishers for gesture recognition, control events, property changes and delegate callbacks.

Example:

```swift
@Button var button = UIButton()
```

> The `$button` projected value is a publisher that will send when then button is tapped.

And bindings are provided for updating properties of select Apple views with values from Combine publishers.

- The property wrappers are for __*publishing*__ (i.e. to publish a value when a UI element changes).
- The bindings are for __*subscribing*__ (i.e. to update a UI element with a published value).

### Bindings Benefits

As compared to subscribing via Combine's' [`assign(to:on:)`](https://developer.apple.com/documentation/combine/publisher/assign(to:on:)) method, subscribing via CombineUI's bindings is preferable since they use `weak` references and can accept method arguments.

Example:

```swift
publisher.bind(to: button.bindable.title(for: .normal))
```

### Swift Extensions

Many types are also enhanced with Swift extensions providing Combine publishers that may be used as an alternative to the property wrappers when needed.

### Supported UI Frameworks

UIKit is currently supported. CombineUI may support additional UI frameworks in the future.

## Minimum Requirements

- iOS `14.0`
- Swift `5.8`

## Installation

**Swift Package Manager Dependency**

> Replace `<version>` with the desired minimum version.

```swift
.package(url: "https://github.com/Tinder/CombineUI.git", from: "<version>")
```

## Code Examples

All examples require this setup:

```swift
import Combine
import CombineUI
import UIKit

var cancellables: Set<AnyCancellable> = .init()
```

### Property Wrapper Example: `UIButton`

```swift
@Button var button = UIButton()

button.setImage(UIImage(systemName: "heart"), for: .normal)

$button
    .sink { print("Tapped") }
    .store(in: &cancellables)
```

### Binding Example: `UILabel`

```swift
let label = UILabel()
let subject = PassthroughSubject<String, Never>()

subject
    .bind(to: label.bindable.text)
    .store(in: &cancellables)

subject.send("Text")
```

### Extension Methods Example: `UIViewController` 

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

Additional examples are available within [an Xcode project included in this repository](Example/). See the [example project README containing setup instructions](Example/) for guidance.

<img src="Example/Examples.png" width="234" />

## Cheat Sheets

### UIKit

Property Wrappers

| | Property Wrapper | Projected Type |
| :-- | :-- | :-- |
| `UIButton` | `@Button` | `AnyPublisher<Void, Never>` <tr></tr> |
| `UIControl` | `@Control` | `ControlInterface` <tr></tr> |
| `UIDatePicker` | `@DatePicker` | `DatePickerInterface` <tr></tr> |
| `UIGestureRecognizer` | `@GestureRecognizer` | `GestureRecognizerInterface` <tr></tr> |
| `UIPageControl` | `@PageControl` | `AnyPublisher<Int, Never>` <tr></tr> |
| `UIProgressView` | `@ProgressView` | `AnyPublisher<Float, Never>` <tr></tr> |
| `UIRefreshControl` | `@RefreshControl` | `AnyPublisher<Void, Never>` <tr></tr> |
| `UIScrollView` | `@ScrollView` | `ScrollViewInterface` <tr></tr> |
| `UISearchBar` | `@SearchBar` | `SearchBarInterface` <tr></tr> |
| `UISegmentedControl` | `@SegmentedControl` | `AnyPublisher<Int, Never>` <tr></tr> |
| `UISlider` | `@Slider` | `AnyPublisher<Float, Never>` <tr></tr> |
| `UIStepper` | `@Stepper` | `AnyPublisher<Double, Never>` <tr></tr> |
| `UISwitch` | `@Switch` | `AnyPublisher<Bool, Never>` <tr></tr> |
| `UITextField` | `@TextField` | `TextFieldInterface` <tr></tr> |
| `UIViewController` | `@ViewController` | `ViewControllerInterface` <tr></tr> |

Bindings

<table>
  <thead>
      <tr>
        <th align="left"></th>
        <th align="left">Binding</th>
        <th align="left">Type</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="3"><code>UIButton</code></td>
      <td><code>.title(for: UIControl.State)</code></td>
      <td><code>String</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>.attributedTitle(for: UIControl.State)</code></td>
      <td><code>NSAttributedString</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIControl</code></td>
      <td><code>.isEnabled</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="5"><code>UIDatePicker</code></td>
      <td><code>.countDownDuration</code></td>
      <td><code>TimeInterval</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>.date</code></td>
      <td><code>Date</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>.date(animated: Bool)</code></td>
      <td><code>Date</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIGestureRecognizer</code></td>
      <td><code>.isEnabled</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="5"><code>UILabel</code></td>
      <td><code>.isEnabled</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>.text</code></td>
      <td><code>String</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>.attributedText</code></td>
      <td><code>NSAttributedString</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIPageControl</code></td>
      <td><code>.currentPage</code></td>
      <td><code>Int</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="3"><code>UIProgressView</code></td>
      <td><code>.progress</code></td>
      <td><code>Float</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>.progress(animated: Bool)</code></td>
      <td><code>Float</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIRefreshControl</code></td>
      <td><code>.isRefreshing</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="3"><code>UISegmentedControl</code></td>
      <td><code>.selectedSegmentIndex</code></td>
      <td><code>Int</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>.isEnabledForSegment(at: Int)</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="3"><code>UISlider</code></td>
      <td><code>.value</code></td>
      <td><code>Float</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>.value(animated: Bool)</code></td>
      <td><code>Float</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIStepper</code></td>
      <td><code>.value</code></td>
      <td><code>Double</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="3"><code>UISwitch</code></td>
      <td><code>.isOn</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>.isOn(animated: Bool)</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="3"><code>UITextField</code></td>
      <td><code>.text</code></td>
      <td><code>String</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>.attributedText</code></td>
      <td><code>NSAttributedString</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="3"><code>UIView</code></td>
      <td><code>.alpha</code></td>
      <td><code>CGFloat</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>.isHidden</code></td>
      <td><code>Bool</code></td>
    </tr>
  </tbody>
</table>

Extension Methods

<table>
  <thead>
      <tr>
        <th align="left"></th>
        <th align="left">Method</th>
        <th align="left">Type</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>UIButton</code></td>
      <td><code>.tapPublisher()</code></td>
      <td><code>AnyPublisher&lt;Void, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIControl</code></td>
      <td><code>.publisher(for: UIControl.Event)</code></td>
      <td><code>AnyPublisher&lt;UIControl.Event, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="3"><code>UIDatePicker</code></td>
      <td><code>.countDownDurationPublisher()</code></td>
      <td><code>AnyPublisher&lt;TimeInterval, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>.datePublisher()</code></td>
      <td><code>AnyPublisher&lt;Date, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIGestureRecognizer</code></td>
      <td><code>.publisher(attachingTo: UIView)</code></td>
      <td><code>AnyPublisher&lt;UIGestureRecognizer, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIPageControl</code></td>
      <td><code>.currentPagePublisher()</code></td>
      <td><code>AnyPublisher&lt;Int, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIProgressView</code></td>
      <td><code>.progressPublisher()</code></td>
      <td><code>AnyPublisher&lt;Float, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIRefreshControl</code></td>
      <td><code>.refreshPublisher()</code></td>
      <td><code>AnyPublisher&lt;Void, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UISegmentedControl</code></td>
      <td><code>.selectedSegmentIndexPublisher()</code></td>
      <td><code>AnyPublisher&lt;Int, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UISlider</code></td>
      <td><code>.valuePublisher()</code></td>
      <td><code>AnyPublisher&lt;Float, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIStepper</code></td>
      <td><code>.valuePublisher()</code></td>
      <td><code>AnyPublisher&lt;Double, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UISwitch</code></td>
      <td><code>.isOnPublisher()</code></td>
      <td><code>AnyPublisher&lt;Bool, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="3"><code>UITextField</code></td>
      <td><code>.textPublisher()</code></td>
      <td><code>AnyPublisher&lt;String, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>.attributedTextPublisher()</code></td>
      <td><code>AnyPublisher&lt;NSAttributedString, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIViewController</code></td>
      <td><code>.lifecyclePublisher()</code></td>
      <td><code>AnyPublisher&lt;ViewControllerLifecycleEvent, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>Publisher where Output == ViewControllerLifecycleEvent</code></td>
      <td><code>.isVisiblePublisher()</code></td>
      <td><code>AnyPublisher&lt;Bool, Never&gt;</code></td>
    </tr>
  </tbody>
</table>

## Documentation

- UIKit
  - [UIButton](#uibutton)
  - [UIControl](#uicontrol)
  - [UIDatePicker](#uidatepicker)
  - [UIGestureRecognizer](#uigesturerecognizer)
  - [UILabel](#uilabel)
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
  - [UIView](#uiview)
  - [UIViewController](#uiviewcontroller)
- [Caveats](#caveats)
- [Customization](#customization)

## `UIButton`

| Event |
| :-- |
| `.primaryActionTriggered` <tr></tr> |

### Property Wrapper

```swift
@Button // Projected Value: AnyPublisher<Void, Never>
```

### Bindings

```swift
func title(for state: UIControl.State) -> Binding<String>
func attributedTitle(for state: UIControl.State) -> Binding<NSAttributedString>
```

### Extension Method

```swift
func tapPublisher() -> AnyPublisher<Void, Never>
```

### Code Example

```swift
// Property Wrapper

@Button var button = UIButton()

button.setImage(UIImage(systemName: "heart"), for: .normal)

$button
    .sink { print("Tapped") }
    .store(in: &cancellables)

// Bindings

Just("Title")
    .bind(to: button.bindable.title(for: .normal))
    .store(in: &cancellables)

Just(NSAttributedString("Title"))
    .bind(to: button.bindable.attributedTitle(for: .normal))
    .store(in: &cancellables)

// Extension Method

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

### Binding

```swift
var isEnabled: Binding<Bool>
```

### Extension Method

```swift
func publisher(for controlEvents: UIControl.Event) -> AnyPublisher<UIControl.Event, Never>
```

> Use [`contains()`](https://developer.apple.com/documentation/swift/setalgebra/contains(_:)-5usmy) on the [OptionSet](https://developer.apple.com/documentation/swift/optionset) that is received to determine which event occurred.

### Supported Types

Just as every CombineUI property wrapper and binding may be used with subclasses of their supported type, the `UIControl` property wrapper and binding are compatible with `UIControl` subclasses, including (but not limited to) the following:

  - `UIButton`
  - `UIDatePicker`
  - `UIPageControl`
  - `UIRefreshControl`
  - `UISegmentedControl`
  - `UISlider`
  - `UIStepper`
  - `UISwitch`
  - `UITextField`

### Code Example

```swift
// Property Wrapper

@Control var control = UIButton()

control.setImage(UIImage(systemName: "heart"), for: .normal)

$control
    .primaryActionTriggered
    .sink { print("Triggered") }
    .store(in: &cancellables)

// Binding

Just(true)
    .bind(to: control.bindable.isEnabled)
    .store(in: &cancellables)

// Extension Method

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
| `.countDownDuration` | `.valueChanged` <tr></tr> |
| `.date` | `.valueChanged` <tr></tr> |

### Property Wrapper

```swift
@DatePicker(mode: UIDatePicker.Mode = .dateAndTime) // Projected Value: DatePickerInterface
```

`DatePickerInterface`

```swift
var countDownDuration: AnyPublisher<TimeInterval, Never>
var date: AnyPublisher<Date, Never>
```

### Bindings

```swift
var countDownDuration: Binding<TimeInterval>
var date: Binding<Date>

func date(animated: Bool) -> Binding<Date>
```

### Extension Methods

```swift
func datePublisher() -> AnyPublisher<Date, Never>
func countDownDurationPublisher() -> AnyPublisher<TimeInterval, Never>
```

### Code Example

```swift
// Property Wrapper

@DatePicker(mode: .countDownTimer)
var datePicker1 = UIDatePicker()

@DatePicker var datePicker2 = UIDatePicker()

$datePicker1
    .countDownDuration
    .sink { countDownDuration in }
    .store(in: &cancellables)

$datePicker2
    .date
    .sink { date in }
    .store(in: &cancellables)

// Bindings

Just(60)
    .bind(to: datePicker1.bindable.countDownDuration)
    .store(in: &cancellables)

Just(Date())
    .bind(to: datePicker2.bindable.date)
    .store(in: &cancellables)

Just(Date())
    .bind(to: datePicker2.bindable.date(animated: true))
    .store(in: &cancellables)

// Extension Methods

datePicker1
    .countDownDurationPublisher()
    .sink { countDownDuration in }
    .store(in: &cancellables)

datePicker2
    .datePublisher()
    .sink { date in }
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

### Binding

```swift
var isEnabled: Binding<Bool>
```

### Extension Method

```swift
func publisher(attachingTo view: UIView) -> AnyPublisher<UIGestureRecognizer, Never>
```

### Code Example

```swift
// Property Wrapper

@GestureRecognizer var swipe = UISwipeGestureRecognizer()

$swipe
    .attaching(to: view)
    .sink { swipe in }
    .store(in: &cancellables)

// Binding

Just(true)
    .bind(to: swipe.bindable.isEnabled)
    .store(in: &cancellables)

// Extension Method

swipe
    .publisher(attachingTo: view)
    .sink { swipe in }
    .store(in: &cancellables)
```

### Notes

- The gesture recognizer will be added to the provided view automatically.

## `UILabel`

### Bindings

```swift
var isEnabled: Binding<Bool>
var text: Binding<String>
var attributedText: Binding<NSAttributedString>
```

### Code Example

```swift
// Bindings

let label = UILabel()

Just(true)
    .bind(to: label.bindable.isEnabled)
    .store(in: &cancellables)

Just("Text")
    .bind(to: label.bindable.text)
    .store(in: &cancellables)

Just("Attributed Text")
    .bind(to: label.bindable.attributedText)
    .store(in: &cancellables)
```

## `UIPageControl`

| Property | Event |
| :-- | :-- |
| `.currentPage` | `.valueChanged` <tr></tr> |

### Property Wrapper

```swift
@PageControl // Projected Value: AnyPublisher<Int, Never>
```

### Binding

```swift
var currentPage: Binding<Int>
```

### Extension Method

```swift
func currentPagePublisher() -> AnyPublisher<Int, Never>
```

### Code Example

```swift
// Property Wrapper

@PageControl var pageControl = UIPageControl()

$pageControl
    .sink { currentPage in }
    .store(in: &cancellables)

// Binding

Just(1)
    .bind(to: pageControl.bindable.currentPage)
    .store(in: &cancellables)

// Extension Method

pageControl
    .currentPagePublisher()
    .sink { currentPage in }
    .store(in: &cancellables)
```

## `UIProgressView`

| Property |
| :-- |
| `.progress` <tr></tr> |

### Property Wrapper

```swift
@ProgressView // Projected Value: AnyPublisher<Float, Never>
```

### Bindings

```swift
var progress: Binding<Float>

func progress(animated: Bool) -> Binding<Float>
```

### Extension Method

```swift
func progressPublisher() -> AnyPublisher<Float, Never>
```

### Code Example

```swift
// Property Wrapper

@ProgressView var progressView = UIProgressView()

$progressView
    .sink { progress in }
    .store(in: &cancellables)

// Bindings

Just(1)
    .bind(to: progressView.bindable.progress)
    .store(in: &cancellables)

Just(1)
    .bind(to: progressView.bindable.progress(animated: true))
    .store(in: &cancellables)

// Extension Method

progressView
    .progressPublisher()
    .sink { progress in }
    .store(in: &cancellables)
```

### Notes

- Due to `UIProgressView` behavior, only non-animated progress is published unless monkey-patched, for example:

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
| `.isRefreshing` | `.valueChanged` | `true` <tr></tr> |

### Property Wrapper

```swift
@RefreshControl // Projected Value: AnyPublisher<Void, Never>
```

### Binding

```swift
var isRefreshing: Binding<Bool>
```

### Extension Method

```swift
func refreshPublisher() -> AnyPublisher<Void, Never>
```

### Code Example

```swift
// Property Wrapper

@RefreshControl var refreshControl = UIRefreshControl()

$refreshControl
    .sink { print("Refreshing") }
    .store(in: &cancellables)

// Binding

Just(true)
    .bind(to: refreshControl.bindable.isRefreshing)
    .store(in: &cancellables)

// Extension Method

refreshControl
    .refreshPublisher()
    .sink { print("Refreshing") }
    .store(in: &cancellables)
```

## `UIScrollView`

| Protocol |
| :-- |
| `UIScrollViewDelegate` <tr></tr> |

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
// Property Wrapper

@ScrollView var scrollView = UIScrollView()

$scrollView
    .didScroll
    .sink { print("Scrolling") }
    .store(in: &cancellables)
```

## `UISearchBar`

| Protocol |
| :-- |
| `UISearchBarDelegate` <tr></tr> |

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
// Property Wrapper

@SearchBar var searchBar = UISearchBar()

$searchBar
    .textDidChange
    .sink { text in }
    .store(in: &cancellables)
```

## `UISegmentedControl`

| Property | Event |
| :-- | :-- |
| `.selectedSegmentIndex` | `.valueChanged` <tr></tr> |

### Property Wrapper

```swift
@SegmentedControl // Projected Value: AnyPublisher<Int, Never>
```

### Bindings

```swift
var selectedSegmentIndex: Binding<Int>

func isEnabledForSegment(at index: Int) -> Binding<Bool>
```

### Extension Method

```swift
func selectedSegmentIndexPublisher() -> AnyPublisher<Int, Never>
```

### Code Example

```swift
// Property Wrapper

@SegmentedControl var segmentedControl = UISegmentedControl(items: items)

$segmentedControl
    .sink { selectedSegmentIndex in }
    .store(in: &cancellables)

// Bindings

Just(1)
    .bind(to: segmentedControl.bindable.selectedSegmentIndex)
    .store(in: &cancellables)

Just(true)
    .bind(to: segmentedControl.bindable.isEnabledForSegment(at: 1))
    .store(in: &cancellables)

// Extension Method

segmentedControl
    .selectedSegmentIndexPublisher()
    .sink { selectedSegmentIndex in }
    .store(in: &cancellables)
```

## `UISlider`

| Property | Event |
| :-- | :-- |
| `.value` | `.valueChanged` <tr></tr> |

### Property Wrapper

```swift
@Slider // Projected Value: AnyPublisher<Float, Never>
```

### Bindings

```swift
var value: Binding<Float>

func value(animated: Bool) -> Binding<Float>
```

### Extension Method

```swift
func valuePublisher() -> AnyPublisher<Float, Never>
```

### Code Example

```swift
// Property Wrapper

@Slider var slider = UISlider()

$slider
    .sink { value in }
    .store(in: &cancellables)

// Bindings

Just(1)
    .bind(to: slider.bindable.value)
    .store(in: &cancellables)

Just(1)
    .bind(to: slider.bindable.value(animated: true))
    .store(in: &cancellables)

// Extension Method

slider
    .valuePublisher()
    .sink { value in }
    .store(in: &cancellables)
```

## `UIStepper`

| Property | Event |
| :-- | :-- |
| `.value` | `.valueChanged` <tr></tr> |

### Property Wrapper

```swift
@Stepper // Projected Value: AnyPublisher<Double, Never>
```

### Binding

```swift
var value: Binding<Double>
```

### Extension Method

```swift
func valuePublisher() -> AnyPublisher<Double, Never>
```

### Code Example

```swift
// Property Wrapper

@Stepper var stepper = UIStepper()

$stepper
    .sink { value in }
    .store(in: &cancellables)

// Binding

Just(100)
    .bind(to: stepper.bindable.value)
    .store(in: &cancellables)

// Extension Method

stepper
    .valuePublisher()
    .sink { value in }
    .store(in: &cancellables)
```

## `UISwitch`

| Property | Event |
| :-- | :-- |
| `.isOn` | `.valueChanged` <tr></tr> |

### Property Wrapper

```swift
@Switch // Projected Value: AnyPublisher<Bool, Never>
```

### Bindings

```swift
var isOn: Binding<Bool>

func isOn(animated: Bool) -> Binding<Bool>
```

### Extension Method

```swift
func isOnPublisher() -> AnyPublisher<Bool, Never>
```

### Code Example

```swift
// Property Wrapper

@Switch var `switch` = UISwitch()

$switch
    .sink { isOn in }
    .store(in: &cancellables)

// Bindings

Just(true)
    .bind(to: `switch`.bindable.isOn)
    .store(in: &cancellables)

Just(true)
    .bind(to: `switch`.bindable.isOn(animated: true))
    .store(in: &cancellables)

// Extension Method

`switch`
    .isOnPublisher()
    .sink { isOn in }
    .store(in: &cancellables)
```

## `UITextField`

| Property | Events |
| :-- | :-- |
| `.text` | `.allEditingEvents` <tr></tr> |
| `.attributedText` | `.allEditingEvents` <tr></tr> |

| Protocol |
| :-- |
| `UITextFieldDelegate` <tr></tr> |

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

### Bindings

```swift
var text: Binding<String>
var attributedText: Binding<NSAttributedString>
```

### Extension Methods

```swift
func textPublisher() -> AnyPublisher<String, Never>

@available(iOS 15, *)
func attributedTextPublisher() -> AnyPublisher<NSAttributedString, Never>
```

### Code Example

```swift
// Property Wrapper

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

// Bindings

Just("Text")
    .bind(to: textField.bindable.text)
    .store(in: &cancellables)

Just(NSAttributedString("Text"))
    .bind(to: textField.bindable.attributedText)
    .store(in: &cancellables)

// Extension Methods

textField
    .textPublisher()
    .sink { text in }
    .store(in: &cancellables)

textField
    .attributedTextPublisher()
    .sink { attributedText in }
    .store(in: &cancellables)
```

## `UIView`

### Bindings

```swift
var alpha: Binding<CGFloat>
var isHidden: Binding<Bool>
```

### Supported Types

Just as every CombineUI binding may be used with subclasses of its supported type, the `UIView` bindings are compatible with all `UIView` subclasses.

### Code Example

```swift
// Bindings

let view = UIView()

Just(0.5)
    .bind(to: view.bindable.alpha)
    .store(in: &cancellables)

Just(true)
    .bind(to: view.bindable.isHidden)
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

### Code Example

```swift
// Property Wrapper

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

// Extension Methods

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

## Customization

### Adding Bindings to Views and Controls

Additional bindings are easily added to existing views and controls. This is useful for properties that CombineUI does not yet support natively.

Example:

```swift
extension Bindable where Target: UIView {

    var tag: Binding<Int> {
        Binding(self, for: \.tag)
    }
}
```

### Adopting CombineUI in Custom Views and Controls

The same type of APIs that CombineUI provides can also be adopted by custom views and controls.

Example:

```swift
@propertyWrapper
struct Example<T: ExampleControl> {

    var wrappedValue: T
    var projectedValue: AnyPublisher<ExampleValue, Never>

    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = wrappedValue
            .valuePublisher()
            .share()
            .eraseToAnyPublisher()
    }
}

extension Bindable where Target: ExampleControl {

    var value: Binding<ExampleValue> {
        Binding(self, for: \.value)
    }
}

extension ExampleControl {

    func valuePublisher() -> AnyPublisher<ExampleValue, Never> {
        publisher(for: .valueChanged)
            .compactMap { [weak self] _ in self?.value }
            .prepend(value)
            .eraseToAnyPublisher()
    }
}

```

The CombineUI source code may be used as reference for additional examples.  
