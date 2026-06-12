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
final class OffsetServerSnapshotTests: FBServerSnapshotTestCase {

  func testOffset() {

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

    let lastView = ViewWithSize(customSize: CGSize(width: size, height: size))
    lastView.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 20) {
      firstView
      view2
        .offset(x: -10, y: 0)
      view3
        .offset(x: 10, y: 0)
      view4
        .offset(x: 0, y: 10)
      view5
        .offset(x: 0, y: -10)
      view6
        .offset(x: .infinity, y: .infinity) // should be ignored
      lastView
    }

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 300))
    )
  }
}
