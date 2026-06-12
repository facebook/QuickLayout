/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import FBServerSnapshotTestCase
import FBTestImageGenerator
import QuickLayoutBridge

private final class SingleSubviewView: UIView {

  let label = UILabel()

  init(_ text: String) {
    super.init(frame: .zero)
    label.text = text
    label.textColor = .white
    self.addSubview(label)
  }

  @LayoutBuilder
  var body: any Layout {
    label
  }

  public required init?(coder: NSCoder) {
    fatalError()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    body.applyFrame(bounds)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return body.sizeThatFits(size)
  }
}

@MainActor
final class SingleViewServerSnaposhTests: FBServerSnapshotTestCase {

  func testTestAViewWithSingleSubview() {
    let view1 = SingleSubviewView("Ut enim dui")
    view1.backgroundColor = ColorPallete.blue

    let layout = HStack {
      view1
    }

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 200, height: 200))
    )
  }
}
