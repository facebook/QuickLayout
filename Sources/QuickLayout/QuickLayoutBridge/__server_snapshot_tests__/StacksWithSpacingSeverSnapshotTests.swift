/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import FBServerSnapshotTestCase
import QuickLayoutBridge

@MainActor
final class StacksWithSpacingSeverSnapshotTests: FBServerSnapshotTestCase {

  func testSpacersWithSpacing() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.red

    let view4 = UIView()
    view4.backgroundColor = ColorPallete.red

    let layout = HStack(spacing: 10) {
      view1
        .frame(width: 40, height: 40)
      view2
        .frame(width: 40, height: 40)
      Spacer(10)
      view3
        .frame(width: 40, height: 40)
      Spacer(10)
      view4
        .frame(width: 40, height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testEmptyLayouts() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 10) {
      view1.frame(width: 40, height: 40)
      EmptyLayout()
      EmptyLayout()
      EmptyLayout()
      view2.frame(width: 40, height: 40)
      view3.frame(width: 40, height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testSingleThreeEmptyLayouts() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 10) {
      view1.frame(width: 40, height: 40)
      HStack(spacing: 10) {
        EmptyLayout()
        EmptyLayout()
        EmptyLayout()
      }
      view2.frame(width: 40, height: 40)
      view3.frame(width: 40, height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testEmptyStack() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 10) {
      view1.frame(width: 40, height: 40)
      HStack {}
      VStack {}
      ZStack {}
      view2.frame(width: 40, height: 40)
      view3.frame(width: 40, height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testStacksWithEmptyLayout() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 10) {
      view1.frame(width: 40, height: 40)
      HStack { EmptyLayout() }
      HStack { EmptyLayout() }
      ZStack { EmptyLayout() }
      view2.frame(width: 40, height: 40)
      view3.frame(width: 40, height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testStacksWithTwoEmptyLayout() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 10) {
      view1.frame(width: 40, height: 40)
      VStack {
        EmptyLayout()
        EmptyLayout()
      }
      ZStack {
        EmptyLayout()
        EmptyLayout()
      }
      HStack {
        EmptyLayout()
        EmptyLayout()
      }
      view2.frame(width: 40, height: 40)
      view3.frame(width: 40, height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testStacksEmptyLayoutAndEmptyStack() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 10) {
      view1.frame(width: 40, height: 40)
      VStack {
        EmptyLayout()
        VStack {}
      }
      VStack {
        EmptyLayout()
        VStack {}
      }
      VStack {
        EmptyLayout()
        ZStack {}
      }
      view2.frame(width: 40, height: 40)
      view3.frame(width: 40, height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testStacksEmptyLayoutAndNonEmptyStack() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 10) {
      view1.frame(width: 40, height: 40)
      VStack {
        EmptyLayout()
        HStack {
          Spacer(10)
        }
      }
      VStack {
        EmptyLayout()
        HStack {
          Spacer(10)
        }
      }
      VStack {
        EmptyLayout()
        HStack {
          Spacer(10)
        }
      }
      view2.frame(width: 40, height: 40)
      view3.frame(width: 40, height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testEmptyLayoutsAtTheEndAndStart() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 10) {
      EmptyLayout()
      EmptyLayout()
      view1.frame(width: 40, height: 40)
      view2.frame(width: 40, height: 40)
      view3.frame(width: 40, height: 40)
      EmptyLayout()
      EmptyLayout()
      EmptyLayout()
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testSpacersWithSpacingAtTheEndAndStart() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.red

    let layout = HStack(spacing: 10) {
      Spacer(10)
      view1
        .frame(width: 40, height: 40)
      view2
        .frame(width: 40, height: 40)
      Spacer(10)
      view3
        .frame(width: 40, height: 40)
      Spacer(10)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testNestedStackWithZeroSpacer() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 10) {
      view1.frame(width: 40, height: 40)
      VStack {
        HStack {
          Spacer(0)
        }
      }
      view2.frame(width: 40, height: 40)
      view3.frame(width: 40, height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testStacksWithZeroSpacer() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 10) {
      view1.frame(width: 40, height: 40)
      Spacer(0)
      view2.frame(width: 40, height: 40)
      view3.frame(width: 40, height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testStacksWithZeroSpacerTwice() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 10) {
      view1.frame(width: 40, height: 40)
      Spacer(0)
      Spacer(0)
      view2.frame(width: 40, height: 40)
      view3.frame(width: 40, height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testStacksWithSpacer10() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 10) {
      view1.frame(width: 40, height: 40)
      Spacer(10)
      view2.frame(width: 40, height: 40)
      view3.frame(width: 40, height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testStacksWithSpacer30() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 30) {
      view1.frame(width: 40, height: 40)
      Spacer(10)
      Spacer(10)
      Spacer(10)
      view2.frame(width: 40, height: 40)
      view3.frame(width: 40, height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testSpacingWithFullyFlexibleElements() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 30) {
      view1.frame(height: 40)
      Spacer(10)
      Spacer(10)
      Spacer(10)
      view2.frame(height: 40)
      view3.frame(height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testSpacingWithFullyFlexibleElementsWithoutSpacers() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 30) {
      view1.frame(height: 40)
      view2.frame(height: 40)
      view3.frame(height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testSpacingWithFullyFlexibleElementsWithEmptyLayout() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 30) {
      view1.frame(height: 40)
      EmptyLayout()
      view2.frame(height: 40)
      view3.frame(height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testSpacingWithFullyFlexibleElementsWithEmptyLayoutAndSpacer() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 30) {
      view1.frame(height: 40)
      EmptyLayout()
      Spacer(10)
      view2.frame(height: 40)
      view3.frame(height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testSpacingWithFullyFlexibleElementsWithEmptyLayoutAndSpacer2() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 30) {
      view1.frame(height: 40)
      Spacer(10)
      EmptyLayout()
      view2.frame(height: 40)
      view3.frame(height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testSpacingWithFullyFlexibleViewsAndSpacer() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    let view3 = UIView()
    view3.backgroundColor = ColorPallete.blue

    let layout = HStack(spacing: 30) {
      view1.frame(height: 40)
      Spacer(10)
      Spacer()
      view2.frame(height: 40)
      view3.frame(height: 40)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }
}
