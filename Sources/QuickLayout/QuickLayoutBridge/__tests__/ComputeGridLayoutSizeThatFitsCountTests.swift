/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import QuickLayoutBridge
import QuickLayoutCore
import UIKit
import XCTest

@MainActor
final class ComputeGridLayoutSizeThatFitsCountTests: XCTestCase {

  func test_SizeThatFitsInvocationCountWithFuzzyLayoutComparison() {
    let view1 = TestView()
    let view2 = TestView()

    view1.sizeThatFitsBlock = { size in
      return CGSize(width: 150.00000000000007, height: 300)
    }

    view2.sizeThatFitsBlock = { size in
      return CGSize(width: 150.00000000000008, height: 300)
    }

    let view = Grid {

      GridRow {
        view1
        view2
      }
    }
    view.sizeThatFits(CGSize(width: 300.0, height: 300.0))

    XCTAssertEqual(view1.sizeThatFitsCounter, 1)
    XCTAssertEqual(view2.sizeThatFitsCounter, 1)
  }

  func test_SizeThatFitsInvocationCountWithFixedSizeElements() {

    let view1: TestView = TestView()
    let view2: TestView = TestView()
    let view3: TestView = TestView()

    let grid = Grid {
      GridRow {
        view1
          .frame(width: 50, height: 50)
        view2
          .frame(width: 50, height: 50)
        view3
          .frame(width: 50, height: 50)
      }
    }
    _ = grid.sizeThatFits(CGSize(width: 300, height: 300))

    XCTAssertEqual(view1.sizeThatFitsCounter, 1)
    XCTAssertEqual(view2.sizeThatFitsCounter, 1)
    XCTAssertEqual(view3.sizeThatFitsCounter, 1)

  }

  func test_SizeThatFitsInvocationCountMultiplePartialFlexibilityElements() {
    let label1 = CountedLabel()
    label1.text = "Short text"
    let label2 = CountedLabel()
    label2.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    let grid = Grid {
      GridRow {
        label1
        label2
      }
    }
    _ = grid.sizeThatFits(CGSize(width: 300, height: 300))
    XCTAssertEqual(label1.sizeThatFitsCounter, 1)
    XCTAssertEqual(label2.sizeThatFitsCounter, 2)
  }

  func test_SizeThatFitsInvocationCountPartialLargerThanProposed() {

    let view1: TestView = TestView()

    let longLabel: CountedLabel = CountedLabel()
    longLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

    let grid = Grid {
      GridRow {
        view1
          .frame(width: 50, height: 50)
        longLabel
      }
    }
    _ = grid.sizeThatFits(CGSize(width: 300, height: 300))

    XCTAssertEqual(view1.sizeThatFitsCounter, 1)
    XCTAssertEqual(longLabel.sizeThatFitsCounter, 2)

  }

}
