/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import FBServerSnapshotTestCase
import QuickLayoutBridge
import XCTest

@MainActor
final class AspectRatioServerSnapshotTests: FBServerSnapshotTestCase {

  func testAspectRatioWithTextField() {
    let textField = UITextField()
    textField.backgroundColor = ColorPallete.red

    let view = UIView()
    view.backgroundColor = ColorPallete.blue

    let layout = HStack {
      textField
      Spacer(8)
      view
        .resizable()
        .aspectRatio(CGSize(width: 3, height: 2))
    }

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 44))
    )
  }
}
