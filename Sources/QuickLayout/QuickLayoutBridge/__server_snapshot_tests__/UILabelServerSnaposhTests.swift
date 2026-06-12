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
final class UILabelServerSnaposhTests: FBServerSnapshotTestCase {

  func testLabelsFirstIsLong() {

    let view1 = UILabel()
    view1.text = "Mauris ullamcorper lacus eget enim feugiat rhoncus. Nullam vulputate enim ac lorem consequat faucibus."
    view1.numberOfLines = 0

    let view2 = UILabel()
    view2.text = "Lorem Ip"

    let layout = HStack {
      view1
      Spacer(8)
      view2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 480))
    )
  }

  func testLabelsSecondIsLong() {
    let view1 = UILabel()
    view1.text = "Lorem Ip"

    let view2 = UILabel()
    view2.text = "Mauris ullamcorper lacus eget enim feugiat rhoncus. Nullam vulputate enim ac lorem consequat faucibus."
    view2.numberOfLines = 0

    let layout = HStack {
      view1
      Spacer(8)
      view2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 480))
    )
  }

  func testLabelsFirstIsLongWithTopAlignment() {

    let view1 = UILabel()
    view1.text = "Mauris ullamcorper lacus eget enim feugiat rhoncus. Nullam vulputate enim ac lorem consequat faucibus."
    view1.numberOfLines = 0

    let view2 = UILabel()
    view2.text = "Lorem Ip"

    let layout = HStack(alignment: .top) {
      view1
      Spacer(8)
      view2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 480))
    )
  }

  func testTwoLabelsWithCustomFonts() {
    let view1 = UILabel()
    view1.font = UIFont.boldSystemFont(ofSize: 20)
    view1.text = "Mauris ullamcorper lacus eget enim feugiat rhoncus. Nullam vulputate enim ac lorem consequat faucibus."
    view1.numberOfLines = 0
    view1.backgroundColor = ColorPallete.orange

    let view2 = UILabel()
    view2.font = UIFont.boldSystemFont(ofSize: 30)
    view2.text = "Lorem Ip"
    view2.backgroundColor = ColorPallete.blue

    let layout = HStack(alignment: .top) {
      view1
      Spacer(8)
      view2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 480))
    )
  }

  func testTwoLabelsWithCustomSetWithAttributedString() {
    let view1 = UILabel()
    view1.attributedText = NSAttributedString(
      string: "Mauris ullamcorper lacus eget enim feugiat rhoncus. Nullam vulputate enim ac lorem consequat faucibus.",
      attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
    view1.numberOfLines = 0
    view1.backgroundColor = ColorPallete.orange

    let view2 = UILabel()
    view2.attributedText = NSAttributedString(
      string: "Lorem Ip",
      attributes: [.font: UIFont.boldSystemFont(ofSize: 30)])
    view2.backgroundColor = ColorPallete.blue

    let layout = HStack(alignment: .top) {
      view1
      Spacer(8)
      view2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 480))
    )
  }

  func testTwoLabelsWithCustomFontsWithNewLines() {
    let view1 = UILabel()
    view1.font = UIFont.boldSystemFont(ofSize: 20)
    view1.text = "Mauris ullamcorper lacus eget enim feugiat rhoncus.\n\nNullam vulputate enim ac lorem consequat faucibus."
    view1.numberOfLines = 0
    view1.backgroundColor = ColorPallete.orange

    let view2 = UILabel()
    view2.font = UIFont.boldSystemFont(ofSize: 30)
    view2.text = "Lorem Ip\n\nEtiam faucibus"
    view2.numberOfLines = 0
    view2.backgroundColor = ColorPallete.blue

    let layout = HStack(alignment: .top) {
      view1
      Spacer(8)
      view2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 480))
    )
  }

  func testTwoLabelsWithCustomSetWithAttributedStringWithNewLines() {
    let view1 = UILabel()
    view1.attributedText = NSAttributedString(
      string: "Mauris ullamcorper lacus eget enim feugiat rhoncus. \n\nNullam vulputate enim ac lorem consequat faucibus.",
      attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
    view1.numberOfLines = 0
    view1.backgroundColor = ColorPallete.orange

    let view2 = UILabel()
    view2.attributedText = NSAttributedString(
      string: "Lorem Ip\n\nEtiam faucibus",
      attributes: [.font: UIFont.boldSystemFont(ofSize: 30)])
    view2.numberOfLines = 0
    view2.backgroundColor = ColorPallete.blue

    let layout = HStack(alignment: .top) {
      view1
      Spacer(8)
      view2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 480))
    )
  }

  func testTwoLabelsWithCustomFontsAndEmojies() {
    let view1 = UILabel()
    view1.font = UIFont.boldSystemFont(ofSize: 20)
    view1.text = "Mauris ullamcorper 👪 👨‍👩‍👦 👨‍👩‍👧 👨‍👩‍👧‍👦 👨‍👩‍👦‍👦 👨‍👩‍👧‍👧 👨‍👨‍👦"
    view1.numberOfLines = 0
    view1.backgroundColor = ColorPallete.orange

    let view2 = UILabel()
    view2.font = UIFont.boldSystemFont(ofSize: 30)
    view2.text = "🥳 🙂‍↕️ 😏 😒"
    view2.backgroundColor = ColorPallete.blue

    let layout = HStack(alignment: .top) {
      view1
      Spacer(8)
      view2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 480))
    )
  }

  func testTwoLabelsWithCustomSetWithAttributedStringAndEmojies() {
    let view1 = UILabel()
    view1.attributedText = NSAttributedString(
      string: "Mauris ullamcorper 👪 👨‍👩‍👦 👨‍👩‍👧\n\n👨‍👩‍👧‍👦 👨‍👩‍👦‍👦 👨‍👩‍👧‍👧 👨‍👨‍👦",
      attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
    view1.numberOfLines = 0
    view1.backgroundColor = ColorPallete.orange

    let view2 = UILabel()
    view2.numberOfLines = 0
    view2.attributedText = NSAttributedString(
      string: "🥳 🙂‍↕️\n\n😏 😒",
      attributes: [.font: UIFont.boldSystemFont(ofSize: 30)])
    view2.backgroundColor = ColorPallete.blue

    let layout = HStack(alignment: .top) {
      view1
      Spacer(8)
      view2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 480))
    )
  }

  func testTwoLongLabels() {

    let view1 = UILabel()
    view1.text = "Vestibulum sit amet magna erat. Nullam sed mi snatch sit amet"
    view1.numberOfLines = 0

    let view2 = UILabel()
    view2.text = "Vestibulum sit amet magna erat. Nullam sed mi snatch sit amet"
    view2.numberOfLines = 0

    let layout = HStack(alignment: .top) {
      view1
      Spacer(8)
      view2
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 480))
    )
  }

  func testTwoLongLabelsWithLayoutPriority() {
    let view1 = UILabel()
    view1.text = "Vestibulum sit amet magna erat. Nullam sed mi snatch sit amet"
    view1.numberOfLines = 0

    let view2 = UILabel()
    view2.text = "Vestibulum sit amet magna erat. Nullam sed mi snatch sit amet"
    view2.numberOfLines = 0

    let layout = HStack(alignment: .top) {
      view1
      Spacer(8)
      view2
        .layoutPriority(1)
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 480))
    )
  }

  func testSizeRoundDown() {
    let font = UIFont.systemFont(ofSize: 19)
    let text = "Hello World!\ntwo lines"

    let height = NSAttributedString(string: text, attributes: [.font: font])
      .boundingRect(with: CGSize(width: 150.0, height: font.lineHeight * 2), options: .usesLineFragmentOrigin, context: nil)
      .height

    let label = UILabel()
    label.font = font
    label.text = text
    label.numberOfLines = 2
    label.layer.borderColor = UIColor.systemGray.cgColor
    label.layer.borderWidth = 1

    let layout = HStack {
      label
        .frame(height: height - 0.111)
    }

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 150, height: 150))
    )
  }
}
