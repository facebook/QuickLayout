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
final class HStackWithTwoViewsAndInfinitSizeServerSnapshotTests: FBServerSnapshotTestCase {

  private func runTest(on views: (UIView, UIView)) {
    takeSnapshot(
      with: HStack {
        views.0
        views.1
      },
      in: .proposed(CGSize(width: CGFloat.infinity, height: .infinity))
    )
  }

  func testTwoLabelsInHStack() {
    let view1 = UILabel()
    view1.text = "Label 1"

    let view2 = UILabel()
    view2.text = "Label 2"

    runTest(on: (view1, view2))
  }

  func testTwoUIViews() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    runTest(on: (view1, view2))
  }

  func testTwoUISliders() {
    let view1 = UISlider()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UISlider()
    view2.backgroundColor = ColorPallete.yellow

    // Overlapping shadows from the two sliders causes the snapshot to fail. So we need to add a Spacer between them.
    takeSnapshot(
      with: HStack {
        view1
        Spacer(40)
        view2
      },
      in: .proposed(CGSize(width: CGFloat.infinity, height: .infinity))
    )
  }

  func testTwoUIScrollView() {
    let view1 = UIScrollView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIScrollView()
    view2.backgroundColor = ColorPallete.yellow

    runTest(on: (view1, view2))
  }

  func testTwoUITextView() {
    let view1 = UITextView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UITextView()
    view2.backgroundColor = ColorPallete.yellow

    runTest(on: (view1, view2))
  }

  func testTwoUICollectionView() {
    let view1 = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    view1.backgroundColor = ColorPallete.blue

    let view2 = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    view2.backgroundColor = ColorPallete.yellow

    runTest(on: (view1, view2))
  }

  func testTwoUITextField() {
    let view1 = UITextField()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UITextField()
    view2.backgroundColor = ColorPallete.yellow

    runTest(on: (view1, view2))
  }

  func testTwoUISearchField() {
    let view1 = UITextField()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UITextField()
    view2.backgroundColor = ColorPallete.yellow

    runTest(on: (view1, view2))
  }

  func testTwoUIButton() {
    let view1 = UIButton(type: .system)
    view1.setTitle("Button 1", for: .normal)

    let view2 = UIButton(type: .system)
    view2.setTitle("Button 2", for: .normal)

    runTest(on: (view1, view2))
  }

  func testTwoUISwitch() {
    let view1 = UISwitch()
    let view2 = UISwitch()

    runTest(on: (view1, view2))
  }

  func testTwoUIStepper() {
    let view1 = UIStepper()
    let view2 = UIStepper()

    runTest(on: (view1, view2))
  }

  func testTwoUIActivitiyIndicators() {
    if #available(iOS 13.0, *) {
      let view1 = UIActivityIndicatorView(style: .medium)
      view1.backgroundColor = ColorPallete.blue
      view1.startAnimating()

      let view2 = UIActivityIndicatorView(style: .medium)
      view2.backgroundColor = ColorPallete.yellow
      view2.startAnimating()

      runTest(on: (view1, view2))
    }
  }

  func testTwoUIProgressView() {
    let view1 = UIProgressView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIProgressView()
    view2.backgroundColor = ColorPallete.yellow

    runTest(on: (view1, view2))
  }

  func testTwoUIImageView() {
    let view1 = UIImageView(image: FBTestImageGenerator.image(with: ColorPallete.blue, size: CGSize(width: 40, height: 40)))
    let view2 = UIImageView(image: FBTestImageGenerator.image(with: ColorPallete.yellow, size: CGSize(width: 40, height: 40)))

    runTest(on: (view1, view2))
  }
}
