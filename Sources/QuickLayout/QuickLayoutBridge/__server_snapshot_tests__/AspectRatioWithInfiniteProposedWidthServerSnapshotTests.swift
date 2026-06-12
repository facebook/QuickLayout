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
final class AspectRatioWithInfiniteProposedWidthServerSnapshotTests: FBServerSnapshotTestCase {

  private func runTestWith(aspectRatio: CGSize, contentMode: ContentMode, proposedSize: CGSize) {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.layer.borderColor = UIColor.black.cgColor
    view2.layer.borderWidth = 1
    view2.backgroundColor = .clear

    let layout = ZStack(alignment: .leading) {
      view1
        .aspectRatio(aspectRatio, contentMode: contentMode)
      view2
        .frame(width: 200)
    }

    let targetView = UIView()
    targetView.addSubview(view1)
    targetView.addSubview(view2)
    targetView.frame.size = CGSize(width: 200, height: 200)

    layout.applyFrame(CGRect(origin: .zero, size: proposedSize))

    let backgroundView = UIView()
    backgroundView.frame.size = CGSize(width: 200, height: proposedSize.height)
    backgroundView.backgroundColor = .clear
    backgroundView.addSubview(targetView)
    targetView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
    FBTakeSnapshotOfViewAfterScreenUpdates(backgroundView, nil)
  }

  // --- FILL

  func testAspectRatio_fill_1_1_50_50() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 1), contentMode: .fill, proposedSize: CGSize(width: CGFloat.infinity, height: 50))
  }

  func testAspectRatio_fill_1_1_inf_100() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 1), contentMode: .fill, proposedSize: CGSize(width: CGFloat.infinity, height: 100))
  }

  // ---

  func testAspectRatio_fill_1_2_inf_50() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 2), contentMode: .fill, proposedSize: CGSize(width: CGFloat.infinity, height: 50))
  }

  func testAspectRatio_fill_1_2_inf_100() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 2), contentMode: .fill, proposedSize: CGSize(width: CGFloat.infinity, height: 100))
  }

  // ---

  func testAspectRatio_fill_2_1_inf_50() {
    runTestWith(aspectRatio: CGSize(width: 2, height: 1), contentMode: .fill, proposedSize: CGSize(width: CGFloat.infinity, height: 50))
  }

  func testAspectRatio_fill_2_1_inf_100() {
    runTestWith(aspectRatio: CGSize(width: 2, height: 1), contentMode: .fill, proposedSize: CGSize(width: CGFloat.infinity, height: 100))
  }

  // --- FIT

  func testAspectRatio_fit_1_1_inf_50() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 1), contentMode: .fit, proposedSize: CGSize(width: CGFloat.infinity, height: 50))
  }

  func testAspectRatio_fit_1_1_inf_100() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 1), contentMode: .fit, proposedSize: CGSize(width: CGFloat.infinity, height: 100))
  }

  // ---

  func testAspectRatio_fit_1_2_inf_50() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 2), contentMode: .fit, proposedSize: CGSize(width: CGFloat.infinity, height: 50))
  }

  func testAspectRatio_fit_1_2_inf_100() {
    runTestWith(aspectRatio: CGSize(width: 1, height: 2), contentMode: .fit, proposedSize: CGSize(width: CGFloat.infinity, height: 100))
  }

  // ---

  func testAspectRatio_fit_2_1_inf_50() {
    runTestWith(aspectRatio: CGSize(width: 2, height: 1), contentMode: .fit, proposedSize: CGSize(width: CGFloat.infinity, height: 50))
  }

  func testAspectRatio_fit_2_1_inf_100() {
    runTestWith(aspectRatio: CGSize(width: 2, height: 1), contentMode: .fit, proposedSize: CGSize(width: CGFloat.infinity, height: 100))
  }
}
