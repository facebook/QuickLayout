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
final class ResizableServerSnaposhTests: FBServerSnapshotTestCase {

  func testResizableWithUIImage() {

    let view1 = UIImageView(image: FBTestImageGenerator.image(with: ColorPallete.blue, size: CGSize(width: 50, height: 50)))
    let view2 = UIImageView(image: FBTestImageGenerator.image(with: ColorPallete.yellow, size: CGSize(width: 50, height: 50)))

    let layout = HStack {
      view1
      view2
        .resizable()
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 100))
    )
  }

  func testResizableWithUIButton() {

    let view1 = UIButton(type: .system)
    view1.setTitle("Button 1", for: .normal)
    view1.setTitleColor(.white, for: .normal)
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIButton(type: .system)
    view2.setTitle("Button 2", for: .normal)
    view2.setTitleColor(.white, for: .normal)
    view2.backgroundColor = ColorPallete.yellow

    let layout = HStack {
      view1
      view2
        .resizable()
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 100))
    )
  }

  func testResizableWithCustomView() {

    let view1 = ViewWithSize(customSize: CGSize(width: 50, height: 50))
    view1.backgroundColor = ColorPallete.blue

    let view2 = ViewWithSize(customSize: CGSize(width: 50, height: 50))
    view2.backgroundColor = ColorPallete.yellow

    let layout = HStack {
      view1
      view2
        .resizable()
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 100))
    )
  }

  func testResizableWithCustomView_resizeOnlyVertically() {

    let view1 = ViewWithSize(customSize: CGSize(width: 50, height: 50))
    view1.backgroundColor = ColorPallete.blue

    let view2 = ViewWithSize(customSize: CGSize(width: 50, height: 50))
    view2.backgroundColor = ColorPallete.yellow

    let layout = HStack {
      view1
      view2
        .resizable(axis: .vertical)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 100))
    )
  }

  func testResizableWithCustomView_resizeOnlyHorizontally() {

    let view1 = ViewWithSize(customSize: CGSize(width: 50, height: 50))
    view1.backgroundColor = ColorPallete.blue

    let view2 = ViewWithSize(customSize: CGSize(width: 50, height: 30))
    view2.backgroundColor = ColorPallete.yellow

    let layout = HStack {
      view1
      view2
        .resizable(axis: .horizontal)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 100))
    )
  }
}
