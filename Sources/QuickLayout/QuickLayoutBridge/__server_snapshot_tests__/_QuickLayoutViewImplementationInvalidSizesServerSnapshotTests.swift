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
final class _QuickLayoutViewImplementationInvalidSizesServerSnapshotTests: FBServerSnapshotTestCase {

  func testProposeInfinity() {
    let view = TestView1()
    view.label1.text = "Label 1"
    view.label2.text = "Label 2"
    takeSnapshot(
      of: view,
      in: .proposed(CGSize(width: 320.0, height: .infinity))
    )
  }

  func testProposeGreatestFiniteMagnitude() {
    let view = TestView1()
    view.label1.text = "Label 1"
    view.label2.text = "Label 2"
    takeSnapshot(
      of: view,
      in: .proposed(CGSize(width: 320.0, height: .greatestFiniteMagnitude))
    )
  }

  func testProposeNan() {
    let view = TestView1()
    view.label1.text = "Label 1"
    view.label2.text = "Label 2"
    takeSnapshot(
      of: view,
      in: .proposed(CGSize(width: 320.0, height: .nan))
    )
  }
}

private final class TestView1: UIView, HasBody {

  let label1 = UILabel()
  let label2 = UILabel()

  var body: Layout {
    VStack {
      label1
        .padding(10)
      label2
    }
    .frame(maxHeight: .infinity, alignment: .top)
  }

  override func layoutSubviews() {
    _QuickLayoutViewImplementation.layoutSubviews(self)
    super.layoutSubviews()
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    _QuickLayoutViewImplementation.sizeThatFits(self, size: size) ?? .zero
  }
}
