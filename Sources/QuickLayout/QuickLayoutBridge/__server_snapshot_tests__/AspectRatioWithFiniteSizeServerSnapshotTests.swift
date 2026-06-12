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
final class AspectRatioWithFiniteSizeServerSnapshotTests: FBServerSnapshotTestCase {

  private func runTestWith(aspectRatio: CGSize, contentMode: ContentMode, proposedSize: CGSize) {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.layer.borderColor = UIColor.black.cgColor
    view2.layer.borderWidth = 1

    let layout = ZStack {
      view1
        .aspectRatio(aspectRatio, contentMode: contentMode)
      view2
    }
    .frame(width: proposedSize.width, height: proposedSize.height)

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 200, height: 200))
    )
  }

  // --- FILL

  func testAspectRatio_fill_1_1_50_50() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 1), contentMode: .fill, proposedSize: CGSize(width: 50, height: 50))
  }

  func testAspectRatio_fill_1_1_50_100() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 1), contentMode: .fill, proposedSize: CGSize(width: 50, height: 100))
  }

  func testAspectRatio_fill_1_1_100_50() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 1), contentMode: .fill, proposedSize: CGSize(width: 100, height: 50))
  }

  // ---

  func testAspectRatio_fill_1_2_50_50() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 2), contentMode: .fill, proposedSize: CGSize(width: 50, height: 50))
  }

  func testAspectRatio_fill_1_2_50_100() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 2), contentMode: .fill, proposedSize: CGSize(width: 50, height: 100))
  }

  func testAspectRatio_fill_1_2_100_50() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 2), contentMode: .fill, proposedSize: CGSize(width: 100, height: 50))
  }

  // ---

  func testAspectRatio_fill_2_1_50_50() {
    runTestWith(aspectRatio: CGSize(width: 2, height: 1), contentMode: .fill, proposedSize: CGSize(width: 50, height: 50))
  }

  func testAspectRatio_fill_2_1_50_100() {
    runTestWith(aspectRatio: CGSize(width: 2, height: 1), contentMode: .fill, proposedSize: CGSize(width: 50, height: 100))
  }

  func testAspectRatio_fill_2_1_100_50() {
    runTestWith(aspectRatio: CGSize(width: 2, height: 1), contentMode: .fill, proposedSize: CGSize(width: 100, height: 50))
  }

  // --- FIT

  func testAspectRatio_fit_1_1_50_50() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 1), contentMode: .fit, proposedSize: CGSize(width: 50, height: 50))
  }

  func testAspectRatio_fit_1_1_50_100() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 1), contentMode: .fit, proposedSize: CGSize(width: 50, height: 100))
  }

  func testAspectRatio_fit_1_1_100_50() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 1), contentMode: .fit, proposedSize: CGSize(width: 100, height: 50))
  }

  // ---

  func testAspectRatio_fit_1_2_50_50() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 2), contentMode: .fit, proposedSize: CGSize(width: 50, height: 50))
  }

  func testAspectRatio_fit_1_2_50_100() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 2), contentMode: .fit, proposedSize: CGSize(width: 50, height: 100))
  }

  func testAspectRatio_fit_1_2_100_50() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 2), contentMode: .fit, proposedSize: CGSize(width: 100, height: 50))
  }

  // ---

  func testAspectRatio_fit_2_1_50_50() {
    runTestWith(aspectRatio: CGSize(width: 2, height: 1), contentMode: .fit, proposedSize: CGSize(width: 50, height: 50))
  }

  func testAspectRatio_fit_2_1_50_100() {
    runTestWith(aspectRatio: CGSize(width: 2, height: 1), contentMode: .fit, proposedSize: CGSize(width: 50, height: 100))
  }

  func testAspectRatio_fit_2_1_100_50() {
    runTestWith(aspectRatio: CGSize(width: 2, height: 1), contentMode: .fit, proposedSize: CGSize(width: 100, height: 50))
  }
}
