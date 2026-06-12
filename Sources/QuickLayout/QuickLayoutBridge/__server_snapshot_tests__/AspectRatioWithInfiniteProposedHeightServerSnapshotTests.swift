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
final class AspectRatioWithInfiniteProposedHeightServerSnapshotTests: FBServerSnapshotTestCase {

  private func runTestWith(aspectRatio: CGSize, contentMode: ContentMode, proposedSize: CGSize) {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.layer.borderColor = UIColor.black.cgColor
    view2.layer.borderWidth = 1
    view2.backgroundColor = .clear

    let layout = ZStack(alignment: .top) {
      view1
        .aspectRatio(aspectRatio, contentMode: contentMode)
      view2
        .frame(height: 200)
    }

    let targetView = UIView()
    targetView.addSubview(view1)
    targetView.addSubview(view2)
    targetView.frame.size = CGSize(width: proposedSize.width, height: 200)

    layout.applyFrame(CGRect(origin: .zero, size: proposedSize))

    let backgroundView = UIView()
    backgroundView.frame.size = CGSize(width: proposedSize.width, height: 200)
    backgroundView.backgroundColor = .clear
    backgroundView.addSubview(targetView)
    targetView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
    FBTakeSnapshotOfViewAfterScreenUpdates(backgroundView, nil)
  }

  // --- FILL

  func testAspectRatio_fill_1_1_50_inf() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 1), contentMode: .fill, proposedSize: CGSize(width: 50, height: CGFloat.infinity))
  }

  func testAspectRatio_fill_1_1_100_inf() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 1), contentMode: .fill, proposedSize: CGSize(width: 100, height: CGFloat.infinity))
  }

  // ---

  func testAspectRatio_fill_1_2_50_inf() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 2), contentMode: .fill, proposedSize: CGSize(width: 50, height: CGFloat.infinity))
  }

  func testAspectRatio_fill_1_2_100_inf() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 2), contentMode: .fill, proposedSize: CGSize(width: 100, height: CGFloat.infinity))
  }

  // ---

  func testAspectRatio_fill_2_1_50_inf() {
    runTestWith(aspectRatio: CGSize(width: 2, height: 1), contentMode: .fill, proposedSize: CGSize(width: 50, height: CGFloat.infinity))
  }

  func testAspectRatio_fill_2_1_100_inf() {
    runTestWith(aspectRatio: CGSize(width: 2, height: 1), contentMode: .fill, proposedSize: CGSize(width: 100, height: CGFloat.infinity))
  }

  // --- FIT

  func testAspectRatio_fit_1_1_50_inf() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 1), contentMode: .fit, proposedSize: CGSize(width: 50, height: CGFloat.infinity))
  }

  func testAspectRatio_fit_1_1_100_inf() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 1), contentMode: .fit, proposedSize: CGSize(width: 100, height: CGFloat.infinity))
  }

  // ---

  func testAspectRatio_fit_1_2_50_inf() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 2), contentMode: .fit, proposedSize: CGSize(width: 50, height: CGFloat.infinity))
  }

  func testAspectRatio_fit_1_2_100_inf() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 2), contentMode: .fit, proposedSize: CGSize(width: 100, height: CGFloat.infinity))
  }

  // ---

  func testAspectRatio_fit_2_1_50_inf() {
    runTestWith(aspectRatio: CGSize(width: 2, height: 1), contentMode: .fit, proposedSize: CGSize(width: 50, height: CGFloat.infinity))
  }

  func testAspectRatio_fit_2_1_100_inf() {
    runTestWith(aspectRatio: CGSize(width: 2, height: 1), contentMode: .fit, proposedSize: CGSize(width: 100, height: CGFloat.infinity))
  }
}
