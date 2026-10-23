/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import FBServerSnapshotTestCase
import FBTestImageGenerator
import QuickLayoutBridge

final class GridLayoutServerSnapshotTests: FBServerSnapshotTestCase {

  private static let wrappingLabelTestNames = [
    "testMultipleChildrenSingleRowTwoPartialWrappingLabels",
    "testLongLabelWithSpacerInBetween",
  ]

  override func imageComparisonErrorThreshold() -> FBImageComparisonErrorThreshold {
    if Self.wrappingLabelTestNames.contains(where: { name.contains($0) }) {
      return .relaxed
    }
    return .default
  }

  // MARK: - Test builder functions

  // Single child cases
  func buildSingleChildSingleRow() {
    let view = ColorView(ColorPallete.red, text: "1")

    let layout = Grid {
      GridRow {
        view
          .frame(width: 100, height: 100)
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func buildSingleChildSingleRowUnbounded() {
    let view = ColorView(ColorPallete.red, text: "1")

    let layout = Grid {
      GridRow {
        view
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func buildSingleChildMultipleRowUnbounded() {
    let view1 = ColorView(ColorPallete.red, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.red, text: "3")

    let layout = Grid {
      GridRow {
        view1
      }
      GridRow {
        view2
      }
      GridRow {
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  // Single Child Multiple Row cases

  func buildSingleChildMultipleRow(verticalSpacing: CGFloat = 0) {
    let view1 = ColorView(ColorPallete.red, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.blue, text: "3")

    let layout = Grid(verticalSpacing: verticalSpacing) {
      GridRow {
        view1
          .frame(width: 50, height: 50)
      }
      GridRow {
        view2
          .frame(width: 50, height: 50)
      }
      GridRow {
        view3
          .frame(width: 50, height: 50)
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  // Multiple children single row cases

  func buildMultipleChildrenSingleRow(horizontalSpacing: CGFloat = 0, layoutDirection: LayoutDirection = .leftToRight) {
    let view1 = ColorView(ColorPallete.red, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.blue, text: "3")

    let layout = Grid(horizontalSpacing: horizontalSpacing) {
      GridRow {
        view1
          .frame(width: 50, height: 50)
        view2
          .frame(width: 50, height: 50)
        view3
          .frame(width: 50, height: 50)
      }
    }
    .layoutDirection(layoutDirection)

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func buildMultipleChildrenSingleRowDifferentSizes(horizontalSpacing: CGFloat = 0, rowAlignment: VerticalAlignment = .center) {
    let view1 = ColorView(ColorPallete.red, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.blue, text: "3")

    let layout = Grid(horizontalSpacing: horizontalSpacing) {
      GridRow(alignment: rowAlignment) {
        view1.frame(width: 50, height: 50)
        view2.frame(width: 100, height: 100)
        view3.frame(width: 50, height: 50)
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func buildMultipleChildrenSingleRowUnbounded(horizontalSpacing: CGFloat = 0) {
    let view1 = ColorView(ColorPallete.red, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.blue, text: "3")

    let layout = Grid(horizontalSpacing: horizontalSpacing) {
      GridRow {
        view1
        view2
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }
  func buildMultipleChildrenSingleRowOneUnboundedView() {
    let view1 = ColorView(ColorPallete.red, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.red, text: "3")

    let layout = Grid {
      GridRow {
        view1
          .frame(width: 50, height: 50)
        view2
        view3
          .frame(width: 50, height: 50)
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  // Multiple children multiple rows cases

  func buildMultipleChildrenMultipleRows(verticalSpacing: CGFloat = 0, horizontalSpacing: CGFloat = 0) {
    let view1 = ColorView(ColorPallete.red, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.red, text: "3")

    let view4 = ColorView(ColorPallete.blue, text: "1")
    let view5 = ColorView(ColorPallete.orange, text: "2")
    let view6 = ColorView(ColorPallete.blue, text: "3")

    let layout = Grid(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
      GridRow {
        view1.frame(width: 50, height: 50)
        view2.frame(width: 50, height: 50)
        view3.frame(width: 50, height: 50)
      }
      GridRow {
        view4.frame(width: 50, height: 50)
        view5.frame(width: 50, height: 50)
        view6.frame(width: 50, height: 50)
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func buildMultipleChildrenMultipleRowsUnbounded(verticalSpacing: CGFloat = 0, horizontalSpacing: CGFloat = 0) {
    let view1 = ColorView(ColorPallete.red, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.red, text: "3")

    let view4 = ColorView(ColorPallete.red, text: "4")
    let view5 = ColorView(ColorPallete.yellow, text: "4")
    let view6 = ColorView(ColorPallete.red, text: "6")

    let layout = Grid(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
      GridRow {
        view1
        view2
        view3
      }
      GridRow {
        view4
        view5
        view6
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func buildMultipleChildrenSingleRowPartialWrapping(horizontalSpacing: CGFloat = 0, verticalSpacing: CGFloat = 0) {
    let view1 = ColorView(ColorPallete.red, text: "1")
      .frame(width: 50, height: 50)

    let longLabel = UILabel()
    longLabel.text = "This is a long label that will wrap to multiple lines and will be truncated at the end of the line if it is too long to fit in the available space."
    longLabel.font = .systemFont(ofSize: 10)
    longLabel.numberOfLines = 0

    let view3 = ColorView(ColorPallete.yellow, text: "2")
      .frame(width: 50, height: 50)

    let layout = Grid(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
      GridRow {
        view1
        longLabel
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 500, height: 500))
    )

  }

  func buildMultipleChildrenSingleRowPartialWrappingWithUIView(horizontalSpacing: CGFloat = 0, verticalSpacing: CGFloat = 0) {

    func buildLongLabel() -> UILabel {
      let longLabel = UILabel()
      longLabel.text = "This is a long label that will wrap to multiple lines and will be truncated at the end of the line if it is too long to fit in the available space. This is a long label that will wrap to multiple lines and will be truncated at the end of the line if it is too long to fit in the available space. This is a long label that will wrap to multiple lines and will be truncated at the end of the line if it is too long to fit in the available space."
      longLabel.font = .systemFont(ofSize: 10)
      longLabel.numberOfLines = 0
      return longLabel
    }

    let longLabel = buildLongLabel()
    let longLabel2 = buildLongLabel()

    let view = ColorView(ColorPallete.yellow, text: "2")

    let layout = Grid(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
      GridRow {
        longLabel
        view
        longLabel2
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )

  }

  func buildMultipleChildrenSingleRowTwoPartialWrappingLabels(horizontalSpacing: CGFloat = 0, verticalSpacing: CGFloat = 0) {

    func buildLongLabel(color: UIColor) -> UILabel {
      let longLabel = UILabel()
      longLabel.text = "This is a long label that will wrap to multiple lines and will be truncated at the end of the line if it is too long to fit in the available space. This is a long label that will wrap to multiple lines and will be truncated at the end of the line if it is too long to fit in the available space. This is a long label that will wrap to multiple lines and will be truncated at the end of the line if it is too long to fit in the available space."
      longLabel.backgroundColor = color
      longLabel.font = .systemFont(ofSize: 10)
      longLabel.numberOfLines = 0
      return longLabel
    }

    let longLabel = buildLongLabel(color: .blue)
    let longLabel2 = buildLongLabel(color: .yellow)

    let layout = Grid(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
      GridRow {
        longLabel

        longLabel2
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )

  }

  func buildUnboundedViewsWithLayoutPriority(view1LayoutPriority: CGFloat = 0, view2LayoutPriority: CGFloat = 0, view3LayoutPriority: CGFloat = 0) {

    let view1 = ColorView(ColorPallete.red, text: "1")
    let view2 = ColorView(ColorPallete.yellow, text: "2")
    let view3 = ColorView(ColorPallete.red, text: "3")

    let layout = Grid {
      GridRow {
        view1
          .layoutPriority(view1LayoutPriority)
        view2
          .layoutPriority(view2LayoutPriority)
        view3
          .layoutPriority(view3LayoutPriority)
      }

    }
    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func buildMultipleChildrenMultipleRowswithGridAlignment(alignment: Alignment) {
    let view1 = ColorView(ColorPallete.red, text: "1")
      .frame(width: 50, height: 50)

    let view2 = ColorView(ColorPallete.blue, text: "1")
      .frame(width: 100, height: 100)

    let view3 = ColorView(ColorPallete.red, text: "1")
      .frame(width: 50, height: 50)

    let view4 = ColorView(ColorPallete.blue, text: "1")
      .frame(width: 100, height: 100)

    let view5 = ColorView(ColorPallete.red, text: "1")
      .frame(width: 50, height: 50)

    let view6 = ColorView(ColorPallete.blue, text: "1")
      .frame(width: 100, height: 100)

    let layout = Grid(alignment: alignment) {

      GridRow {
        view1
        view2
        view3
      }

      GridRow {
        view4
        view5
        view6
      }

    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func buildGridCellAnchorGrid(alignment: Alignment) {

    let view1 = ColorView(ColorPallete.red, text: "1")
      .frame(width: 100, height: 100)
    let view2 = ColorView(ColorPallete.red, text: "2")
      .frame(width: 100, height: 100)

    let view3 = ColorView(ColorPallete.red, text: "3")
      .frame(width: 100, height: 100)

    let view4 = ColorView(ColorPallete.blue, text: "4")
      .frame(width: 50, height: 50)

    let layout = Grid {
      GridRow {
        view1
        view2

      }
      GridRow {
        view3
        view4
          .gridCellAnchor(alignment)

      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )

  }

  func buildGridCellAnchorGridUnitPoints(_ unitPoint: UnitPoint, layoutDirection: LayoutDirection = .leftToRight) {
    let view1 = ColorView(ColorPallete.red, text: "1")
      .frame(width: 100, height: 100)
    let view2 = ColorView(ColorPallete.red, text: "2")
      .frame(width: 100, height: 100)

    let view3 = ColorView(ColorPallete.red, text: "3")
      .frame(width: 100, height: 100)

    let view4 = ColorView(ColorPallete.blue, text: "4")
      .frame(width: 50, height: 50)

    let layout = Grid {
      GridRow {
        view1
        view2

      }
      GridRow {
        view3
        view4
          .gridCellAnchor(unitPoint)

      }
    }
    .layoutDirection(layoutDirection)

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )

  }

  func buildRowAlignmentOverridesGridAlignment() {

    let view1 = ColorView(ColorPallete.red, text: "1")
      .frame(width: 100, height: 100)
    let view2 = ColorView(ColorPallete.blue, text: "2")
      .frame(width: 50, height: 50)

    let view3 = ColorView(ColorPallete.red, text: "3")
      .frame(width: 75, height: 75)

    let view4 = ColorView(ColorPallete.yellow, text: "4")
      .frame(width: 75, height: 75)

    let view5 = ColorView(ColorPallete.blue, text: "5")
      .frame(width: 50, height: 50)

    let view6 = ColorView(ColorPallete.yellow, text: "6")
      .frame(width: 100, height: 100)

    let layout = Grid(alignment: .top, horizontalSpacing: 10) {
      GridRow {
        view1
        view2
        view3

      }
      GridRow(alignment: .bottom) {
        view4
        view5
        view6

      }

    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )

  }

  func buildGridCellAnchorGridOverrideRowAlignment(alignment: Alignment) {

    let view1 = ColorView(ColorPallete.red, text: "1")
      .frame(width: 100, height: 100)
    let view2 = ColorView(ColorPallete.red, text: "2")
      .frame(width: 100, height: 100)

    let view3 = ColorView(ColorPallete.red, text: "3")
      .frame(width: 100, height: 100)

    let view4 = ColorView(ColorPallete.yellow, text: "4")
      .frame(width: 100, height: 100)

    let view5 = ColorView(ColorPallete.blue, text: "5")
      .frame(width: 50, height: 50)

    let view6 = ColorView(ColorPallete.blue, text: "6")
      .frame(width: 50, height: 50)

    let layout = Grid {
      GridRow {
        view1
        view2
        view3

      }
      GridRow(alignment: .top) {
        view4
        view5
        view6
          .gridCellAnchor(.bottom)

      }

    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )

  }

  // MARK: - Column Alignment Cases

  func buildGridColumnAlignment(alignment: HorizontalAlignment) {
    let view1 = ColorView(ColorPallete.red, text: "1")
      .frame(width: 100, height: 100)

    let view2 = ColorView(ColorPallete.yellow, text: "2")
      .frame(width: 75, height: 75)

    let view3 = ColorView(ColorPallete.blue, text: "3")
      .frame(width: 50, height: 50)

    let layout = Grid {
      GridRow {
        view1
          .gridColumnAlignment(alignment)
      }
      GridRow {
        view2
      }
      GridRow {
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func buildGridColumnAlignmentSecondRow(alignment: HorizontalAlignment) {
    let view1 = ColorView(ColorPallete.red, text: "1")
      .frame(width: 100, height: 100)

    let view2 = ColorView(ColorPallete.yellow, text: "2")
      .frame(width: 75, height: 75)

    let view3 = ColorView(ColorPallete.blue, text: "3")
      .frame(width: 50, height: 50)

    let layout = Grid {
      GridRow {
        view1
      }
      GridRow {
        view2
          .gridColumnAlignment(alignment)

      }
      GridRow {
        view3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  // Mark: - Test Cases

  // Single child Single Row

  func testSingleChildSingleRow() {
    buildSingleChildSingleRow()
  }

  func testSingleChildSingleRowUnbounded() {
    buildSingleChildSingleRowUnbounded()
  }

  // Single Child Multiple Row

  func testSingleChildMultipleRow() {
    buildSingleChildMultipleRow()
  }

  func testSingleChildMultipleRowWithVerticalSpacing() {
    buildSingleChildMultipleRow(verticalSpacing: 10)
  }

  // Multiple Children Single Row

  func testMultipleChildrenSingleRow() {
    buildMultipleChildrenSingleRow()
  }

  func testMultipleChildrenSingleRowRTL() {
    buildMultipleChildrenSingleRow(layoutDirection: .leftToRight)
  }

  func testMultipleChildrenSingleRowWithHorizontalSpacing() {
    buildMultipleChildrenSingleRow(horizontalSpacing: 10)
  }

  func testMultipleChildrenSingleRowWithHorizontalSpacingRTL() {
    buildMultipleChildrenSingleRow(horizontalSpacing: 10, layoutDirection: .rightToLeft)
  }

  func testMultipleChildrenSingleRowDifferentSizes() {
    buildMultipleChildrenSingleRowDifferentSizes()
  }

  func testMultipleChildrenSingleRowDifferentSizesWithHorizontalSpacing() {
    buildMultipleChildrenSingleRowDifferentSizes(horizontalSpacing: 10)
  }

  func testMultipleChildrenSingleRowUnbounded() {
    buildMultipleChildrenSingleRowUnbounded()
  }

  func testMultipleChildrenSingleRowUnboundedWithHorizontalSpacing() {
    buildMultipleChildrenSingleRowUnbounded(horizontalSpacing: 10)
  }

  func testMultipleChildrenSingleRowOneUnboundedView() {
    buildMultipleChildrenSingleRowOneUnboundedView()
  }

  // Multiple Children Multiple Rows

  func testMultipleChildrenMultipleRows() {
    buildMultipleChildrenMultipleRows()
  }

  func testMultipleChildrenMultipleRowsWithVerticalSpacing() {
    buildMultipleChildrenMultipleRows(verticalSpacing: 10)
  }

  func testMultipleChildrenMultipleRowsWithHorizontalSpacing() {
    buildMultipleChildrenMultipleRows(horizontalSpacing: 10)
  }

  func testMultipleChildrenMultipleRowsWithVerticalAndHorizontalSpacing() {
    buildMultipleChildrenMultipleRows(verticalSpacing: 10, horizontalSpacing: 10)
  }

  func testMultipleChildrenMultipleRowsUnbounded() {
    buildMultipleChildrenMultipleRowsUnbounded()
  }

  func testMultipleChildrenMultipleRowsUnboundedWithVerticalSpacing() {
    buildMultipleChildrenMultipleRowsUnbounded(verticalSpacing: 10)
  }

  func testMultipleChildrenMultipleRowsUnboundedWithHorizontalSpacing() {
    buildMultipleChildrenMultipleRowsUnbounded(horizontalSpacing: 10)
  }

  func testMultipleChildrenMultipleRowsUnboundedWithVerticalAndHorizontalSpacing() {
    buildMultipleChildrenMultipleRowsUnbounded(verticalSpacing: 10, horizontalSpacing: 10)
  }

  // Partial flexible wrapping cases

  func testMultipleChildrenSingleRowPartialWrapping() {
    buildMultipleChildrenSingleRowPartialWrapping()
  }

  func testMultipleChildrenSingleRowPartialWrappingWithHorizontalSpacing() {
    buildMultipleChildrenSingleRowPartialWrapping(horizontalSpacing: 10)
  }

  func testMultipleChildrenSingleRowPartialWrappingWithVerticalSpacing() {
    buildMultipleChildrenSingleRowPartialWrapping(verticalSpacing: 10)
  }

  func testMultipleChildrenSingleRowPartialWrappingWithVerticalAndHorizontalSpacing() {
    buildMultipleChildrenSingleRowPartialWrapping(horizontalSpacing: 10, verticalSpacing: 10)
  }

  func testMultipleChildrenSingleRowPartialWrappingUIView() {
    buildMultipleChildrenSingleRowPartialWrappingWithUIView()
  }

  func testMultipleChildrenSingleRowPartialWrappingUIViewWithHorizontalSpacing() {
    buildMultipleChildrenSingleRowPartialWrappingWithUIView(horizontalSpacing: 10)
  }

  func testMultipleChildrenSingleRowPartialWrappingUIViewWithVerticalSpacing() {
    buildMultipleChildrenSingleRowPartialWrappingWithUIView(verticalSpacing: 10)
  }

  func testMultipleChildrenSingleRowPartialWrappingUIViewWithVerticalAndHorizontalSpacing() {
    buildMultipleChildrenSingleRowPartialWrappingWithUIView(horizontalSpacing: 10, verticalSpacing: 10)
  }

  func testMultipleChildrenSingleRowTwoPartialWrappingLabels() {
    buildMultipleChildrenSingleRowTwoPartialWrappingLabels()
  }

  func testMultipleChildrenSingleRowTwoPartialWrappingLabelsWithHorizontalSpacing() {
    buildMultipleChildrenSingleRowTwoPartialWrappingLabels(horizontalSpacing: 10)
  }

  func testMultipleChildrenSingleRowTwoPartialWrappingLabelsWithVerticalSpacing() {
    buildMultipleChildrenSingleRowTwoPartialWrappingLabels(verticalSpacing: 10)
  }

  func testMultipleChildrenSingleRowTwoPartialWrappingLabelsWithVerticalAndHorizontalSpacing() {
    buildMultipleChildrenSingleRowTwoPartialWrappingLabels(horizontalSpacing: 10, verticalSpacing: 10)
  }

  // Layout Priority cases

  func testUnboundedViewsLayoutPriorityView1Highest() {
    buildUnboundedViewsWithLayoutPriority(view1LayoutPriority: 1)
  }

  func testUnboundedViewsLayoutPriorityView1Lowest() {
    buildUnboundedViewsWithLayoutPriority(view1LayoutPriority: -1)
  }

  func testUnboundedViewsLayoutPriorityView1andView2HigherPriority() {
    buildUnboundedViewsWithLayoutPriority(view1LayoutPriority: 1, view2LayoutPriority: 1)
  }

  func testUnboundedViewsLayoutPriorityEqualLayoutPriority() {
    buildUnboundedViewsWithLayoutPriority(view1LayoutPriority: 5, view2LayoutPriority: 5, view3LayoutPriority: 5)
  }

  // Grid alignment cases

  func testMultipleChildrenMultipleRowsWithGridAlignmentTop() {
    buildMultipleChildrenMultipleRowswithGridAlignment(alignment: .top)
  }
  func testMultipleChildrenMultipleRowsWithGridAlignmentTopLeading() {
    buildMultipleChildrenMultipleRowswithGridAlignment(alignment: .topLeading)
  }
  func testMultipleChildrenMultipleRowsWithGridAlignmentTopTrailing() {
    buildMultipleChildrenMultipleRowswithGridAlignment(alignment: .topTrailing)
  }
  func testMultipleChildrenMultipleRowsWithGridAlignmentBottom() {
    buildMultipleChildrenMultipleRowswithGridAlignment(alignment: .bottom)
  }
  func testMultipleChildrenMultipleRowsWithGridAlignmentBottomLeading() {
    buildMultipleChildrenMultipleRowswithGridAlignment(alignment: .bottomLeading)
  }
  func testMultipleChildrenMultipleRowsWithGridAlignmentBottomTrailing() {
    buildMultipleChildrenMultipleRowswithGridAlignment(alignment: .bottomTrailing)
  }
  func testMultipleChildrenMultipleRowsWithGridAlignmentLeading() {
    buildMultipleChildrenMultipleRowswithGridAlignment(alignment: .leading)
  }
  func testMultipleChildrenMultipleRowsWithGridAlignmentTrailing() {
    buildMultipleChildrenMultipleRowswithGridAlignment(alignment: .trailing)
  }

  // Row alignment cases

  func testMultipleChildrenSingleRowDifferentSizesWithTopAlignment() {
    buildMultipleChildrenSingleRowDifferentSizes(rowAlignment: .top)
  }

  func testMultipleChildrenSingleRowDifferentSizesWithBottomAlignment() {
    buildMultipleChildrenSingleRowDifferentSizes(rowAlignment: .bottom)
  }

  func testRowAlignmentOverridesGridAlignment() {
    buildRowAlignmentOverridesGridAlignment()
  }

  //Column alignment cases

  func testGridColumnAlignmentLeading() {
    buildGridColumnAlignment(alignment: .leading)
  }

  func testGridColumnAlignmentTrailing() {
    buildGridColumnAlignment(alignment: .trailing)
  }

  func testGridColumnAlignmentNotFirstRowLeading() {
    buildGridColumnAlignmentSecondRow(alignment: .leading)
  }

  func testGridColumnAlignmentNotFirstRowTrailing() {
    buildGridColumnAlignmentSecondRow(alignment: .trailing)
  }

  //Grid cell anchor cases

  func testGridCellAnchorTopLeading() {
    buildGridCellAnchorGrid(alignment: .topLeading)
  }

  func testGridCellAnchorTopTrailing() {
    buildGridCellAnchorGrid(alignment: .topTrailing)
  }

  func testGridCellAnchorBottomLeading() {
    buildGridCellAnchorGrid(alignment: .bottomLeading)
  }

  func testGridCellAnchorBottomTrailing() {
    buildGridCellAnchorGrid(alignment: .bottomTrailing)
  }

  func testGridCellAnchorCenter() {
    buildGridCellAnchorGrid(alignment: .center)
  }

  func testGridCellAnchorTop() {
    buildGridCellAnchorGrid(alignment: .top)
  }

  func testGridCellAnchorBottom() {
    buildGridCellAnchorGrid(alignment: .bottom)
  }

  func testGridCellAnchorLeading() {
    buildGridCellAnchorGrid(alignment: .leading)
  }

  func testGridCellAnchorTrailing() {
    buildGridCellAnchorGrid(alignment: .trailing)
  }

  func testGridCellAnchorUnitPointTopLeading() {
    buildGridCellAnchorGridUnitPoints(UnitPoint(x: 0, y: 0))
  }

  func testGridCellAnchorUnitPointTopTrailing() {
    buildGridCellAnchorGridUnitPoints(UnitPoint(x: 0, y: 1))
  }

  func testGridCellAnchorUnitPointBottomTrailingRTL() {
    buildGridCellAnchorGridUnitPoints(UnitPoint(x: 1, y: 1), layoutDirection: .rightToLeft)
  }

  func testGridCellAnchorUnitPointBottomLeading() {
    buildGridCellAnchorGridUnitPoints(UnitPoint(x: 1, y: 0))
  }

  func testGridCellAnchorUnitPointBottomTrailing() {
    buildGridCellAnchorGridUnitPoints(UnitPoint(x: 1, y: 1))
  }

  func testGridCellAnchorUnitPointCenter() {
    buildGridCellAnchorGridUnitPoints(UnitPoint(x: 0.5, y: 0.5))
  }

  func testGridCellAnchorUnitPointTop() {
    buildGridCellAnchorGridUnitPoints(UnitPoint(x: 0.5, y: 0))
  }

  func testGridCellAnchorUnitPointBottom() {
    buildGridCellAnchorGridUnitPoints(UnitPoint(x: 0.5, y: 1))
  }

  func testGridCellAnchorUnitPointLeading() {
    buildGridCellAnchorGridUnitPoints(UnitPoint(x: 0, y: 0.5))
  }

  func testGridCellAnchorUnitPointTrailing() {
    buildGridCellAnchorGridUnitPoints(UnitPoint(x: 1, y: 0.5))
  }

  func testGridCellAnchorUnitPointCustom() {
    buildGridCellAnchorGridUnitPoints(UnitPoint(x: 0.25, y: 0.75))
  }

  func testGridCellAnchorOverrideRowAlignment() {
    buildGridCellAnchorGridOverrideRowAlignment(alignment: .bottom)
  }

  func testGridWithFixedSizeElementsAndSpacerInBetween() {
    let view1 = ColorView(ColorPallete.blue, text: "1")
    let view2 = ColorView(ColorPallete.blue, text: "2")

    let layout = Grid(horizontalSpacing: 10, verticalSpacing: 10) {
      GridRow {
        view1
          .frame(width: 50, height: 50)
        Spacer()
        view2
          .frame(width: 50, height: 50)
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testGridWithFixedSizeElementsAndSpacerOnTheLeft() {
    let view1 = ColorView(ColorPallete.blue, text: "1")
    let view2 = ColorView(ColorPallete.blue, text: "2")

    let layout = Grid(horizontalSpacing: 10, verticalSpacing: 10) {
      GridRow {
        Spacer()
        view1
          .frame(width: 50, height: 50)
        view2
          .frame(width: 50, height: 50)
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testGridWithFixedSizeElementsAndSpacerOnTheRight() {
    let view1 = ColorView(ColorPallete.blue, text: "1")
    let view2 = ColorView(ColorPallete.blue, text: "2")

    let layout = Grid(horizontalSpacing: 10, verticalSpacing: 10) {
      GridRow {
        view1
          .frame(width: 50, height: 50)
        view2
          .frame(width: 50, height: 50)
        Spacer()
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testGridTwoLinesWithFixedSizeElementsAndSpacerOnTheRight() {
    let view1 = ColorView(ColorPallete.blue, text: "1")
    let view2 = ColorView(ColorPallete.blue, text: "2")

    let layout = Grid(horizontalSpacing: 10, verticalSpacing: 10) {
      GridRow {
        Spacer()
        view1
          .frame(width: 50, height: 50)
      }
      GridRow {
        Spacer()
        view2
          .frame(width: 100, height: 100)
      }

    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testGridTwoLinesWithFixedSizeElementsAndSpacerOnTheRight2() {
    let view1 = ColorView(ColorPallete.blue, text: "1")
    let view2 = ColorView(ColorPallete.blue, text: "2")

    let view3 = ColorView(ColorPallete.blue, text: "3")
    let view4 = ColorView(ColorPallete.blue, text: "4")

    let layout = Grid(horizontalSpacing: 10, verticalSpacing: 10) {
      GridRow {
        view1
          .frame(width: 20, height: 20)
        Spacer()
        view2
          .frame(width: 50, height: 50)
      }
      GridRow {
        view3
          .frame(width: 20, height: 20)
          .gridCellAnchor(.topLeading)
        Spacer()
        view4
          .frame(width: 100, height: 100)
      }

    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testLongLabelWithSpacerInBetween() {

    func buildLongLabel(color: UIColor) -> UILabel {
      let longLabel = UILabel()
      longLabel.text = "This is a long label that will wrap to multiple lines and will be truncated at the end of the line if it is too long to fit in the available space. This is a long label that will wrap to multiple lines and will be truncated at the end of the line if it is too long to fit in the available space. This is a long label that will wrap to multiple lines and will be truncated at the end of the line if it is too long to fit in the available space."
      longLabel.backgroundColor = color
      longLabel.font = .systemFont(ofSize: 10)
      longLabel.numberOfLines = 0
      return longLabel
    }

    let longLabel = buildLongLabel(color: .blue)
    let longLabel2 = buildLongLabel(color: .yellow)

    let layout = Grid {
      GridRow {
        longLabel
        Spacer()
        longLabel2
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )

  }

  func buildGridInvoiceLayout(shortDescriptions: Bool = false, addSpacerAfaterDescriptionHeader: Bool = false, addSpacerAfterDescriptionLabel: Bool = false, addEmptyLayoutAfterDescriptionLabel: Bool = false, size: CGSize = CGSize(width: 300, height: 600)) {
    let titleLabel1 = UILabel()
    titleLabel1.text = "Item"
    titleLabel1.font = .boldSystemFont(ofSize: 18)
    titleLabel1.numberOfLines = 0

    let titleLabel2 = UILabel()
    titleLabel2.text = "Description"
    titleLabel2.font = .boldSystemFont(ofSize: 18)
    titleLabel2.numberOfLines = 0

    let titleLabel3 = UILabel()
    titleLabel3.text = "Quantity"
    titleLabel3.font = .boldSystemFont(ofSize: 18)
    titleLabel3.numberOfLines = 0

    let titleLabel4 = UILabel()
    titleLabel4.text = "Price"
    titleLabel4.font = .boldSystemFont(ofSize: 18)
    titleLabel4.numberOfLines = 0

    let itemLabel1 = UILabel()
    itemLabel1.text = "Bread"
    itemLabel1.font = .systemFont(ofSize: 16)
    itemLabel1.numberOfLines = 0

    let itemLabel2 = UILabel()
    itemLabel2.text = "Milk"
    itemLabel2.font = .systemFont(ofSize: 16)
    itemLabel2.numberOfLines = 0

    let itemLabel3 = UILabel()
    itemLabel3.text = "Water"
    itemLabel3.font = .systemFont(ofSize: 16)
    itemLabel3.numberOfLines = 0

    let descriptionLabel1 = UILabel()
    descriptionLabel1.text = shortDescriptions ? "Fresh" : "Bread is a staple food made from crop"
    descriptionLabel1.font = .systemFont(ofSize: 16)
    descriptionLabel1.numberOfLines = 0

    let descriptionLabel2 = UILabel()
    descriptionLabel2.text = shortDescriptions ? "White" : "Milk is a white, nutritious drink made by cows"
    descriptionLabel2.font = .systemFont(ofSize: 16)
    descriptionLabel2.numberOfLines = 0

    let descriptionLabel3 = UILabel()
    descriptionLabel3.text = shortDescriptions ? "Liquid" : "Water is a transparent, tasteless, odorless liquid"
    descriptionLabel3.font = .systemFont(ofSize: 16)
    descriptionLabel3.numberOfLines = 0

    let quantityLabel1 = UILabel()
    quantityLabel1.text = "Qty 11"
    quantityLabel1.font = .systemFont(ofSize: 16)
    quantityLabel1.numberOfLines = 0

    let quantityLabel2 = UILabel()
    quantityLabel2.text = "Qty 32"
    quantityLabel2.font = .systemFont(ofSize: 16)
    quantityLabel2.numberOfLines = 0

    let quantityLabel3 = UILabel()
    quantityLabel3.text = "Qty 3"
    quantityLabel3.font = .systemFont(ofSize: 16)
    quantityLabel3.numberOfLines = 0

    let priceLabel1 = UILabel()
    priceLabel1.text = "$10.00"
    priceLabel1.font = .systemFont(ofSize: 16)
    priceLabel1.numberOfLines = 0

    let priceLabel2 = UILabel()
    priceLabel2.text = "$20.00"
    priceLabel2.font = .systemFont(ofSize: 16)
    priceLabel2.numberOfLines = 0

    let priceLabel3 = UILabel()
    priceLabel3.text = "$30.00"
    priceLabel3.font = .systemFont(ofSize: 16)
    priceLabel3.numberOfLines = 0

    let layout = Grid(alignment: .top, horizontalSpacing: 4, verticalSpacing: 4) {
      GridRow {
        titleLabel1
          .gridColumnAlignment(.leading)
        titleLabel2
          .gridColumnAlignment(.leading)

        if addSpacerAfaterDescriptionHeader {
          Spacer()
        }
        titleLabel3
          .gridColumnAlignment(.trailing)
        titleLabel4
          .gridColumnAlignment(.trailing)
      }

      GridRow {
        itemLabel1
        descriptionLabel1
        if addSpacerAfterDescriptionLabel {
          Spacer()
        } else if addEmptyLayoutAfterDescriptionLabel {
          EmptyLayout()
        }
        quantityLabel1
        priceLabel1
      }

      GridRow {
        itemLabel2
        descriptionLabel2
        if addSpacerAfterDescriptionLabel {
          Spacer()
        } else if addEmptyLayoutAfterDescriptionLabel {
          EmptyLayout()
        }
        quantityLabel2
        priceLabel2
      }

      GridRow {
        itemLabel3
        descriptionLabel3
        if addSpacerAfterDescriptionLabel {
          Spacer()
        } else if addEmptyLayoutAfterDescriptionLabel {
          EmptyLayout()
        }
        quantityLabel3
        priceLabel3
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(size)
    )
  }
  func testGridInvoiceLayout() {
    buildGridInvoiceLayout()
  }

  func testGridInvoiceLayoutWithShortDescription() {
    buildGridInvoiceLayout(shortDescriptions: true)
  }

  func testGridInvoiceLayoutWithShortDescriptionWithSpacers() {
    buildGridInvoiceLayout(shortDescriptions: true, addSpacerAfaterDescriptionHeader: true, addSpacerAfterDescriptionLabel: true, size: CGSize(width: 600, height: 600))
  }

  func testNotEqualAmountOfColumns() {
    let view1 = ColorView(ColorPallete.red, text: "1")
    let view2 = ColorView(ColorPallete.red, text: "2")
    let view3 = ColorView(ColorPallete.red, text: "3")

    let layout = Grid {
      GridRow {
        view1
          .frame(width: 100, height: 100)
        view2
          .frame(width: 100, height: 100)
      }

      GridRow {
        view3
          .frame(width: 100, height: 100)
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 300, height: 300))
    )
  }

  func testThatTheTextWillBeRemeasuredAfterLargerFixdSizeElement() {
    let view1 = ColorView(ColorPallete.orange, text: "1")
    let view2 = ColorView(ColorPallete.blue, text: "2")
    let view3 = ColorView(ColorPallete.yellow, text: "3")

    let titleLabel1 = UILabel()
    titleLabel1.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
    titleLabel1.font = .boldSystemFont(ofSize: 18)
    titleLabel1.numberOfLines = 0

    let layout = Grid {
      GridRow {
        view1
          .frame(width: 100, height: 10)
        view2
          .frame(width: 100, height: 10)
        view3
          .frame(width: 100, height: 10)
      }

      GridRow {
        titleLabel1
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200))
    )
  }

  func testThatTheTextWillBeRemeasuredAfterLargerFixdSizeElementVertically() {
    let view1 = ColorView(ColorPallete.orange, text: "1")
    let view2 = ColorView(ColorPallete.blue, text: "2")
    let view3 = ColorView(ColorPallete.yellow, text: "3")

    let titleLabel1 = UILabel()
    titleLabel1.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
    titleLabel1.font = .boldSystemFont(ofSize: 18)
    titleLabel1.numberOfLines = 0

    let layout = Grid {
      GridRow {
        view1
          .frame(width: 10, height: 100)
        titleLabel1
      }

      GridRow {
        view2
          .frame(width: 10, height: 100)
      }

      GridRow {
        view3
          .frame(width: 10, height: 100)
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200))
    )
  }

  func testEmptyGrid() {
    let v = UIView()
    let grid1 = Grid {

    }

    let grid2 = Grid {
      GridRow {

      }
    }

    let layout = VStack {
      grid1
      grid2
      v.frame(width: 1, height: 1)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200))
    )
  }

  func testJustLabel() {
    let label = UILabel()
    label.text = "Lorem ipsum dolor"
    label.font = .boldSystemFont(ofSize: 18)
    label.numberOfLines = 0

    let layout = Grid {
      GridRow {
        label
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200))
    )
  }

  func testJustTwoLabelInSingleRow() {
    let label = UILabel()
    label.text = "Lorem ipsum dolor"
    label.font = .boldSystemFont(ofSize: 18)
    label.numberOfLines = 0

    let label2 = UILabel()
    label2.text = "Lorem ipsum dolor sit amet elit"
    label2.font = .boldSystemFont(ofSize: 18)
    label2.numberOfLines = 0

    let layout = Grid {
      GridRow {
        label
        label2
      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200))
    )
  }

  func testJustTwoLabelInSingleColumn() {
    let label = UILabel()
    label.text = "Lorem ipsum dolor"
    label.font = .boldSystemFont(ofSize: 18)
    label.numberOfLines = 0

    let label2 = UILabel()
    label2.text = "Lorem ipsum dolor sit amet elit"
    label2.font = .boldSystemFont(ofSize: 18)
    label2.numberOfLines = 0

    let layout = Grid {
      GridRow {
        label
      }
      GridRow {
        label2
      }
      GridRow {

      }
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 200, height: 200))
    )
  }

  func testWithSliders() {
    let label = UILabel()
    label.text = "Lorem ipsum"
    label.font = .boldSystemFont(ofSize: 18)
    label.numberOfLines = 0

    let label2 = UILabel()
    label2.text = "Lorem ipsum dolor sit"
    label2.font = .boldSystemFont(ofSize: 18)
    label2.numberOfLines = 0

    let slider1 = UISlider()
    slider1.minimumValue = 0
    slider1.maximumValue = 100
    slider1.value = 60

    let slider2 = UISlider()
    slider2.minimumValue = 0
    slider2.maximumValue = 100
    slider2.value = 40

    let layout = Grid(alignment: .leading, horizontalSpacing: 10) {
      GridRow {
        label
        slider1
      }
      GridRow {
        label2
        slider2
      }
    }
    .padding(.horizontal, 16)

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 400, height: 300))
    )
  }

}
