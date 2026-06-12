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
final class FlexibleFrameServerSnaposhTests: FBServerSnapshotTestCase {

  func testFrameWithoutConstraints() {
    let view1 = ColorView(ColorPallete.yellow, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.yellow, text: "3")
    let view4 = ColorView(ColorPallete.yellow, text: "4")

    let borderView1 = BorderView()
    let borderView2 = BorderView()
    let borderView3 = BorderView()
    let borderView4 = BorderView()

    let layout = VStack(spacing: 10) {
      view1
        .frame(width: 50)
        .frame(minWidth: nil, maxWidth: nil)
        .overlay { borderView1 }
        .frame(width: 150)
        .frame(height: 20)

      view2
        .frame(width: 100)
        .frame(minWidth: nil, maxWidth: nil)
        .overlay { borderView2 }
        .frame(width: 150)
        .frame(height: 20)

      view3
        .frame(width: 200)
        .frame(minWidth: nil, maxWidth: nil)
        .overlay { borderView3 }
        .frame(width: 150)
        .frame(height: 20)

      view4
        .frame(width: 250)
        .frame(minWidth: nil, maxWidth: nil)
        .overlay { borderView4 }
        .frame(width: 150)
        .frame(height: 20)
    }
    .frame(width: 320)

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 320))
    )
  }

  func testFrameWithBothConstraints() {
    let view1 = ColorView(ColorPallete.yellow, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.yellow, text: "3")
    let view4 = ColorView(ColorPallete.yellow, text: "4")
    let view5 = ColorView(ColorPallete.yellow, text: "5")
    let view6 = ColorView(ColorPallete.yellow, text: "6")
    let view7 = ColorView(ColorPallete.yellow, text: "7")
    let view8 = ColorView(ColorPallete.yellow, text: "8")
    let view9 = ColorView(ColorPallete.yellow, text: "9")

    let borderView1 = BorderView()
    let borderView2 = BorderView()
    let borderView3 = BorderView()
    let borderView4 = BorderView()
    let borderView5 = BorderView()
    let borderView6 = BorderView()
    let borderView7 = BorderView()
    let borderView8 = BorderView()
    let borderView9 = BorderView()

    let layout = VStack(alignment: .center, spacing: 10) {
      view1
        .frame(width: 40)
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView1 }
        .frame(width: 50)
        .frame(height: 20)

      view2
        .frame(width: 40)
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView2 }
        .frame(width: 150)
        .frame(height: 20)

      view3
        .frame(width: 40)
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView3 }
        .frame(width: 250)
        .frame(height: 20)

      view4
        .frame(width: 160)
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView4 }
        .frame(width: 50)
        .frame(height: 20)

      view5
        .frame(width: 160)
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView5 }
        .frame(width: 150)
        .frame(height: 20)

      view6
        .frame(width: 160)
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView6 }
        .frame(width: 250)
        .frame(height: 20)

      view7
        .frame(width: 260)
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView7 }
        .frame(width: 50)
        .frame(height: 20)

      view8
        .frame(width: 260)
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView8 }
        .frame(width: 150)
        .frame(height: 20)

      view9
        .frame(width: 260)
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView9 }
        .frame(width: 250)
        .frame(height: 20)
    }
    .frame(width: 320)

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 320))
    )
  }

  func testFrameWithBothConstraintsAndFlexibleChild() {
    let view1 = ColorView(ColorPallete.yellow, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.yellow, text: "3")
    let view4 = ColorView(ColorPallete.yellow, text: "4")
    let view5 = ColorView(ColorPallete.yellow, text: "5")
    let view6 = ColorView(ColorPallete.yellow, text: "6")
    let view7 = ColorView(ColorPallete.yellow, text: "7")
    let view8 = ColorView(ColorPallete.yellow, text: "8")
    let view9 = ColorView(ColorPallete.yellow, text: "9")

    let borderView1 = BorderView()
    let borderView2 = BorderView()
    let borderView3 = BorderView()
    let borderView4 = BorderView()
    let borderView5 = BorderView()
    let borderView6 = BorderView()
    let borderView7 = BorderView()
    let borderView8 = BorderView()
    let borderView9 = BorderView()

    let layout = VStack(alignment: .center, spacing: 10) {
      view1
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView1 }
        .frame(width: 50)
        .frame(height: 20)

      view2
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView2 }
        .frame(width: 150)
        .frame(height: 20)

      view3
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView3 }
        .frame(width: 250)
        .frame(height: 20)

      view4
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView4 }
        .frame(width: 50)
        .frame(height: 20)

      view5
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView5 }
        .frame(width: 150)
        .frame(height: 20)

      view6
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView6 }
        .frame(width: 250)
        .frame(height: 20)

      view7
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView7 }
        .frame(width: 50)
        .frame(height: 20)

      view8
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView8 }
        .frame(width: 150)
        .frame(height: 20)

      view9
        .frame(minWidth: 100, maxWidth: 200)
        .overlay { borderView9 }
        .frame(width: 250)
        .frame(height: 20)
    }
    .frame(width: 320)

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 320))
    )
  }

  func testFrameWithMinOnly() {
    let view1 = ColorView(ColorPallete.yellow, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.yellow, text: "3")
    let view4 = ColorView(ColorPallete.yellow, text: "4")
    let view5 = ColorView(ColorPallete.yellow, text: "5")
    let view6 = ColorView(ColorPallete.yellow, text: "6")
    let view7 = ColorView(ColorPallete.yellow, text: "7")
    let view8 = ColorView(ColorPallete.yellow, text: "8")
    let view9 = ColorView(ColorPallete.yellow, text: "9")

    let borderView1 = BorderView()
    let borderView2 = BorderView()
    let borderView3 = BorderView()
    let borderView4 = BorderView()
    let borderView5 = BorderView()
    let borderView6 = BorderView()
    let borderView7 = BorderView()
    let borderView8 = BorderView()
    let borderView9 = BorderView()

    let layout = VStack(alignment: .center, spacing: 10) {
      view1
        .frame(width: 40)
        .frame(minWidth: 100)
        .overlay { borderView1 }
        .frame(width: 50)
        .frame(height: 20)

      view2
        .frame(width: 40)
        .frame(minWidth: 100)
        .overlay { borderView2 }
        .frame(width: 150)
        .frame(height: 20)

      view3
        .frame(width: 40)
        .frame(minWidth: 100)
        .overlay { borderView3 }
        .frame(width: 250)
        .frame(height: 20)

      view4
        .frame(width: 160)
        .frame(minWidth: 100)
        .overlay { borderView4 }
        .frame(width: 50)
        .frame(height: 20)

      view5
        .frame(width: 160)
        .frame(minWidth: 100)
        .overlay { borderView5 }
        .frame(width: 150)
        .frame(height: 20)

      view6
        .frame(width: 160)
        .frame(minWidth: 100)
        .overlay { borderView6 }
        .frame(width: 250)
        .frame(height: 20)

      view7
        .frame(width: 260)
        .frame(minWidth: 100)
        .overlay { borderView7 }
        .frame(width: 50)
        .frame(height: 20)

      view8
        .frame(width: 260)
        .frame(minWidth: 100)
        .overlay { borderView8 }
        .frame(width: 150)
        .frame(height: 20)

      view9
        .frame(width: 260)
        .frame(minWidth: 100)
        .overlay { borderView9 }
        .frame(width: 250)
        .frame(height: 20)
    }
    .frame(width: 320)

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 320))
    )
  }

  func testFrameWithMinOnlyFullyFlexibleChild() {
    let view1 = ColorView(ColorPallete.yellow, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.yellow, text: "3")
    let view4 = ColorView(ColorPallete.yellow, text: "4")
    let view5 = ColorView(ColorPallete.yellow, text: "5")
    let view6 = ColorView(ColorPallete.yellow, text: "6")
    let view7 = ColorView(ColorPallete.yellow, text: "7")
    let view8 = ColorView(ColorPallete.yellow, text: "8")
    let view9 = ColorView(ColorPallete.yellow, text: "9")

    let borderView1 = BorderView()
    let borderView2 = BorderView()
    let borderView3 = BorderView()
    let borderView4 = BorderView()
    let borderView5 = BorderView()
    let borderView6 = BorderView()
    let borderView7 = BorderView()
    let borderView8 = BorderView()
    let borderView9 = BorderView()

    let layout = VStack(alignment: .center, spacing: 10) {
      view1
        .frame(minWidth: 100)
        .overlay { borderView1 }
        .frame(width: 50)
        .frame(height: 20)

      view2
        .frame(minWidth: 100)
        .overlay { borderView2 }
        .frame(width: 150)
        .frame(height: 20)

      view3
        .frame(minWidth: 100)
        .overlay { borderView3 }
        .frame(width: 250)
        .frame(height: 20)

      view4
        .frame(minWidth: 100)
        .overlay { borderView4 }
        .frame(width: 50)
        .frame(height: 20)

      view5
        .frame(minWidth: 100)
        .overlay { borderView5 }
        .frame(width: 150)
        .frame(height: 20)

      view6
        .frame(minWidth: 100)
        .overlay { borderView6 }
        .frame(width: 250)
        .frame(height: 20)

      view7
        .frame(minWidth: 100)
        .overlay { borderView7 }
        .frame(width: 50)
        .frame(height: 20)

      view8
        .frame(minWidth: 100)
        .overlay { borderView8 }
        .frame(width: 150)
        .frame(height: 20)

      view9
        .frame(minWidth: 100)
        .overlay { borderView9 }
        .frame(width: 250)
        .frame(height: 20)
    }
    .frame(width: 320)

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 320))
    )
  }

  func testFrameWithMaxOnly() {
    let view1 = ColorView(ColorPallete.yellow, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.yellow, text: "3")
    let view4 = ColorView(ColorPallete.yellow, text: "4")
    let view5 = ColorView(ColorPallete.yellow, text: "5")
    let view6 = ColorView(ColorPallete.yellow, text: "6")
    let view7 = ColorView(ColorPallete.yellow, text: "7")
    let view8 = ColorView(ColorPallete.yellow, text: "8")
    let view9 = ColorView(ColorPallete.yellow, text: "9")

    let borderView1 = BorderView()
    let borderView2 = BorderView()
    let borderView3 = BorderView()
    let borderView4 = BorderView()
    let borderView5 = BorderView()
    let borderView6 = BorderView()
    let borderView7 = BorderView()
    let borderView8 = BorderView()
    let borderView9 = BorderView()

    let layout = VStack(alignment: .center, spacing: 10) {
      view1
        .frame(width: 40)
        .frame(maxWidth: 200)
        .overlay { borderView1 }
        .frame(width: 50)
        .frame(height: 20)

      view2
        .frame(width: 40)
        .frame(maxWidth: 200)
        .overlay { borderView2 }
        .frame(width: 150)
        .frame(height: 20)

      view3
        .frame(width: 40)
        .frame(maxWidth: 200)
        .overlay { borderView3 }
        .frame(width: 250)
        .frame(height: 20)

      view4
        .frame(width: 160)
        .frame(maxWidth: 200)
        .overlay { borderView4 }
        .frame(width: 50)
        .frame(height: 20)

      view5
        .frame(width: 160)
        .frame(maxWidth: 200)
        .overlay { borderView5 }
        .frame(width: 150)
        .frame(height: 20)

      view6
        .frame(width: 160)
        .frame(maxWidth: 200)
        .overlay { borderView6 }
        .frame(width: 250)
        .frame(height: 20)

      view7
        .frame(width: 260)
        .frame(maxWidth: 200)
        .overlay { borderView7 }
        .frame(width: 50)
        .frame(height: 20)

      view8
        .frame(width: 260)
        .frame(maxWidth: 200)
        .overlay { borderView8 }
        .frame(width: 150)
        .frame(height: 20)

      view9
        .frame(width: 260)
        .frame(maxWidth: 200)
        .overlay { borderView9 }
        .frame(width: 250)
        .frame(height: 20)
    }
    .frame(width: 320)

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 320))
    )
  }

  func testFrameWithMaxOnlyFullyFlexibleChild() {
    let view1 = ColorView(ColorPallete.yellow, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.yellow, text: "3")
    let view4 = ColorView(ColorPallete.yellow, text: "4")
    let view5 = ColorView(ColorPallete.yellow, text: "5")
    let view6 = ColorView(ColorPallete.yellow, text: "6")
    let view7 = ColorView(ColorPallete.yellow, text: "7")
    let view8 = ColorView(ColorPallete.yellow, text: "8")
    let view9 = ColorView(ColorPallete.yellow, text: "9")

    let borderView1 = BorderView()
    let borderView2 = BorderView()
    let borderView3 = BorderView()
    let borderView4 = BorderView()
    let borderView5 = BorderView()
    let borderView6 = BorderView()
    let borderView7 = BorderView()
    let borderView8 = BorderView()
    let borderView9 = BorderView()

    let layout = VStack(alignment: .center, spacing: 10) {
      view1
        .frame(maxWidth: 200)
        .overlay { borderView1 }
        .frame(width: 50)
        .frame(height: 20)

      view2
        .frame(maxWidth: 200)
        .overlay { borderView2 }
        .frame(width: 150)
        .frame(height: 20)

      view3
        .frame(maxWidth: 200)
        .overlay { borderView3 }
        .frame(width: 250)
        .frame(height: 20)

      view4
        .frame(maxWidth: 200)
        .overlay { borderView4 }
        .frame(width: 50)
        .frame(height: 20)

      view5
        .frame(maxWidth: 200)
        .overlay { borderView5 }
        .frame(width: 150)
        .frame(height: 20)

      view6
        .frame(maxWidth: 200)
        .overlay { borderView6 }
        .frame(width: 250)
        .frame(height: 20)

      view7
        .frame(maxWidth: 200)
        .overlay { borderView7 }
        .frame(width: 50)
        .frame(height: 20)

      view8
        .frame(maxWidth: 200)
        .overlay { borderView8 }
        .frame(width: 150)
        .frame(height: 20)

      view9
        .frame(maxWidth: 200)
        .overlay { borderView9 }
        .frame(width: 250)
        .frame(height: 20)
    }
    .frame(width: 320)

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 320))
    )
  }

  func testFrameAlignment() {
    let view1 = ColorView(ColorPallete.yellow, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.yellow, text: "3")
    let view4 = ColorView(ColorPallete.yellow, text: "4")
    let view5 = ColorView(ColorPallete.yellow, text: "5")
    let view6 = ColorView(ColorPallete.yellow, text: "6")
    let view7 = ColorView(ColorPallete.yellow, text: "7")
    let view8 = ColorView(ColorPallete.yellow, text: "8")
    let view9 = ColorView(ColorPallete.yellow, text: "9")
    let view10 = ColorView(ColorPallete.yellow, text: "10")
    let view11 = ColorView(ColorPallete.yellow, text: "11")
    let view12 = ColorView(ColorPallete.yellow, text: "12")

    let borderView1 = BorderView()
    let borderView2 = BorderView()
    let borderView3 = BorderView()
    let borderView4 = BorderView()
    let borderView5 = BorderView()
    let borderView6 = BorderView()
    let borderView7 = BorderView()
    let borderView8 = BorderView()
    let borderView9 = BorderView()
    let borderView10 = BorderView()
    let borderView11 = BorderView()
    let borderView12 = BorderView()

    let borderView1_1 = BorderView()
    let borderView1_2 = BorderView()
    let borderView1_3 = BorderView()
    let borderView1_4 = BorderView()
    let borderView1_5 = BorderView()
    let borderView1_6 = BorderView()
    let borderView1_7 = BorderView()
    let borderView1_8 = BorderView()
    let borderView1_9 = BorderView()
    let borderView1_10 = BorderView()
    let borderView1_11 = BorderView()
    let borderView1_12 = BorderView()

    let layout = VStack(spacing: 10) {
      view1
        .frame(width: 150)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        .overlay { borderView1 }
        .frame(width: 50)
        .frame(height: 20)
        .overlay { borderView1_1 }

      view2
        .frame(width: 150)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .overlay { borderView2 }
        .frame(width: 50)
        .frame(height: 20)
        .overlay { borderView1_2 }

      view3
        .frame(width: 150)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
        .overlay { borderView3 }
        .frame(width: 50)
        .frame(height: 20)
        .overlay { borderView1_3 }

      view4
        .frame(width: 150)
        .frame(minWidth: 0, alignment: .center)
        .overlay { borderView4 }
        .frame(width: 50)
        .frame(height: 20)
        .overlay { borderView1_4 }

      view5
        .frame(width: 150)
        .frame(minWidth: 0, alignment: .leading)
        .overlay { borderView5 }
        .frame(width: 50)
        .frame(height: 20)
        .overlay { borderView1_5 }

      view6
        .frame(width: 150)
        .frame(minWidth: 0, alignment: .trailing)
        .overlay { borderView6 }
        .frame(width: 200)
        .frame(height: 20)
        .overlay { borderView1_6 }

      view7
        .frame(width: 150)
        .frame(minWidth: 0, alignment: .center)
        .overlay { borderView7 }
        .frame(width: 50)
        .frame(height: 20)
        .overlay { borderView1_7 }

      view8
        .frame(width: 150)
        .frame(minWidth: 0, alignment: .leading)
        .overlay { borderView8 }
        .frame(width: 200)
        .frame(height: 20)
        .overlay { borderView1_8 }

      view9
        .frame(width: 150)
        .frame(minWidth: 0, alignment: .trailing)
        .overlay { borderView9 }
        .frame(width: 200)
        .frame(height: 20)
        .overlay { borderView1_9 }

      view10
        .frame(width: 150)
        .frame(maxWidth: .infinity, alignment: .center)
        .overlay { borderView10 }
        .frame(width: 50)
        .frame(height: 20)
        .overlay { borderView1_10 }

      view11
        .frame(width: 150)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay { borderView11 }
        .frame(width: 200)
        .frame(height: 20)
        .overlay { borderView1_11 }

      view12
        .frame(width: 150)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .overlay { borderView12 }
        .frame(width: 200)
        .frame(height: 20)
        .overlay { borderView1_12 }
    }
    .frame(width: 320)

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 320))
    )
  }
}
