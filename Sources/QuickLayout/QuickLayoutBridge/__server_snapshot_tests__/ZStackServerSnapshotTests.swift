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
final class ZStackServerSnaposhTests: FBServerSnapshotTestCase {

  func testSingleUIViewFlexible() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.yellow

    let layout = ZStack {
      view1
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200))
    )
  }

  func testSingleInflexibleUIView() {
    let view0 = UIView()
    view0.backgroundColor = ColorPallete.yellow

    let layout = ZStack {
      view0
        .frame(width: 100, height: 100)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200))
    )
  }

  func testTwoUIViewBothFlexible() {

    let view1 = UIView()
    view1.backgroundColor = ColorPallete.yellow
    let view2 = UIView()
    view2.backgroundColor = ColorPallete.blue

    let layout = ZStack {
      view1
      view2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200))
    )
  }

  func testTwoUIViewOneFlexible() {

    let view1 = UIView()
    view1.backgroundColor = ColorPallete.yellow
    let view2 = UIView()
    view2.backgroundColor = ColorPallete.blue

    let layout = ZStack {
      view1
      view2
        .frame(width: 100, height: 100)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200))
    )
  }

  func runTestWithSingleView(alignment: Alignment) {
    let view0 = UIView()
    view0.backgroundColor = ColorPallete.yellow

    let layout = ZStack(alignment: alignment) {
      view0
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200))
    )
  }

  func testTwoInflexibleUIView() {

    let view0 = UIView()
    view0.backgroundColor = ColorPallete.yellow

    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue
    let view2 = UIView()
    view2.backgroundColor = ColorPallete.orange

    let layout = ZStack {
      view0
      view1
        .frame(width: 100, height: 100)
      view2
        .frame(width: 50, height: 50)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200))
    )
  }

  func runTestWith(alignment: Alignment) {
    let view0 = UIView()
    view0.backgroundColor = ColorPallete.yellow

    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue
    let view2 = UIView()
    view2.backgroundColor = ColorPallete.orange

    let layout = ZStack(alignment: alignment) {
      view0
      view1
        .frame(width: 100, height: 100)
      view2
        .frame(width: 50, height: 50)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200))
    )
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

  func testCenterAlignment_SingleView() {
    runTestWithSingleView(alignment: .center)
  }

  func testTopLeadingAlignment_SingleView() {
    runTestWithSingleView(alignment: .topLeading)
  }

  func testTopAlignment_SingleView() {
    runTestWithSingleView(alignment: .top)
  }
}
