/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import FBServerSnapshotTestCase
import FBTestImageGenerator
import QuickLayoutBridge

private final class QuickIntrinsicSizeRangeView: UIView {

  var layout: Layout = EmptyLayout()

  override func layoutSubviews() {
    super.layoutSubviews()
    layout.applyFrame(bounds)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return layout.sizeThatFits(size)
  }
}

@MainActor
final class NestedViewsWithIntrinsizeSizeRangeImplementationServerSnapshotTests: FBServerSnapshotTestCase {

  func testWithNestedViewsThaContainsLayoutWithHStacks() {

    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let parentView1 = QuickIntrinsicSizeRangeView()
    parentView1.layout = HStack {
      view1
    }
    parentView1.addSubview(view1)

    let label1 = UILabel()
    label1.text = "Nam id n"
    label1.numberOfLines = 0

    let parentView2 = QuickIntrinsicSizeRangeView()
    parentView2.layout = HStack {
      label1
    }
    parentView2.addSubview(label1)

    let layout = HStack {
      parentView1
      Spacer(8)
      parentView2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 100))
    )
  }

  func testWithNestedViewsThaContainsLayoutWithZStacks() {

    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let parentView1 = QuickIntrinsicSizeRangeView()
    parentView1.layout = ZStack {
      view1
    }
    parentView1.addSubview(view1)

    let label1 = UILabel()
    label1.text = "Nam id n"
    label1.numberOfLines = 0

    let parentView2 = QuickIntrinsicSizeRangeView()
    parentView2.layout = ZStack {
      label1
    }
    parentView2.addSubview(label1)

    let layout = HStack {
      parentView1
      Spacer(8)
      parentView2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 100))
    )
  }

  func testWithNestedViewsWithHStackAndSpacer() {

    let label1 = UILabel()
    label1.text = "1"

    let label2 = UILabel()
    label2.text = "1"

    let parentView1 = QuickIntrinsicSizeRangeView()
    parentView1.layout = HStack {
      label1
      Spacer()
      label2
    }
    parentView1.addSubview(label1)
    parentView1.addSubview(label2)
    parentView1.backgroundColor = ColorPallete.blue

    let label3 = UILabel()
    label3.text = "Nam id n"
    label3.numberOfLines = 0

    let parentView2 = QuickIntrinsicSizeRangeView()
    parentView2.layout = HStack {
      label3
    }
    parentView2.addSubview(label3)

    let layout = HStack {
      parentView1
      Spacer(8)
      parentView2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 100))
    )
  }
}
