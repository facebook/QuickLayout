/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import QuickLayoutBridge
import QuickLayoutCore
// XCTest required: QuickLayoutBridge is `extension_api_only`, so enabling Swift
// Testing makes the test module pull the unavailable `_Testing_UIKit` cross-import
// overlay and fail to build. The entire QuickLayout test suite uses XCTest for
// this reason.
// ast-grep-ignore: swift-testing/swift/no-new-xctest
import XCTest

@MainActor
final class TagElementTests: XCTestCase {

  func testTagStampsResolvedNode() {
    let node = ViewProxy(width: 30, height: 10)
      .tag("x")
      .quick_layoutThatFits(CGSize(width: 100, height: 100))

    XCTAssertEqual(node.tag, "x")
    XCTAssertEqual(node.size, CGSize(width: 30, height: 10))
  }

  func testTagDoesNotChangeResolvedSize() {
    let proposed = CGSize(width: 100, height: 100)
    let untagged = ViewProxy(width: 42, height: 24).quick_layoutThatFits(proposed).size
    let tagged = ViewProxy(width: 42, height: 24).tag("x").quick_layoutThatFits(proposed).size

    XCTAssertEqual(untagged, tagged)
  }

  func testTagForwardsFlexibility() {
    // `ViewProxy(width:)` is fixed horizontally and fully flexible vertically.
    let tagged = ViewProxy(width: 10).tag("x")

    XCTAssertEqual(tagged.quick_flexibility(for: .horizontal), .fixedSize)
    XCTAssertEqual(tagged.quick_flexibility(for: .vertical), .fullyFlexible)
  }

  func testTagForwardsLayoutPriority() {
    let tagged = ViewProxy(width: 10, height: 10).layoutPriority(7).tag("x")

    XCTAssertEqual(tagged.quick_layoutPriority(), 7)
  }

  func testTagForwardsIsSpacer() {
    XCTAssertTrue(Spacer().tag("x").quickInternal_isSpacer())
  }
}
