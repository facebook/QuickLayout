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
final class EmptyLayoutServerSnapshotTests: FBServerSnapshotTestCase {

  func testEmptyLayoutWhenUsedInStack() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.blue

    let layout = HStack {

      view1
        .resizable()
        .frame(width: 50, height: 50)

      // EmptyLayouts shouldn't affect the positioning of the views
      EmptyLayout()
      EmptyLayout()
      EmptyLayout()
      EmptyLayout()
      EmptyLayout()

      view2
        .resizable()
        .frame(width: 50, height: 50)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 50))
    )
  }

  func testEmptyLayoutWhenUsedAsLayout() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.blue

    takeSnapshot(
      with: EmptyLayout(),
      in: .exact(CGSize(width: 300, height: 50))
    )
  }
}
