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
final class ViewTransformServerSnapshotTests: FBServerSnapshotTestCase {

  func testCustomAnchorPoints() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue
    view1.layer.anchorPoint = .zero

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow
    view1.layer.anchorPoint = CGPoint(x: 1.0, y: 1.0)

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.red
    view3.layer.anchorPoint = CGPoint(x: 0.5, y: 0.2)

    let layout = HStack {
      view1
        .frame(width: 50, height: 50)
      view2
        .frame(width: 50, height: 50)
      view3
        .frame(width: 50, height: 50)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testCustomAnchorPointsWithTransform() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue
    view1.layer.anchorPoint = .zero
    view1.transform = CGAffineTransformMakeScale(0.9, 0.9)

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow
    view1.layer.anchorPoint = CGPoint(x: 1.0, y: 1.0)
    view2.transform = CGAffineTransformMakeScale(0.9, 0.9)

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.red
    view3.transform = CGAffineTransformMakeScale(0.9, 0.9)

    let layout = HStack {
      view1
        .frame(width: 50, height: 50)
      view2
        .frame(width: 50, height: 50)
      view3
        .frame(width: 50, height: 50)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testScaleTransform() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue
    view1.transform = CGAffineTransformMakeScale(0.9, 0.9)

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow
    view2.transform = CGAffineTransformMakeScale(0.9, 0.9)

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.red
    view3.transform = CGAffineTransformMakeScale(0.9, 0.9)

    let layout = HStack {
      view1
        .frame(width: 50, height: 50)
      view2
        .frame(width: 50, height: 50)
      view3
        .frame(width: 50, height: 50)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testRotateTransform() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue
    view1.transform = CGAffineTransformMakeRotation(CGFloat.pi / 4)

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow
    view2.transform = CGAffineTransformMakeRotation(CGFloat.pi / 4)

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.red
    view3.transform = CGAffineTransformMakeRotation(CGFloat.pi / 4)

    let layout = HStack {
      view1
        .frame(width: 50, height: 50)
      view2
        .frame(width: 50, height: 50)
      view3
        .frame(width: 50, height: 50)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }
}
