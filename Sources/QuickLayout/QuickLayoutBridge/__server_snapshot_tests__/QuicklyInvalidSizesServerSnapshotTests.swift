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
final class QuicklyInvalidSizesServerSnapshotTests: FBServerSnapshotTestCase {

  func testProposeZero() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.blue

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.orange

    let layout = VStack {
      ZStack {
        view1
          .padding(1)
        view2
          .aspectRatio(CGSize(width: 1, height: 1))
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize.zero)
    )
  }

  func testProposeInfinity() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.blue

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.orange

    let layout = VStack {
      ZStack {
        view1
          .padding(1)
        view2
          .aspectRatio(CGSize(width: 1, height: 1))
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: CGFloat.infinity, height: .infinity))
    )
  }

  func testProposeGreatestFiniteValue() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.blue

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.orange

    let layout = VStack {
      ZStack {
        view1
          .padding(1)
        view2
          .aspectRatio(CGSize(width: 1, height: 1))
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: CGFloat.greatestFiniteMagnitude, height: .greatestFiniteMagnitude))
    )
  }

  func testProposeNan() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.blue

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.orange

    let layout = VStack {
      ZStack {
        view1
          .padding(1)
        view2
          .aspectRatio(CGSize(width: 1, height: 1))
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: CGFloat.nan, height: .nan))
    )
  }

  func testProposeMinusOne() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.blue

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.orange

    let layout = VStack {
      ZStack {
        view1
          .padding(1)
        view2
          .aspectRatio(CGSize(width: 1, height: 1))
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: -1.0, height: -1.0))
    )
  }

  func testProposeMinus100() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.blue

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.orange

    let layout = VStack {
      ZStack {
        view1
          .padding(1)
        view2
          .aspectRatio(CGSize(width: 1, height: 1))
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: -100.0, height: -100.0))
    )
  }

  func testViewReturnMinus1() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = View()
    view2.mockedSize = CGSize(width: -1.0, height: -1.0)
    view2.backgroundColor = ColorPallete.blue

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.orange

    let layout = VStack {
      ZStack {
        view1
          .padding(1)
        view2
          .aspectRatio(CGSize(width: 1, height: 1))
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 10, height: 10))
    )
  }

  func testViewReturnNan() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = View()
    view2.mockedSize = CGSize(width: CGFloat.nan, height: .nan)
    view2.backgroundColor = ColorPallete.blue

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.orange

    let layout = VStack {
      ZStack {
        view1
          .padding(1)
        view2
          .aspectRatio(CGSize(width: 1, height: 1))
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 10, height: 10))
    )
  }

  func testViewReturnInVStack() {
    let view2 = View()
    view2.mockedSize = CGSize(width: CGFloat.nan, height: .nan)
    view2.backgroundColor = ColorPallete.blue

    let layout = VStack {
      view2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 10, height: 10))
    )
  }

  func testViewReturnsInfinity() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = View()
    view2.mockedSize = CGSize(width: CGFloat.infinity, height: .infinity)
    view2.backgroundColor = ColorPallete.blue

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.orange

    let layout = VStack {
      ZStack {
        view1
          .padding(1)
        view2
          .aspectRatio(CGSize(width: 1, height: 1))
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 10, height: 10))
    )
  }

  func testViewReturns100() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = View()
    view2.mockedSize = CGSize(width: 100, height: 100)
    view2.backgroundColor = ColorPallete.blue

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.orange

    let layout = VStack {
      ZStack {
        view1
          .padding(1)
        view2
          .aspectRatio(CGSize(width: 1, height: 1))
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 10, height: 10))
    )
  }

  func testAspectRatio() {
    let view0 = UIView()
    view0.backgroundColor = ColorPallete.yellow

    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.blue

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.yellow

    let view4 = UIView()
    view4.backgroundColor = ColorPallete.red

    let view5 = UIView()
    view5.backgroundColor = ColorPallete.blue

    let view6 = UIView()
    view6.backgroundColor = ColorPallete.red

    let view7 = UIView()
    view7.backgroundColor = ColorPallete.red

    let layout = VStack {
      view0
        .aspectRatio(CGSize(width: 1.0, height: .infinity))
        .frame(width: 10, height: 10)
      view1
        .aspectRatio(CGSize.zero)
        .frame(width: 10, height: 10)
      view2
        .aspectRatio(CGSize(width: -1, height: 0))
        .frame(width: 10, height: 10)
      view3
        .aspectRatio(CGSize(width: 0, height: 1), contentMode: .fill)
        .frame(width: 10, height: 10)
      view4
        .aspectRatio(CGSize(width: 1, height: -1), contentMode: .fill)
        .frame(width: 10, height: 10)
      view5
        .aspectRatio(CGSize(width: 1.0, height: .nan), contentMode: .fill)
        .frame(width: 10, height: 10)
      view6
        .aspectRatio(CGSize(width: 1.0, height: 1.0), contentMode: .fit)
        .frame(width: 10, height: 0)
      view7
        .aspectRatio(CGSize(width: 1.0, height: 1.0), contentMode: .fit)
        .frame(width: 10, height: .infinity)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 100, height: 100))
    )
  }

  func testFrame() {
    let view0 = UIView()
    view0.backgroundColor = ColorPallete.yellow

    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.blue

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.yellow

    let view4 = UIView()
    view4.backgroundColor = ColorPallete.red

    let view5 = UIView()
    view5.backgroundColor = ColorPallete.blue

    let layout = VStack {
      view0
        .frame(width: 10.0, height: .nan)
      view1
        .frame(width: .nan, height: 10)
      view2
        .frame(width: .infinity, height: 10)
      view4
        .frame(width: -10.0, height: 10)
      view5
        .frame(width: 10.0, height: -10)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 100, height: 100))
    )
  }

  func testPadding() {
    let view0 = UIView()
    view0.backgroundColor = ColorPallete.yellow

    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.blue

    let layout = VStack {
      view0
        .padding(-10)
      view1
        .padding(.infinity)
      view2
        .padding(.nan)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 100, height: 100))
    )
  }

  func testStacks() {
    let view0 = UIView()
    view0.backgroundColor = ColorPallete.yellow

    let view1 = UIView()
    view1.backgroundColor = ColorPallete.red

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.blue

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.yellow

    let view4 = UIView()
    view4.backgroundColor = ColorPallete.red

    let view5 = UIView()
    view5.backgroundColor = ColorPallete.blue

    let layout = VStack {
      HStack(spacing: .nan) {
        view0
          .frame(width: 20, height: 10)
        view1
          .frame(width: 20, height: 10)
      }
      HStack(spacing: .infinity) {
        view2
          .frame(width: 20, height: 10)
        view3
          .frame(width: 20, height: 10)
      }
      HStack(spacing: -10) {
        view4
          .frame(width: 20, height: 10)
        view5
          .frame(width: 20, height: 10)
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 100, height: 100))
    )
  }

  func testApplyFrameWithNan() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.layer.borderColor = UIColor.black.cgColor
    view2.layer.borderWidth = 1
    view2.backgroundColor = .clear

    let layout = ZStack(alignment: .leading) {
      view1
    }

    let targetView = UIView()
    targetView.addSubview(view1)
    targetView.addSubview(view2)
    targetView.frame.size = CGSize(width: 200, height: 200)

    layout.applyFrame(CGRect(origin: .zero, size: CGSize(width: CGFloat.nan, height: CGFloat.nan)))

    let backgroundView = UIView()
    backgroundView.frame.size = CGSize(width: 200, height: 200)
    backgroundView.backgroundColor = .clear
    backgroundView.addSubview(targetView)
    targetView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
    FBTakeSnapshotOfViewAfterScreenUpdates(backgroundView, nil)
  }
}

private final class View: UIView {

  var mockedSize: CGSize = .zero

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return mockedSize
  }
}
