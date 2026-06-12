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
final class PaddingServerSnaposhTests: FBServerSnapshotTestCase {

  func testPaddingAll() {

    let size = CGSize(width: 100, height: 100)

    let view1 = UIImageView(image: generateTestImage(with: "1", size: size))

    let layout = ZStack {
      view1
        .padding(.top, 20)
        .padding(.leading, 10)
        .padding(.bottom, 80)
        .padding(.trailing, 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200)),
      containerBackground: ColorPallete.yellow
    )
  }

  func testPaddingTop() {

    let size = CGSize(width: 100, height: 100)

    let view1 = UIImageView(image: generateTestImage(with: "1", size: size))

    let layout = ZStack {
      view1
        .padding(.top, 20)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200)),
      containerBackground: ColorPallete.yellow
    )
  }

  func testPaddingLeading() {

    let size = CGSize(width: 100, height: 100)

    let view1 = UIImageView(image: generateTestImage(with: "1", size: size))

    let layout = ZStack {
      view1
        .padding(.leading, 20)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200)),
      containerBackground: ColorPallete.yellow
    )
  }

  func testPaddingTrailing() {

    let size = CGSize(width: 100, height: 100)

    let view1 = UIImageView(image: generateTestImage(with: "1", size: size))

    let layout = ZStack {
      view1
        .padding(.trailing, 20)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200)),
      containerBackground: ColorPallete.yellow
    )
  }

  func testPaddingBottom() {

    let size = CGSize(width: 100, height: 100)

    let view1 = UIImageView(image: generateTestImage(with: "1", size: size))

    let layout = ZStack {
      view1
        .padding(.bottom, 20)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200)),
      containerBackground: ColorPallete.yellow
    )
  }

  func testPaddingHorizontal() {

    let size = CGSize(width: 100, height: 100)

    let view1 = UIImageView(image: generateTestImage(with: "1", size: size))

    let layout = ZStack {
      view1
        .padding(.horizontal, 20)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200)),
      containerBackground: ColorPallete.yellow
    )
  }

  func testPaddingVertical() {

    let size = CGSize(width: 100, height: 100)

    let view1 = UIImageView(image: generateTestImage(with: "1", size: size))

    let layout = ZStack {
      view1
        .padding(.vertical, 20)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200)),
      containerBackground: ColorPallete.yellow
    )
  }

  func testPaddingTLTB() {

    let size = CGSize(width: 100, height: 100)

    let view1 = UIImageView(image: generateTestImage(with: "1", size: size))

    let layout = ZStack {
      view1
        .padding([.top, .leading, .trailing, .bottom], 20)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200)),
      containerBackground: ColorPallete.yellow
    )
  }

  func testPaddingLeadingTrailing() {

    let size = CGSize(width: 100, height: 100)

    let view1 = UIImageView(image: generateTestImage(with: "1", size: size))

    let layout = ZStack {
      view1
        .padding([.leading, .trailing], 20)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200)),
      containerBackground: ColorPallete.yellow
    )
  }

  func testPaddingTopBottom() {

    let size = CGSize(width: 100, height: 100)

    let view1 = UIImageView(image: generateTestImage(with: "1", size: size))

    let layout = ZStack {
      view1
        .padding([.top, .bottom], 20)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200)),
      containerBackground: ColorPallete.yellow
    )
  }
}
