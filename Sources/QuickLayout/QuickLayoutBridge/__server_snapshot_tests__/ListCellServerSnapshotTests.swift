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
final class ListCellItemViewServerSnaposhTests: FBServerSnapshotTestCase {

  private func runTest(
    title: String,
    subtitle: String,
    content: String,
    time: String,
    multiline: Bool = false
  ) {

    let titleLabel = UILabel()
    let subtitlLabel = UILabel()
    let contentLabel = UILabel()
    let timeLabel = UILabel()
    let iconView = UIView()
    iconView.backgroundColor = .black
    contentLabel.numberOfLines = 2

    titleLabel.text = title
    subtitlLabel.text = subtitle
    contentLabel.text = content
    timeLabel.text = time

    if multiline {
      titleLabel.numberOfLines = 0
      subtitlLabel.numberOfLines = 0
      contentLabel.numberOfLines = 0
      timeLabel.numberOfLines = 0
    }

    let layout = VStack(alignment: .leading) {
      HStack {
        titleLabel
        Spacer()
        timeLabel
        Spacer(4)
        iconView
          .frame(width: 10, height: 10)
      }
      subtitlLabel
      contentLabel
    }
    .padding(.horizontal, 8)

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 700))
    )
  }

  func testShortText() {
    runTest(
      title: "Title",
      subtitle: "Subitle",
      content: "Content",
      time: "22:00"
    )
  }

  func testLongText() {
    runTest(
      title: "Title Nulla non sem et tortor euismod ornare. Duis blandit porta. End!!!",
      subtitle: "Subtitle Name Aenean nec consectetur massa. Pellentesque id rhoncus metus. Suspendisse tincidunt. End!!!",
      content: "Content Headline Integer pulvinar mollis ipsum, vel condimentum velit efficitur id. End!!!",
      time: "22:00"
    )
  }

  func testLongTextMultiline() {
    runTest(
      title: "Title Nulla non sem et tortor euismod ornare. Duis blandit porta. End!!!",
      subtitle: "Subtitle Name Aenean nec consectetur massa. Pellentesque id rhoncus metus. Suspendisse tincidunt. End!!!",
      content: "Content Headline Integer pulvinar mollis ipsum, vel condimentum velit efficitur id. End!!!",
      time: "22:00",
      multiline: true
    )
  }
}
