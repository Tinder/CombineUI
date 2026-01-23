[![Swift](https://github.com/Tinder/CombineUI/actions/workflows/swift.yml/badge.svg?event=push)](https://github.com/Tinder/CombineUI/actions/workflows/swift.yml)
&nbsp;
[![DocC](https://github.com/Tinder/CombineUI/actions/workflows/docc.yml/badge.svg?event=push)](https://github.com/Tinder/CombineUI/actions/workflows/docc.yml)

# CombineUI

Swift Property Wrappers, Bindings and Combine Publishers for UI Gestures, Controls and Views

## Overview

CombineUI provides [Swift property wrappers](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Property-Wrappers) for select Apple types such as gestures, controls and views. These property wrappers [project](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Projecting-a-Value-From-a-Property-Wrapper) Combine publishers for gesture recognition, control events, property changes and delegate callbacks.

Example:

```swift
@Button var button = UIButton()
```

> The `$button` projected value is a publisher that will send when the button is tapped.

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

- iOS `15.0`
- Swift `5.8`

## Installation

### Swift Package Manager

**Package Dependency**

> Replace `<version>` with the desired minimum version.

```swift
.package(url: "https://github.com/Tinder/CombineUI.git", from: "<version>")
```

**Target Dependency**

```
"CombineUI"
```

### Swift Package Collection

```swift
https://swiftpackageindex.com/Tinder/collection.json
```

## Code Examples

All examples require this setup:

```swift
import Combine
import CombineUI
import UIKit

var cancellables = Set<AnyCancellable>()
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
| `UIRefreshControl` | `@RefreshControl` | `AnyPublisher<Void, Never>` <tr></tr> |
| `UIScrollView` | `@ScrollView` | `ScrollViewInterface` <tr></tr> |
| `UISearchBar` | `@SearchBar` | `SearchBarInterface` <tr></tr> |
| `UISegmentedControl` | `@SegmentedControl` | `AnyPublisher<Int, Never>` <tr></tr> |
| `UISlider` | `@Slider` | `AnyPublisher<Float, Never>` <tr></tr> |
| `UIStepper` | `@Stepper` | `AnyPublisher<Double, Never>` <tr></tr> |
| `UISwitch` | `@Switch` | `AnyPublisher<Bool, Never>` <tr></tr> |
| `UITextField` | `@TextField` | `TextFieldInterface` <tr></tr> |
| `UITextView` | `@TextView` | `TextViewInterface` <tr></tr> |
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
      <td rowspan="7"><code>UIActivityIndicatorView</code></td>
      <td><code>style</code></td>
      <td><code>UIActivityIndicatorView.Style</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>color</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>hidesWhenStopped</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>isAnimating</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="11"><code>UIButton</code></td>
      <td><code>titleColor(for: UIControl.State)</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>titleShadowColor(for: UIControl.State)</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>title(for: UIControl.State)</code></td>
      <td><code>String</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>attributedTitle(for: UIControl.State)</code></td>
      <td><code>AttributedString</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>image(for: UIControl.State)</code></td>
      <td><code>UIImage?</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>backgroundImage(for: UIControl.State)</code></td>
      <td><code>UIImage?</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIControl</code></td>
      <td><code>isEnabled</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="5"><code>UIDatePicker</code></td>
      <td><code>countDownDuration</code></td>
      <td><code>TimeInterval</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>date</code></td>
      <td><code>Date</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>date(animated: Bool)</code></td>
      <td><code>Date</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIGestureRecognizer</code></td>
      <td><code>isEnabled</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="5"><code>UIImageView</code></td>
      <td><code>image</code></td>
      <td><code>UIImage?</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>highlightedImage</code></td>
      <td><code>UIImage?</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>isHighlighted</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="9"><code>UILabel</code></td>
      <td><code>isEnabled</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>font</code></td>
      <td><code>UIFont</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>textColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>text</code></td>
      <td><code>String</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>attributedText</code></td>
      <td><code>AttributedString</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="9"><code>UIPageControl</code></td>
      <td><code>pageIndicatorTintColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>currentPageIndicatorTintColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>currentPage</code></td>
      <td><code>Int</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>numberOfPages</code></td>
      <td><code>Int</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>hidesForSinglePage</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="7"><code>UIProgressView</code></td>
      <td><code>trackTintColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>progressTintColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>progress</code></td>
      <td><code>Float</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>progress(animated: Bool)</code></td>
      <td><code>Float</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="5"><code>UIRefreshControl</code></td>
      <td><code>tintColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>attributedTitle</code></td>
      <td><code>AttributedString</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>isRefreshing</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="11"><code>UISegmentedControl</code></td>
      <td><code>isMomentary</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>selectedSegmentIndex</code></td>
      <td><code>Int</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>isEnabledForSegment(at: Int)</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>widthForSegment(at: Int)</code></td>
      <td><code>CGFloat</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>titleForSegment(at: Int)</code></td>
      <td><code>String</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>imageForSegment(at: Int)</code></td>
      <td><code>UIImage?</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="15"><code>UISlider</code></td>
      <td><code>isContinuous</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>minimumValue</code></td>
      <td><code>Float</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>maximumValue</code></td>
      <td><code>Float</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>minimumTrackTintColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>maximumTrackTintColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>thumbTintColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>value</code></td>
      <td><code>Float</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>value(animated: Bool)</code></td>
      <td><code>Float</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="13"><code>UIStepper</code></td>
      <td><code>isContinuous</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>autorepeat</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>wraps</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>minimumValue</code></td>
      <td><code>Double</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>maximumValue</code></td>
      <td><code>Double</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>stepValue</code></td>
      <td><code>Double</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>value</code></td>
      <td><code>Double</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="7"><code>UISwitch</code></td>
      <td><code>onTintColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>thumbTintColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>isOn</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>isOn(animated: Bool)</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="13"><code>UITextField</code></td>
      <td><code>font</code></td>
      <td><code>UIFont</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>textColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>textAlignment</code></td>
      <td><code>NSTextAlignment</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>placeholder</code></td>
      <td><code>String</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>attributedPlaceholder</code></td>
      <td><code>AttributedString</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>text</code></td>
      <td><code>String</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>attributedText</code></td>
      <td><code>AttributedString</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="11"><code>UITextView</code></td>
      <td><code>isEditable</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>font</code></td>
      <td><code>UIFont</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>textColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>textAlignment</code></td>
      <td><code>NSTextAlignment</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>text</code></td>
      <td><code>String</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>attributedText</code></td>
      <td><code>AttributedString</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="21"><code>UIView</code></td>
      <td><code>isUserInteractionEnabled</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>isMultipleTouchEnabled</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>isExclusiveTouch</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>clipsToBounds</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>tintColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>backgroundColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>borderColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>shadowColor</code></td>
      <td><code>UIColor</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>alpha</code></td>
      <td><code>CGFloat</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>isOpaque</code></td>
      <td><code>Bool</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>isHidden</code></td>
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
      <td><code>tapPublisher()</code></td>
      <td><code>AnyPublisher&lt;Void, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIControl</code></td>
      <td><code>publisher(for: UIControl.Event)</code></td>
      <td><code>AnyPublisher&lt;UIControl.Event, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="3"><code>UIDatePicker</code></td>
      <td><code>countDownDurationPublisher()</code></td>
      <td><code>AnyPublisher&lt;TimeInterval, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>datePublisher()</code></td>
      <td><code>AnyPublisher&lt;Date, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIGestureRecognizer</code></td>
      <td><code>publisher(attachingTo: UIView)</code></td>
      <td><code>AnyPublisher&lt;UIGestureRecognizer, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIPageControl</code></td>
      <td><code>currentPagePublisher()</code></td>
      <td><code>AnyPublisher&lt;Int, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIRefreshControl</code></td>
      <td><code>refreshPublisher()</code></td>
      <td><code>AnyPublisher&lt;Void, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UISegmentedControl</code></td>
      <td><code>selectedSegmentIndexPublisher()</code></td>
      <td><code>AnyPublisher&lt;Int, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UISlider</code></td>
      <td><code>valuePublisher()</code></td>
      <td><code>AnyPublisher&lt;Float, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIStepper</code></td>
      <td><code>valuePublisher()</code></td>
      <td><code>AnyPublisher&lt;Double, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UISwitch</code></td>
      <td><code>isOnPublisher()</code></td>
      <td><code>AnyPublisher&lt;Bool, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td rowspan="3"><code>UITextField</code></td>
      <td><code>textPublisher()</code></td>
      <td><code>AnyPublisher&lt;String, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>attributedTextPublisher()</code></td>
      <td><code>AnyPublisher&lt;AttributedString, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>UIViewController</code></td>
      <td><code>lifecyclePublisher()</code></td>
      <td><code>AnyPublisher&lt;ViewControllerLifecycleEvent, Never&gt;</code></td>
    </tr>
    <tr></tr>
    <tr>
      <td><code>Publisher where Output == ViewControllerLifecycleEvent</code></td>
      <td><code>isVisiblePublisher()</code></td>
      <td><code>AnyPublisher&lt;Bool, Never&gt;</code></td>
    </tr>
  </tbody>
</table>

## Documentation

- UIKit
  - [UIActivityIndicatorView](#uiactivityindicatorview)
  - [UIButton](#uibutton)
  - [UIControl](#uicontrol)
  - [UIDatePicker](#uidatepicker)
  - [UIGestureRecognizer](#uigesturerecognizer)
  - [UIImageView](#uiimageview)
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
  - [UITextView](#uitextview)
  - [UIView](#uiview)
  - [UIViewController](#uiviewcontroller)
- [Caveats](#caveats)
- [Customization](#customization)

## `UIActivityIndicatorView`

### Bindings

```swift
var style: Binding<UIActivityIndicatorView.Style>
var color: Binding<UIColor>
var hidesWhenStopped: Binding<Bool>
var isAnimating: Binding<Bool>
```

### Code Example

```swift
let activityIndicatorView = UIActivityIndicatorView()

Just(.medium)
    .bind(to: activityIndicatorView.bindable.style)
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: activityIndicatorView.bindable.color)
    .store(in: &cancellables)

Just(true)
    .bind(to: activityIndicatorView.bindable.hidesWhenStopped)
    .store(in: &cancellables)

Just(true)
    .bind(to: activityIndicatorView.bindable.isAnimating)
    .store(in: &cancellables)
```

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
func titleColor(for state: UIControl.State) -> Binding<UIColor>
func titleShadowColor(for state: UIControl.State) -> Binding<UIColor>
func title(for state: UIControl.State) -> Binding<String>
func attributedTitle(for state: UIControl.State) -> Binding<AttributedString>
func image(for state: UIControl.State) -> Binding<UIImage?>
func backgroundImage(for state: UIControl.State) -> Binding<UIImage?>
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

Just(.systemPink)
    .bind(to: button.bindable.titleColor(for: .normal))
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: button.bindable.titleShadowColor(for: .normal))
    .store(in: &cancellables)

Just("Title")
    .bind(to: button.bindable.title(for: .normal))
    .store(in: &cancellables)

Just(AttributedString("Title"))
    .bind(to: button.bindable.attributedTitle(for: .normal))
    .store(in: &cancellables)

Just(.checkmark)
    .bind(to: button.bindable.image(for: .normal))
    .store(in: &cancellables)

Just(.checkmark)
    .bind(to: button.bindable.backgroundImage(for: .normal))
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
    .sink { controlEvents in }
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

## `UIImageView`

### Bindings

```swift
var image: Binding<UIImage?>
var highlightedImage: Binding<UIImage?>
var isHighlighted: Binding<Bool>
```

### Code Example

```swift
let imageView = UIImageView()

Just(.checkmark)
    .bind(to: imageView.bindable.image)
    .store(in: &cancellables)

Just(.checkmark)
    .bind(to: imageView.bindable.highlightedImage)
    .store(in: &cancellables)

Just(true)
    .bind(to: imageView.bindable.isHighlighted)
    .store(in: &cancellables)
```

## `UILabel`

### Bindings

```swift
var isEnabled: Binding<Bool>
var font: Binding<UIFont>
var textColor: Binding<UIColor>
var text: Binding<String>
var attributedText: Binding<AttributedString>
```

### Code Example

```swift
let label = UILabel()

Just(true)
    .bind(to: label.bindable.isEnabled)
    .store(in: &cancellables)

Just(.preferredFont(forTextStyle: .body))
    .bind(to: label.bindable.font)
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: label.bindable.textColor)
    .store(in: &cancellables)

Just("Text")
    .bind(to: label.bindable.text)
    .store(in: &cancellables)

Just(AttributedString("Text"))
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

### Bindings

```swift
var pageIndicatorTintColor: Binding<UIColor>
var currentPageIndicatorTintColor: Binding<UIColor>
var currentPage: Binding<Int>
var numberOfPages: Binding<Int>
var hidesForSinglePage: Binding<Bool>
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

// Bindings

Just(.systemPink)
    .bind(to: pageControl.bindable.pageIndicatorTintColor)
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: pageControl.bindable.currentPageIndicatorTintColor)
    .store(in: &cancellables)

Just(1)
    .bind(to: pageControl.bindable.currentPage)
    .store(in: &cancellables)

Just(1)
    .bind(to: pageControl.bindable.numberOfPages)
    .store(in: &cancellables)

Just(true)
    .bind(to: pageControl.bindable.hidesForSinglePage)
    .store(in: &cancellables)

// Extension Method

pageControl
    .currentPagePublisher()
    .sink { currentPage in }
    .store(in: &cancellables)
```

## `UIProgressView`

### Bindings

```swift
var trackTintColor: Binding<UIColor>
var progressTintColor: Binding<UIColor>
var progress: Binding<Float>

func progress(animated: Bool) -> Binding<Float>
```

### Code Example

```swift
let progressView = UIProgressView()

Just(.systemPink)
    .bind(to: progressView.bindable.trackTintColor)
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: progressView.bindable.progressTintColor)
    .store(in: &cancellables)

Just(1)
    .bind(to: progressView.bindable.progress)
    .store(in: &cancellables)

Just(1)
    .bind(to: progressView.bindable.progress(animated: true))
    .store(in: &cancellables)
```

## `UIRefreshControl`

| Property | Event | Value |
| :-- | :-- | :-- |
| `.isRefreshing` | `.valueChanged` | `true` <tr></tr> |

### Property Wrapper

```swift
@RefreshControl // Projected Value: AnyPublisher<Void, Never>
```

### Bindings

```swift
var tintColor: Binding<UIColor>
var attributedTitle: Binding<AttributedString>
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

// Bindings

Just(.systemPink)
    .bind(to: refreshControl.bindable.tintColor)
    .store(in: &cancellables)

Just(AttributedString("Title"))
    .bind(to: refreshControl.bindable.attributedTitle)
    .store(in: &cancellables)

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
var isMomentary: Binding<Bool>
var selectedSegmentIndex: Binding<Int>

func isEnabledForSegment(at index: Int) -> Binding<Bool>
func widthForSegment(at index: Int) -> Binding<CGFloat>
func titleForSegment(at index: Int) -> Binding<String>
func imageForSegment(at index: Int) -> Binding<UIImage?>
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

Just(true)
    .bind(to: segmentedControl.bindable.isMomentary)
    .store(in: &cancellables)

Just(1)
    .bind(to: segmentedControl.bindable.selectedSegmentIndex)
    .store(in: &cancellables)

Just(true)
    .bind(to: segmentedControl.bindable.isEnabledForSegment(at: 1))
    .store(in: &cancellables)

Just(100)
    .bind(to: segmentedControl.bindable.widthForSegment(at: 1))
    .store(in: &cancellables)

Just("Title")
    .bind(to: segmentedControl.bindable.titleForSegment(at: 1))
    .store(in: &cancellables)

Just(.checkmark)
    .bind(to: segmentedControl.bindable.imageForSegment(at: 1))
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
var isContinuous: Binding<Bool>
var minimumValue: Binding<Float>
var maximumValue: Binding<Float>
var minimumTrackTintColor: Binding<UIColor>
var maximumTrackTintColor: Binding<UIColor>
var thumbTintColor: Binding<UIColor>
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

Just(true)
    .bind(to: slider.bindable.isContinuous)
    .store(in: &cancellables)

Just(1)
    .bind(to: slider.bindable.minimumValue)
    .store(in: &cancellables)

Just(100)
    .bind(to: slider.bindable.maximumValue)
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: slider.bindable.minimumTrackTintColor)
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: slider.bindable.maximumTrackTintColor)
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: slider.bindable.thumbTintColor)
    .store(in: &cancellables)

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

### Bindings

```swift
var isContinuous: Binding<Bool>
var autorepeat: Binding<Bool>
var wraps: Binding<Bool>
var minimumValue: Binding<Double>
var maximumValue: Binding<Double>
var stepValue: Binding<Double>
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

// Bindings

Just(true)
    .bind(to: stepper.bindable.isContinuous)
    .store(in: &cancellables)

Just(true)
    .bind(to: stepper.bindable.autorepeat)
    .store(in: &cancellables)

Just(true)
    .bind(to: stepper.bindable.wraps)
    .store(in: &cancellables)

Just(1)
    .bind(to: stepper.bindable.minimumValue)
    .store(in: &cancellables)

Just(100)
    .bind(to: stepper.bindable.maximumValue)
    .store(in: &cancellables)

Just(10)
    .bind(to: stepper.bindable.stepValue)
    .store(in: &cancellables)

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
var onTintColor: Binding<UIColor>
var thumbTintColor: Binding<UIColor>
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

Just(.systemPink)
    .bind(to: `switch`.bindable.onTintColor)
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: `switch`.bindable.thumbTintColor)
    .store(in: &cancellables)

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
var attributedText: AnyPublisher<AttributedString, Never>

// UITextFieldDelegate

var didBeginEditing: AnyPublisher<Void, Never>
var didEndEditing: AnyPublisher<Void, Never>
var didChangeSelection: AnyPublisher<Void, Never>
```

### Bindings

```swift
var font: Binding<UIFont>
var textColor: Binding<UIColor>
var textAlignment: Binding<NSTextAlignment>
var placeholder: Binding<String>
var attributedPlaceholder: Binding<AttributedString>
var text: Binding<String>
var attributedText: Binding<AttributedString>
```

### Extension Methods

```swift
func textPublisher() -> AnyPublisher<String, Never>
func attributedTextPublisher() -> AnyPublisher<AttributedString, Never>
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

// Bindings

Just(.preferredFont(forTextStyle: .body))
    .bind(to: textField.bindable.font)
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: textField.bindable.textColor)
    .store(in: &cancellables)

Just(.natural)
    .bind(to: textField.bindable.textAlignment)
    .store(in: &cancellables)

Just("Placeholder")
    .bind(to: textField.bindable.placeholder)
    .store(in: &cancellables)

Just(AttributedString("Placeholder"))
    .bind(to: textField.bindable.attributedPlaceholder)
    .store(in: &cancellables)

Just("Text")
    .bind(to: textField.bindable.text)
    .store(in: &cancellables)

Just(AttributedString("Text"))
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

## `UITextView`

| Protocol |
| :-- |
| `UITextViewDelegate` <tr></tr> |

### Property Wrapper

```swift
@TextView // Projected Value: TextViewInterface
```

`TextViewInterface`

```swift
// Properties

var text: AnyPublisher<String, Never>
var attributedText: AnyPublisher<AttributedString, Never>

// UITextViewDelegate

var didChange: AnyPublisher<Void, Never>
var didBeginEditing: AnyPublisher<Void, Never>
var didEndEditing: AnyPublisher<Void, Never>
var didChangeSelection: AnyPublisher<Void, Never>
```

### Bindings

```swift
var isEditable: Binding<Bool>
var font: Binding<UIFont>
var textColor: Binding<UIColor>
var textAlignment: Binding<NSTextAlignment>
var text: Binding<String>
var attributedText: Binding<AttributedString>
```

### Code Example

```swift
// Property Wrapper

@TextView var textView = UITextView()

$textView
    .text
    .sink { text in }
    .store(in: &cancellables)

$textView
    .attributedText
    .sink { attributedText in }
    .store(in: &cancellables)

// Bindings

Just(true)
    .bind(to: textView.bindable.isEditable)
    .store(in: &cancellables)

Just(.preferredFont(forTextStyle: .body))
    .bind(to: textView.bindable.font)
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: textView.bindable.textColor)
    .store(in: &cancellables)

Just(.natural)
    .bind(to: textView.bindable.textAlignment)
    .store(in: &cancellables)

Just("Text")
    .bind(to: textView.bindable.text)
    .store(in: &cancellables)

Just(AttributedString("Text"))
    .bind(to: textView.bindable.attributedText)
    .store(in: &cancellables)
```

## `UIView`

### Bindings

```swift
var isUserInteractionEnabled: Binding<Bool>
var isMultipleTouchEnabled: Binding<Bool>
var isExclusiveTouch: Binding<Bool>
var clipsToBounds: Binding<Bool>
var tintColor: Binding<UIColor>
var backgroundColor: Binding<UIColor>
var borderColor: Binding<UIColor>
var shadowColor: Binding<UIColor>
var alpha: Binding<CGFloat>
var isOpaque: Binding<Bool>
var isHidden: Binding<Bool>
```

### Supported Types

Just as every CombineUI binding may be used with subclasses of its supported type, the `UIView` bindings are compatible with all `UIView` subclasses.

### Code Example

```swift
let view = UIView()

Just(true)
    .bind(to: view.bindable.isUserInteractionEnabled)
    .store(in: &cancellables)

Just(true)
    .bind(to: view.bindable.isMultipleTouchEnabled)
    .store(in: &cancellables)

Just(true)
    .bind(to: view.bindable.isExclusiveTouch)
    .store(in: &cancellables)

Just(true)
    .bind(to: view.bindable.clipsToBounds)
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: view.bindable.tintColor)
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: view.bindable.backgroundColor)
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: view.bindable.borderColor)
    .store(in: &cancellables)

Just(.systemPink)
    .bind(to: view.bindable.shadowColor)
    .store(in: &cancellables)

Just(0.5)
    .bind(to: view.bindable.alpha)
    .store(in: &cancellables)

Just(true)
    .bind(to: view.bindable.isOpaque)
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

## Contributing

While interest in contributing to this project is appreciated, it has been open 
sourced solely for the purpose of sharing with the community. This means we are 
unable to accept outside contributions at this time and pull requests will not 
be reviewed or merged. To report a security concern or vulnerability, please 
submit a GitHub issue.

## License

Licensed under the [Match Group Modified 3-Clause BSD License](
https://github.com/Tinder/CombineUI/blob/main/LICENSE
).
