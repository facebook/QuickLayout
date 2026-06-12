/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import FBServerSnapshotTestCase
import FBTestImageGenerator
import QuickLayoutBridge

private struct FirstThirdAlignment: AlignmentID {
  static func defaultValue(in context: ViewDimensions) -> CGFloat {
    context.height / 3
  }
}

@MainActor
final class CustomAlignmentServerSnaspshotTests: FBServerSnapshotTestCase {

  func testFirstThirdAlignment() {
    /// Expecting a 3x3 grid of blue rectangles.
    /// Rectangles having different heights, though they are aligned by the first third of their height.
    let colorViews = (1...9).map { _ in
      let view = UIView()
      view.backgroundColor = ColorPallete.blue
      return view
    }

    let layout = HStack(alignment: VerticalAlignment(FirstThirdAlignment.self), spacing: 2) {
      VStack(spacing: 2) {
        colorViews[0]
        colorViews[1]
        colorViews[2]
      }.frame(height: 140)
      VStack(spacing: 2) {
        colorViews[3]
        colorViews[4]
        colorViews[5]
      }.frame(height: 250)
      VStack(spacing: 2) {
        colorViews[6]
        colorViews[7]
        colorViews[8]
      }.frame(height: 180)
    }
    .padding(20)

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 300)),
      alignment: .center,
      containerBackground: .white
    )
  }
}
