/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import FBServerSnapshotTestCase
import FBTestImageGenerator
import QuickLayoutBridge

@MainActor
final class HStackServerSnapshotTests: FBServerSnapshotTestCase {

  private func runTest(alignment: VerticalAlignment) {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.red

    let layout = HStack(alignment: alignment) {
      view1
        .frame(width: 100, height: 100)
      view2
        .frame(width: 80, height: 80)
      view3
        .frame(width: 40, height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testAlignmentCenter() {
    runTest(alignment: .center)
  }

  func testAlignmentTop() {
    runTest(alignment: .top)
  }

  func testAlignmentBottom() {
    runTest(alignment: .bottom)
  }
}
