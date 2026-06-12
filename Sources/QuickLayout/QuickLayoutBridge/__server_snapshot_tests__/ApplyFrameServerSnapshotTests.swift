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
final class ApplyFramyServerSnapshotTests: FBServerSnapshotTestCase {

  private func runTestWith(alignment: Alignment?) {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let layout = HStack {
      view1
        .frame(width: 100, height: 100)
    }

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 300)),
      alignment: alignment,
      containerBackground: ColorPallete.blue
    )
  }

  func testDefaultAlignment() {
    runTestWith(alignment: nil)
  }

  func testCenterAlignment() {
    runTestWith(alignment: .center)
  }

  func testTopLeadingAlignment() {
    runTestWith(alignment: .topLeading)
  }

  func testTopAlignment() {
    runTestWith(alignment: .top)
  }

  func testTopTrailingAlignment() {
    runTestWith(alignment: .topTrailing)
  }

  func testLeadingAlignment() {
    runTestWith(alignment: .leading)
  }

  func testTrailingAlignment() {
    runTestWith(alignment: .trailing)
  }

  func testBottomTrailingAlignment() {
    runTestWith(alignment: .bottomTrailing)
  }

  func testBottomLeadingAlignment() {
    runTestWith(alignment: .bottomLeading)
  }

  func testBottomAlignment() {
    runTestWith(alignment: .bottom)
  }
}
