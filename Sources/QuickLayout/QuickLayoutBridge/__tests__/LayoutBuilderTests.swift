/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import QuickLayoutBridge
import QuickLayoutCore
import XCTest

// Helper to invoke the result builder
private func buildLayout(@LayoutBuilder _ builder: () -> Layout) -> Layout {
  builder()
}

// Helpers to avoid `warning: will never be executed`
private func isFalse() -> Bool { false }
private func isTrue() -> Bool { true }

@MainActor
final class LayoutBuilderTests: XCTestCase {

  func testReturnValue() {
    let layout = TestElement()

    let result = buildLayout {
      layout
    }

    if let result = result as? TestElement {
      XCTAssertTrue(result.identifier == layout.identifier)
    } else {
      XCTFail("Expected TestElement")
    }
  }

  func testReturnOptionalValue() {
    let layout: Layout? = nil

    let result = buildLayout {
      layout
    }

    XCTAssertTrue(result is EmptyElement)
  }

  func testReturnOptionalValueNonNil() {
    let expectedLayout = TestElement()
    let layout: Layout? = expectedLayout

    let result = buildLayout {
      layout
    }

    if let result = result as? TestElement {
      XCTAssertTrue(result.identifier == expectedLayout.identifier)
    } else {
      XCTFail("Expected TestElement")
    }
  }

  func testReturnViewsWrappedIntoLayout() {
    let view = UILabel()

    let result = buildLayout {
      view
    }

    XCTAssertTrue(result is SingleElement)
  }

  func testReturnOptionalViewsWrappedIntoLayout() {
    let view: UILabel? = nil

    let result = buildLayout {
      view
    }

    XCTAssertTrue(result is EmptyElement)
  }

  func testReturnOptionalViewNonNilWrappedIntoLayout() {
    let view: UILabel? = UILabel()

    let result = buildLayout {
      view
    }

    XCTAssertTrue(result is SingleElement)
  }

  func testOptionalReturnsSharedWhenFalse() {
    let layout = TestElement()

    let result = buildLayout {
      if isFalse() {
        layout
      }
    }
    XCTAssertTrue(result is EmptyElement)
  }

  func testOptionalReturnsValueWhenTrue() {
    let layout = TestElement()

    let result = buildLayout {
      if isTrue() {
        layout
      }
    }
    if let result = result as? TestElement {
      XCTAssertTrue(result.identifier == layout.identifier)
    } else {
      XCTFail("Expected TestElement")
    }
  }

  func testEitherReturnsFirstWhenTrue() {
    let layout1 = TestElement()
    let layout2 = TestElement()

    let result = buildLayout {
      if isTrue() {
        layout1
      } else {
        layout2
      }
    }
    if let result = result as? TestElement {
      XCTAssertTrue(result.identifier == layout1.identifier)
    } else {
      XCTFail("Expected TestElement")
    }
  }

  func testEitherReturnsSecondWhenFalse() {
    let layout1 = TestElement()
    let layout2 = TestElement()

    let result = buildLayout {
      if isFalse() {
        layout1
      } else {
        layout2
      }
    }
    if let result = result as? TestElement {
      XCTAssertTrue(result.identifier == layout2.identifier)
    } else {
      XCTFail("Expected TestElement")
    }
  }
}

private final class TestElement: Layout {

  let identifier: String = UUID().uuidString

  func quick_layoutThatFits(_ proposedSize: CGSize) -> LayoutNode {
    LayoutNode.empty
  }

  func quick_flexibility(for axis: Axis) -> Flexibility {
    .partial
  }

  func quick_layoutPriority() -> CGFloat {
    0
  }

  func quick_extractViewsIntoArray(_ views: inout [UIView]) {
    // no-op
  }
}
