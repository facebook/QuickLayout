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
final class ForEachServerSnaposhTests: FBServerSnapshotTestCase {

  func testForEach() {

    let size = 20

    let view1 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view1.backgroundColor = ColorPallete.blue

    let view2 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view2.backgroundColor = ColorPallete.blue

    let view3 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 20) {
      ForEach([view1, view2, view3])
    }

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 300))
    )
  }

  func testForEachWithViewBlock() {

    let size = 20

    let view1 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view1.backgroundColor = ColorPallete.blue

    let view2 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view2.backgroundColor = ColorPallete.blue

    let view3 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 20) {
      view1
      ForEach([view2, view3]) { view in
        view.resizable().frame(width: 30, height: 30)
      }
    }

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 300))
    )
  }

  func testForEachWithViewElementBlock() {

    let size = 20

    let view1 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view1.backgroundColor = ColorPallete.blue

    let view2 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view2.backgroundColor = ColorPallete.blue

    let view3 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 20) {
      view1
      ForEach([view2.padding(.top, 8), view3.padding(.top, 8)]) { element in
        element.offset(y: -16)
      }
    }

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 300))
    )
  }

  func testForLoop() {

    let size = 20

    let view1 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view1.backgroundColor = ColorPallete.blue

    let view2 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view2.backgroundColor = ColorPallete.blue

    let view3 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 20) {
      for view in [view1, view2, view3] {
        view
      }
    }

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 300))
    )
  }

  func testForLoopWithModifiers() {

    let size = 20

    let view1 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view1.backgroundColor = ColorPallete.blue

    let view2 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view2.backgroundColor = ColorPallete.blue

    let view3 = ViewWithSize(customSize: CGSize(width: size, height: size))
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 20) {
      view1
      for view in [view2, view3] {
        view
          .resizable()
          .frame(width: 30, height: 30)
      }
    }

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 300))
    )
  }
}
