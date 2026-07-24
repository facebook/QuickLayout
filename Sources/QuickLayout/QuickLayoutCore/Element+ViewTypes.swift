/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import Foundation
import UIKit

/// If you add a new view type or override a new view please add a test into
/// UIKitStandardLibrarySizingBehaviourTests.swift,
/// HStackWithTwoViewsServerSnapshotTests.swift,
/// HStackWithTwoViewsAndInfinitSizeServerSnapshotTests.swift.

@objc
/// While Flexibility specifies sizing behavior of a view per axis,
/// ViewType specifies sizing behaviour of a UIKit's view in both axis.
enum ViewType: Int8 {
  case baseView
  case label
  case horizontallyExpandable
  case textView
  case scrollView
  case tableView
  case fixedSize
}

extension UIView {
  @objc
  func quick_viewType() -> ViewType {
    return .baseView
  }
}

extension UILabel {
  @objc
  override func quick_viewType() -> ViewType {
    return .label
  }
}

extension UITextField {
  @objc
  override func quick_viewType() -> ViewType {
    return .horizontallyExpandable
  }
}

extension UISearchBar {
  @objc
  override func quick_viewType() -> ViewType {
    return .horizontallyExpandable
  }
}

#if !os(tvOS)
extension UISlider {
  @objc
  override func quick_viewType() -> ViewType {
    return .horizontallyExpandable
  }
}
#endif // !os(tvOS)

extension UIProgressView {
  @objc
  override func quick_viewType() -> ViewType {
    return .horizontallyExpandable
  }
}

#if !os(tvOS)
extension UISearchTextField {
  @objc
  override func quick_viewType() -> ViewType {
    return .horizontallyExpandable
  }
}
#endif // !os(tvOS)

extension UITextView {
  @objc
  override func quick_viewType() -> ViewType {
    return .textView
  }
}

extension UITableView {
  @objc
  override func quick_viewType() -> ViewType {
    return .tableView
  }
}

extension UIScrollView {
  @objc
  override func quick_viewType() -> ViewType {
    return .scrollView
  }
}

extension UIImageView {
  @objc
  override func quick_viewType() -> ViewType {
    return .fixedSize
  }
}

extension UIActivityIndicatorView {
  @objc
  override func quick_viewType() -> ViewType {
    return .fixedSize
  }
}

#if !os(tvOS)
extension UIStepper {
  @objc
  override func quick_viewType() -> ViewType {
    return .fixedSize
  }
}
#endif // !os(tvOS)

extension UIPageControl {
  @objc
  override func quick_viewType() -> ViewType {
    return .fixedSize
  }
}

#if !os(tvOS)
extension UISwitch {
  @objc
  override func quick_viewType() -> ViewType {
    return .fixedSize
  }
}
#endif // !os(tvOS)
