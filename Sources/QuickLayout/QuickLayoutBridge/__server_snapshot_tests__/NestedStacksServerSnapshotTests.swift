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
final class NestedStacksServerSnapshotTests: FBServerSnapshotTestCase {

  private func runTest(on views: (UIView, UIView?)) {
    takeSnapshot(
      with:
        HStack {
          VStack {
            VStack {
              HStack {
                HStack {
                  views.0
                  if let view = views.1 {
                    view
                  }
                }
              }
            }
          }
        },
      in: .proposed(CGSize(width: 300, height: 100))
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

  func testTwoUIScrollView() {
    let view1 = UIScrollView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIScrollView()
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

  func testTwoUIButton() {
    let view1 = UIButton(type: .system)
    view1.setTitle("Button 1", for: .normal)

    let view2 = UIButton(type: .system)
    view2.setTitle("Button 2", for: .normal)

    runTest(on: (view1, view2))
  }

  func testTwoUIImageView() {
    let view1 = UIImageView(image: FBTestImageGenerator.image(with: ColorPallete.blue, size: CGSize(width: 40, height: 40)))
    let view2 = UIImageView(image: FBTestImageGenerator.image(with: ColorPallete.yellow, size: CGSize(width: 40, height: 40)))

    runTest(on: (view1, view2))
  }

  func testSingleLabelInHStack() {
    let view1 = UILabel()
    view1.text = "Label 1"

    runTest(on: (view1, nil))
  }

  func testSingleUIView() {
    let view1 = UIView()
    view1.backgroundColor = ColorPallete.blue

    let view2 = UIView()
    view2.backgroundColor = ColorPallete.yellow

    runTest(on: (view1, nil))
  }

  func testSingleUISlider() {
    let view1 = UISlider()
    view1.backgroundColor = ColorPallete.blue

    runTest(on: (view1, nil))
  }

  func testSingleUIScrollView() {
    let view1 = UIScrollView()
    view1.backgroundColor = ColorPallete.blue

    runTest(on: (view1, nil))
  }

  func testSingleUITextField() {
    let view1 = UITextField()
    view1.backgroundColor = ColorPallete.blue

    runTest(on: (view1, nil))
  }

  func testSingleUIButton() {
    let view1 = UIButton(type: .system)
    view1.setTitle("Button 1", for: .normal)

    runTest(on: (view1, nil))
  }

  func testSingleUIImageView() {
    let view1 = UIImageView(image: FBTestImageGenerator.image(with: ColorPallete.blue, size: CGSize(width: 40, height: 40)))

    runTest(on: (view1, nil))
  }

  func testResizableView() {
    let view1 = UIButton(type: .system)
    view1.setTitle("Button 1", for: .normal)

    takeSnapshot(
      with:
        HStack {
          VStack {
            VStack {
              HStack {
                HStack {
                  view1
                    .resizable()
                }
              }
            }
          }
        },
      in: .proposed(CGSize(width: 300, height: 100))
    )
  }

  func testResizableViewInFrame() {
    let view1 = UIButton(type: .system)
    view1.setTitle("Button 1", for: .normal)

    takeSnapshot(
      with:
        HStack {
          VStack {
            VStack {
              HStack {
                HStack {
                  view1
                    .resizable()
                    .frame(width: 50, height: 50)
                }
              }
            }
          }
        },
      in: .proposed(CGSize(width: 300, height: 100))
    )
  }

  func testResizableViewInFrameWithAnotherView() {
    let view1 = UIButton(type: .system)
    view1.setTitle("Button 1", for: .normal)

    let view2 = UIButton(type: .system)
    view2.setTitle("Button 2", for: .normal)

    takeSnapshot(
      with:
        HStack {
          VStack {
            view1
            VStack {
              HStack {
                EmptyLayout()
                HStack {
                  view2
                    .resizable()
                    .frame(width: 50, height: 50)
                }
              }
            }
          }
        },
      in: .proposed(CGSize(width: 300, height: 100))
    )
  }
}
