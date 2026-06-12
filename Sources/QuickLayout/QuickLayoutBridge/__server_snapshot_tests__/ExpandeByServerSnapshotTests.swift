/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import FBServerSnapshotTestCase
import QuickLayoutBridge
import XCTest

@MainActor
final class ExpandByServerSnapshotTests: FBServerSnapshotTestCase {

  func testAspectRatioWithTextField() {

    let size = 20

    let firstView = ViewWithSize(customSize: CGSize(width: size, height: size))
    firstView.backgroundColor = ColorPallete.blue

    let view2 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view2.backgroundColor = ColorPallete.blue

    let view3 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view3.backgroundColor = ColorPallete.blue

    let view4 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view4.backgroundColor = ColorPallete.blue

    let view5 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view5.backgroundColor = ColorPallete.blue

    let view6 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view6.backgroundColor = ColorPallete.blue

    let view7 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view7.backgroundColor = ColorPallete.blue

    let lastView = ViewWithSize(customSize: CGSize(width: size, height: size))
    lastView.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 10) {
      firstView
      view2
        .expand(by: CGSize(width: size, height: size))
      view3
        .expand(by: CGSize(width: size, height: 0))
      view4
        .expand(by: CGSize(width: 0, height: size))
      view5
        .expand(by: CGSize(width: -100, height: 0))
      view6
        .expand(by: CGSize(width: CGFloat.nan, height: .nan)) // Invalid
      view7
        .expand(by: CGSize(width: CGFloat.infinity, height: .infinity)) // Invalid
      lastView
    }

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 300))
    )
  }
}
