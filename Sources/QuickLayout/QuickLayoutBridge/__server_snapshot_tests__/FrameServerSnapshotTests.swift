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
final class FrameServerSnaposhTests: FBServerSnapshotTestCase {

  func testFrameAlignment() {

    let size = CGSize(width: 100, height: 100)

    let view1 = UIImageView(image: generateTestImage(with: "1", size: size))
    let view2 = UIImageView(image: generateTestImage(with: "2", size: size))
    let view3 = UIImageView(image: generateTestImage(with: "3", size: size))
    let view4 = UIImageView(image: generateTestImage(with: "4", size: size))
    let view5 = UIImageView(image: generateTestImage(with: "5", size: size))
    let view6 = UIImageView(image: generateTestImage(with: "6", size: size))
    let view7 = UIImageView(image: generateTestImage(with: "7", size: size))
    let view8 = UIImageView(image: generateTestImage(with: "8", size: size))
    let view9 = UIImageView(image: generateTestImage(with: "9", size: size))

    let frameSize = CGSize(width: size.width * 3, height: size.height * 3)
    let layout = ZStack {
      view1
        .frame(width: frameSize.width, height: frameSize.height, alignment: .topLeading)
      view2
        .frame(width: frameSize.width, height: frameSize.height, alignment: .top)
      view3
        .frame(width: frameSize.width, height: frameSize.height, alignment: .topTrailing)
      view4
        .frame(width: frameSize.width, height: frameSize.height, alignment: .leading)
      view5
        .frame(width: frameSize.width, height: frameSize.height, alignment: .center)
      view6
        .frame(width: frameSize.width, height: frameSize.height, alignment: .trailing)
      view7
        .frame(width: frameSize.width, height: frameSize.height, alignment: .bottomLeading)
      view8
        .frame(width: frameSize.width, height: frameSize.height, alignment: .bottom)
      view9
        .frame(width: frameSize.width, height: frameSize.height, alignment: .bottomTrailing)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(frameSize)
    )
  }

  func testFrameTruncatesLabel() {
    let view1 = UILabel()
    view1.text = "This is a very long label"

    let view2 = UILabel()
    view2.text = "This is a very long label"

    let layout = VStack(alignment: .leading) {
      view1
      view2
        .frame(width: 100)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 480))
    )
  }

  func testFrameLimitsUIViewSize() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let layout = VStack(alignment: .leading) {
      view1
        .frame(width: 100, height: 100)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 480))
    )
  }

  func testFrameLimitsUIViewSizeHorizontally() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let layout = VStack(alignment: .leading) {
      view1
        .frame(width: 100)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 320))
    )
  }

  func testFrameLimitsUIViewSizeVertically() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let layout = VStack(alignment: .leading) {
      view1
        .frame(height: 100)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 320))
    )
  }
}
