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
final class NewsFeedItemWithFlatHeirarchyViewServerSnaposhTests: FBServerSnapshotTestCase {

  private func runTest(content: TestNewsFeedView.Content) {
    let view = TestNewsFeedView()
    view.prepare()
    view.setContent(content)
    takeSnapshot(
      of: view,
      in: .proposed(CGSize(width: 320, height: 700))
    )
  }

  private func runMultiScreenTest(content: TestNewsFeedView.Content, font: (UITraitCollection) -> UIFont) {
    makeMultipleViewSnapshot(
      viewFactory: { contentSizeCategory in
        let traitCollection = UITraitCollection(preferredContentSizeCategory: contentSizeCategory)
        let view = TestNewsFeedView()
        view.prepare()
        view.setContent(content)
        view.setFont(font(traitCollection))
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        return view
      },
      configuration: SnapshotConfiguration(
        screenSizes: [.iPhoneSmall, .iPhoneMedium, .iPhoneLarge],
        preferredContentSizeCategories: [.extraSmall, .small, .medium, .large, .extraExtraExtraLarge],
        sizingStrategy: [.assign, .measureVerticalIntrinsicSize(clampWithScreenSize: true), .measureVerticalIntrinsicSize(clampWithScreenSize: false)]
      )
    )
  }

  func testShortText() {
    let content = TestNewsFeedView.Content(
      actionText: "Action",
      posterName: "Poster Name",
      posterHeadline: "Poster Headline",
      posterTime: "Poster Time",
      posterComment: "Poster Comment",
      contentTitle: "Content Title",
      contentDomain: "Content Domain",
      actorComment: "Actor Comment",
      numberOfLines: 1
    )
    runTest(content: content)
  }

  func testLongText() {
    let content = TestNewsFeedView.Content(
      actionText: "Action Nulla non sem et tortor euismod ornare. Duis blandit porta. End!!!",
      posterName: "Poster Name Aenean nec consectetur massa. Pellentesque id rhoncus metus. Suspendisse tincidunt. End!!!",
      posterHeadline: "Poster Headline Integer pulvinar mollis ipsum, vel condimentum velit efficitur id. End!!!",
      posterTime: "Poster Time Morbi laoreet, augue nec consequat elementum, arcu risus facilisis odio. End!!!",
      posterComment: "Poster Comment Cras vulputate justo arcu, ac varius nunc tempus suscipit. End!!!",
      contentTitle: "Content Title Nulla sed iaculis libero. End!!!",
      contentDomain: "Content Domain Nam vitae neque quis mi rhoncus dictum eu ut tellus. End!!!",
      actorComment: "Actor Comment Suspendisse eget posuere tortor. Pellentesque et mi mauris. Orci varius. End!!!",
      numberOfLines: 1
    )
    runTest(content: content)
  }

  func testLongTextMultiline() {
    let content = TestNewsFeedView.Content(
      actionText: "Action Nulla non sem et tortor euismod ornare. Duis blandit porta. End!!!",
      posterName: "Poster Aenean nec consectetur massa. Pellentesque id rhoncus metus. Suspendisse tincidunt. End!!!",
      posterHeadline: "Poster Headline Integer pulvinar mollis ipsum, vel condimentum velit efficitur id. End!!",
      posterTime: "Poster Time Morbi laoreet, augue nec consequat elementum, arcu risus facilisis odio. End!!!",
      posterComment: "Poster Comment Cras vulputate justo arcu, ac varius nunc tempus suscipit. End!!!",
      contentTitle: "Content Title Nulla sed iaculis libero. End!!!",
      contentDomain: "Content Domain Nam vitae neque quis mi rhoncus dictum eu ut tellus. End!!!",
      actorComment: "Actor Comment Suspendisse eget posuere tortor. Pellentesque et mi mauris. Orci varius. End!!!",
      numberOfLines: 0
    )
    runTest(content: content)
  }

  func test_GetStarted() {
    let content = TestNewsFeedView.Content(
      actionText: "Action Nulla non sem et tortor euismod ornare. Duis blandit porta. End!!!",
      posterName: "Poster Aenean nec consectetur massa. Pellentesque id rhoncus metus. Suspendisse tincidunt. End!!!",
      posterHeadline: "Poster Headline Integer pulvinar mollis ipsum, vel condimentum velit efficitur id. End!!",
      posterTime: "Poster Time Morbi laoreet, augue nec consequat elementum, arcu risus facilisis odio. End!!!",
      posterComment: "Poster Comment Cras vulputate justo arcu, ac varius nunc tempus suscipit. End!!!",
      contentTitle: "Content Title Nulla sed iaculis libero. End!!!",
      contentDomain: "Content Domain Nam vitae neque quis mi rhoncus dictum eu ut tellus. End!!!",
      actorComment: "Actor Comment Suspendisse eget posuere tortor. Pellentesque et mi mauris. Orci varius. End!!!",
      numberOfLines: 0
    )
    runMultiScreenTest(
      content: content,
      font: { traitCollection in
        UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
      })
  }
}

private final class TestNewsFeedView: UIView {

  struct Content {
    let actionText: String
    let posterName: String
    let posterHeadline: String
    let posterTime: String
    let posterComment: String
    let contentTitle: String
    let contentDomain: String
    let actorComment: String
    let numberOfLines: Int
  }

  let actionLabel = UILabel()
  let optionsLabel = UILabel()
  let posterImageView = TestPlaceholderView(lineColor: UIColor.black)
  let posterNameLabel = UILabel()
  let posterHeadlineLabel = UILabel()
  let posterTimeLabel = UILabel()
  let posterCommentLabel = UILabel()
  let contentImageView = TestPlaceholderView(lineColor: UIColor.black)
  let contentTitleLabel = UILabel()
  let contentDomainLabel = UILabel()
  let likeLabel = UILabel()
  let commentLabel = UILabel()
  let shareLabel = UILabel()
  let actorImageView = TestPlaceholderView(lineColor: UIColor.black)
  let actorCommentLabel = UILabel()

  func prepare() {
    self.backgroundColor = .white
    contentImageView.backgroundColor = .black
    posterImageView.backgroundColor = .black
    actorImageView.backgroundColor = .black

    self.addSubview(actionLabel)
    self.addSubview(optionsLabel)
    self.addSubview(posterImageView)
    self.addSubview(posterNameLabel)
    self.addSubview(posterHeadlineLabel)
    self.addSubview(posterTimeLabel)
    self.addSubview(posterCommentLabel)
    self.addSubview(contentImageView)
    self.addSubview(contentTitleLabel)
    self.addSubview(contentDomainLabel)
    self.addSubview(likeLabel)
    self.addSubview(commentLabel)
    self.addSubview(shareLabel)
    self.addSubview(actorImageView)
    self.addSubview(actorCommentLabel)
  }

  func setFont(_ font: UIFont) {
    actionLabel.font = font
    posterNameLabel.font = font
    posterHeadlineLabel.font = font
    posterTimeLabel.font = font
    posterCommentLabel.font = font
    contentTitleLabel.font = font
    contentDomainLabel.font = font
    actorCommentLabel.font = font
  }

  func setContent(_ content: Content) {
    optionsLabel.text = "..."
    likeLabel.text = "Like"
    commentLabel.text = "Comment"
    shareLabel.text = "Share"

    actionLabel.text = content.actionText
    posterNameLabel.text = content.posterName
    posterHeadlineLabel.text = content.posterHeadline
    posterTimeLabel.text = content.posterTime
    posterCommentLabel.text = content.posterComment
    contentTitleLabel.text = content.contentTitle
    contentDomainLabel.text = content.contentDomain
    actorCommentLabel.text = content.actorComment

    actionLabel.numberOfLines = content.numberOfLines
    posterNameLabel.numberOfLines = content.numberOfLines
    posterHeadlineLabel.numberOfLines = content.numberOfLines
    posterTimeLabel.numberOfLines = content.numberOfLines
    posterCommentLabel.numberOfLines = content.numberOfLines
    contentTitleLabel.numberOfLines = content.numberOfLines
    contentDomainLabel.numberOfLines = content.numberOfLines
    actorCommentLabel.numberOfLines = content.numberOfLines
  }

  @LayoutBuilder
  func layout() -> Layout {
    VStack(alignment: .leading) {

      HStack {
        actionLabel
        Spacer()
        optionsLabel
      }

      HStack {
        posterImageView
          .resizable()
          .frame(width: 50, height: 50)

        Spacer(2)

        VStack(alignment: .leading) {
          posterNameLabel
          posterHeadlineLabel
          posterTimeLabel
        }
      }

      posterCommentLabel
      contentImageView
        .resizable()
        .aspectRatio(CGSize(width: 350, height: 200))

      contentTitleLabel
      contentDomainLabel
      HStack {
        likeLabel
        Spacer()
        commentLabel
        Spacer()
        shareLabel
      }
      HStack {
        actorImageView
          .resizable()
          .frame(width: 50, height: 50)
        Spacer(4)
        actorCommentLabel
      }
    }
    .padding(.horizontal, 8)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    layout().applyFrame(bounds)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return layout().sizeThatFits(size)
  }
}
