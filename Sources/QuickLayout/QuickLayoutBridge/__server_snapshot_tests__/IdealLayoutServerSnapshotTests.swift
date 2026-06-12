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
final class IdealLayoutServerSnapshotTests: FBServerSnapshotTestCase {

  func testEqualWidthLabels() {
    let view1 = UILabel()
    view1.text = "Lorem ipsum dolor"
    view1.textColor = .white
    view1.backgroundColor = ColorPallete.red

    let view2 = UILabel()
    view2.text = "ipsum"
    view2.textColor = .white
    view2.backgroundColor = ColorPallete.blue

    let layout = VStack {
      view1
        .resizable(axis: .horizontal)
      Spacer(8)
      view2
        .resizable(axis: .horizontal)
    }
    .idealLayout()

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 50))
    )
  }

  func testEqualWidthSingleLabel() {
    let view1 = UILabel()
    view1.text = "Lorem"
    view1.textColor = .white
    view1.backgroundColor = ColorPallete.red

    let layout = VStack {
      view1
        .resizable(axis: .horizontal)
    }
    .idealLayout()

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 50))
    )
  }

  func testEqualWidthTwoLabelGetsTruncated() {
    let view1 = UILabel()
    view1.text = "Lorem ipsum dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor"
    view1.textColor = .white
    view1.backgroundColor = ColorPallete.red

    let view2 = UILabel()
    view2.text = "ipsum"
    view2.textColor = .white
    view2.backgroundColor = ColorPallete.blue

    let layout = VStack {
      view1
        .resizable(axis: .horizontal)
      Spacer(8)
      view2
        .resizable(axis: .horizontal)
    }
    .idealLayout()

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 100, height: 50))
    )
  }

  func testEqualWidthSingleLabelGetsTruncated() {
    let view1 = UILabel()
    view1.text = "Lorem ipsum dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor dolor"
    view1.textColor = .white
    view1.backgroundColor = ColorPallete.red

    let layout = VStack {
      view1
        .resizable(axis: .horizontal)
    }
    .idealLayout()

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 100, height: 50))
    )
  }

  func testEqualHeightLabels() {
    let view1 = UILabel()
    view1.text = "Lorem\nipsum\ndolor"
    view1.textColor = .white
    view1.numberOfLines = 0
    view1.backgroundColor = ColorPallete.red

    let view2 = UILabel()
    view2.text = "ipsum"
    view2.textColor = .white
    view2.backgroundColor = ColorPallete.blue

    let layout = HStack {
      view1
        .resizable(axis: .vertical)
      Spacer(8)
      view2
        .resizable(axis: .vertical)
    }
    .idealLayout()

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 100))
    )
  }

  func testEqualHeightLayouts() {
    let view1 = UILabel()
    view1.text = "Lorem\nipsum\ndolor\ndolor\ndolor"
    view1.textColor = .white
    view1.numberOfLines = 0
    view1.backgroundColor = ColorPallete.red

    let view2 = UILabel()
    view2.text = "ipsum"
    view2.textColor = .white
    view2.backgroundColor = ColorPallete.blue

    let view3 = UILabel()
    view3.text = "ipsum"
    view3.textColor = .white
    view3.backgroundColor = ColorPallete.orange

    let layout = HStack {
      view1
        .resizable(axis: .vertical)
      Spacer(8)

      VStack {
        view2
        Spacer()
        view3
      }
    }
    .idealLayout()

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 500, height: 500))
    )
  }

  func testEqualWidthClampedToProposedSize() {
    let view1 = UILabel()
    view1.text = "Lorem ipsum dolor dolor dolor dolor"
    view1.textColor = .white
    view1.backgroundColor = ColorPallete.red

    let view2 = UILabel()
    view2.text = "ipsum"
    view2.textColor = .white
    view2.backgroundColor = ColorPallete.blue

    let layout = VStack {
      view1
        .resizable(axis: .horizontal)
      Spacer(8)
      view2
        .resizable(axis: .horizontal)
    }
    .idealLayout()
    .frame(width: 200)

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 50))
    )
  }

  func testFixedSizeViews() {
    let view1 = ViewWithSize(customSize: CGSize(width: 50, height: 50))
    view1.backgroundColor = ColorPallete.red

    let view2 = ViewWithSize(customSize: CGSize(width: 50, height: 50))
    view2.backgroundColor = ColorPallete.blue

    let layout = VStack {
      view1
      Spacer(8)
      view2
    }
    .idealLayout()

    _ = layout.sizeThatFits(CGSize(width: 300, height: 300))
    XCTAssertEqual(view1.proposedSizes.count, 1)
    XCTAssertEqual(view2.proposedSizes.count, 1)

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }
}
