/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import QuickLayoutBridge
import QuickLayoutCore
import XCTest

@MainActor
final class ViewExtractionTests: XCTestCase {
  func testViewExtraction() {

    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()
    let view4 = UIView()
    let view5 = UIView()
    let view6 = UIView()
    let view7 = UIView()
    let view8 = UIView()

    let layout = HStack {
      view1
      view2
      VStack {
        view3
        view4
      }
      ZStack {
        view5
        view6
      }
      view7
        .overlay {
          view8
        }
    }
    let result = layout.views()
    let expectedViews = [view1, view2, view3, view4, view5, view6, view7, view8]

    XCTAssertEqual(result, expectedViews)
  }

  func testViewExtractionFromHstackWithConditionalStatements() {

    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()
    let view4 = UIView()
    let view5 = UIView()
    let view6 = UIView()
    let view7 = UIView()

    let aBoolValue = true

    let anArray1 = [view4, view5]
    let anArray2 = [view6, view7]

    let layout = HStack {
      view1
      if !aBoolValue {
        view2
      }
      if aBoolValue {
        view3
      }
      for view in anArray1 {
        view
      }
      ForEach(anArray2)
    }
    let result = layout.views()
    let expectedViews = [view1, view3, view4, view5, view6, view7]

    XCTAssertEqual(result, expectedViews)
  }

  func testViewExtractionFromZstackWithConditionalStatements() {

    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()
    let view4 = UIView()
    let view5 = UIView()
    let view6 = UIView()
    let view7 = UIView()

    let aBoolValue = true

    let anArray1 = [view4, view5]
    let anArray2 = [view6, view7]

    let layout = ZStack {
      view1
      if !aBoolValue {
        view2
      }
      if aBoolValue {
        view3
      }
      for view in anArray1 {
        view
      }
      ForEach(anArray2)
    }
    let result = layout.views()
    let expectedViews = [view1, view3, view4, view5, view6, view7]

    XCTAssertEqual(result, expectedViews)
  }

  func testViewExtractionFormLayoutPrimitives() {

    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()
    let view4 = UIView()
    let view5 = UIView()
    let view6 = UIView()
    let view7 = UIView()
    let view8 = UIView()

    let layout = ZStack {
      view1
      EmptyLayout()
      view2.frame(width: 100, height: 100)
      view3.resizable().frame(width: 100, height: 100)
      view4.expand(by: CGSize(width: 1, height: 1))
      Spacer()
      view5.frame(minWidth: 100)
      view6.aspectRatio(CGSize(width: 1, height: 1))
      view7.layoutPriority(1)
      view8.padding(10)
    }
    let result = layout.views()
    let expectedViews = [view1, view2, view3, view4, view5, view6, view7, view8]

    XCTAssertEqual(result, expectedViews)
  }

  func testBackgroundAndOverlay() {

    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()
    let view4 = UIView()

    let layout = ZStack {
      LayeringElement(
        target: view1,
        layer: view2,
        type: .overlay,
        alignment: .center
      )
      LayeringElement(
        target: view3,
        layer: view4,
        type: .background,
        alignment: .center
      )
    }
    let result = layout.views()
    let expectedViews = [view1, view2, view4, view3]

    XCTAssertEqual(result, expectedViews)
  }

  func testBackgroundAndOverlayInversed() {

    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()
    let view4 = UIView()

    let layout = ZStack {
      LayeringElement(
        target: view3,
        layer: view4,
        type: .background,
        alignment: .center
      )
      LayeringElement(
        target: view1,
        layer: view2,
        type: .background,
        alignment: .center
      )
    }
    let result = layout.views()
    let expectedViews = [view4, view3, view2, view1]

    XCTAssertEqual(result, expectedViews)
  }
}
