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
final class ComputeStackLayoutSizeThatFitsCountTests: XCTestCase {

  func test_SizeThatFitsInvocationCountWithFuzzyLayoutComparison() {
    let view1 = TestView()
    let view2 = TestView()

    view1.sizeThatFitsBlock = { size in
      return CGSize(width: size.width, height: 150.00000000000007)
    }

    view2.sizeThatFitsBlock = { size in
      return CGSize(width: size.width, height: 150.00000000000008)
    }

    let view = VStack {
      view1
      view2
    }
    view.sizeThatFits(CGSize(width: 400.0, height: 300.0))

    XCTAssertEqual(view1.sizeThatFitsCounter, 1)
    XCTAssertEqual(view2.sizeThatFitsCounter, 1)
  }

  func test_SizeThatFitsInvocationCount_FuzzyComparisonTolerance() {
    let view1 = TestView()
    let view2 = TestView()
    let view3 = TestView()

    view1.sizeThatFitsBlock = { size in
      return CGSize(width: size.width, height: 100.0001)
    }

    view2.sizeThatFitsBlock = { size in
      return CGSize(width: size.width, height: 99.99995)
    }

    view3.sizeThatFitsBlock = { size in
      /// This view will be double measured because the resulting layout is crossing the fuzzy comparison threshold.
      return CGSize(width: size.width, height: 100.0002)
    }

    let view = VStack {
      view1
      view2
      view3
    }
    view.sizeThatFits(CGSize(width: 400.0, height: 300.0))

    XCTAssertEqual(view1.sizeThatFitsCounter, 1)
    XCTAssertEqual(view2.sizeThatFitsCounter, 1)
    XCTAssertEqual(view3.sizeThatFitsCounter, 2)
  }

  func test_SizeThatFitsInvocationCountWithInfinitySize() {
    let view = FeedItemQuicklyView(frame: .zero)
    _ = view.sizeThatFits(CGSize(width: 400.0, height: .infinity))

    // Image Views are wrapped in .resizable() modifier,
    // so the Quickly doesn't call sizeThatFits for them.
    XCTAssertEqual(view.actorImageView.sizeThatFitsCounter, 0)
    XCTAssertEqual(view.contentImageView.sizeThatFitsCounter, 0)
    XCTAssertEqual(view.posterImageView.sizeThatFitsCounter, 0)

    XCTAssertEqual(view.actionLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.optionsLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.posterNameLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.posterHeadlineLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.posterTimeLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.posterCommentLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.contentTitleLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.contentDomainLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.likeLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.commentLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.shareLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.actorCommentLabel.sizeThatFitsCounter, 1)
  }

  func test_SizeThatFitsInvocationCountWithExactContentSize() {
    let viewForMeasure = FeedItemQuicklyView(frame: .zero)
    let size = viewForMeasure.sizeThatFits(CGSize(width: 400.0, height: .infinity))

    let view = FeedItemQuicklyView(frame: .zero)
    _ = view.sizeThatFits(size)

    // Image Views are wrapped in .resizable() modifier,
    // so the Quickly doesn't call sizeThatFits for them.
    XCTAssertEqual(view.actorImageView.sizeThatFitsCounter, 0)
    XCTAssertEqual(view.contentImageView.sizeThatFitsCounter, 0)
    XCTAssertEqual(view.posterImageView.sizeThatFitsCounter, 0)

    XCTAssertEqual(view.actionLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.optionsLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.posterNameLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.posterHeadlineLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.posterTimeLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.posterCommentLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.contentTitleLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.contentDomainLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.likeLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.commentLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.shareLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.actorCommentLabel.sizeThatFitsCounter, 1)
  }

  func test_SizeThatFitsInvocationCountWithSmallerContentSize_40() {
    let viewForMeasure = FeedItemQuicklyView(frame: .zero)
    var size = viewForMeasure.sizeThatFits(CGSize(width: 400.0, height: .infinity))
    size.height -= 40

    let view = FeedItemQuicklyView(frame: .zero)
    _ = view.sizeThatFits(size)

    // Image Views are wrapped in .resizable() modifier,
    // so the Quickly doesn't call sizeThatFits for them.
    XCTAssertEqual(view.actorImageView.sizeThatFitsCounter, 0)
    XCTAssertEqual(view.contentImageView.sizeThatFitsCounter, 0)
    XCTAssertEqual(view.posterImageView.sizeThatFitsCounter, 0)

    XCTAssertEqual(view.actionLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.optionsLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.posterNameLabel.sizeThatFitsCounter, 3)
    XCTAssertEqual(view.posterHeadlineLabel.sizeThatFitsCounter, 3)
    XCTAssertEqual(view.posterTimeLabel.sizeThatFitsCounter, 3)
    XCTAssertEqual(view.posterCommentLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.contentTitleLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.contentDomainLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.likeLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.commentLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.shareLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.actorCommentLabel.sizeThatFitsCounter, 2)
  }

  func test_SizeThatFitsInvocationCountWithHardcodedSize400x400() {

    let view = FeedItemQuicklyView(frame: .zero)
    _ = view.sizeThatFits(CGSize(width: 400.0, height: 400))

    // Image Views are wrapped in .resizable() modifier,
    // so the Quickly doesn't call sizeThatFits for them.
    XCTAssertEqual(view.actorImageView.sizeThatFitsCounter, 0)
    XCTAssertEqual(view.contentImageView.sizeThatFitsCounter, 0)
    XCTAssertEqual(view.posterImageView.sizeThatFitsCounter, 0)

    XCTAssertEqual(view.actionLabel.sizeThatFitsCounter, 2)
    XCTAssertEqual(view.optionsLabel.sizeThatFitsCounter, 2)
    XCTAssertEqual(view.posterNameLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.posterHeadlineLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.posterTimeLabel.sizeThatFitsCounter, 1)
    XCTAssertEqual(view.posterCommentLabel.sizeThatFitsCounter, 2)
    XCTAssertEqual(view.contentTitleLabel.sizeThatFitsCounter, 2)
    XCTAssertEqual(view.contentDomainLabel.sizeThatFitsCounter, 2)
    XCTAssertEqual(view.likeLabel.sizeThatFitsCounter, 2)
    XCTAssertEqual(view.commentLabel.sizeThatFitsCounter, 2)
    XCTAssertEqual(view.shareLabel.sizeThatFitsCounter, 2)
    XCTAssertEqual(view.actorCommentLabel.sizeThatFitsCounter, 2)
  }
}

final class FeedItemQuicklyView: UIView {

  func isAutoLayout() -> Bool {
    return false
  }

  let actionLabel = CountedLabel()
  let optionsLabel = CountedLabel()
  let posterImageView = FixedSizeViewView(intrinsicSize: CGSize(width: 50, height: 50))
  let posterNameLabel = CountedLabel()
  let posterHeadlineLabel = CountedLabel()
  let posterTimeLabel = CountedLabel()
  let posterCommentLabel = CountedLabel()
  let contentImageView = FixedSizeViewView(intrinsicSize: CGSize(width: 350, height: 200))
  let contentTitleLabel = CountedLabel()
  let contentDomainLabel = CountedLabel()
  let likeLabel = CountedLabel()
  let commentLabel = CountedLabel()
  let shareLabel = CountedLabel()
  let actorImageView = FixedSizeViewView(intrinsicSize: CGSize(width: 50, height: 50))
  let actorCommentLabel = CountedLabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    actionLabel.numberOfLines = 0
    posterNameLabel.numberOfLines = 0
    posterHeadlineLabel.numberOfLines = 0
    posterTimeLabel.numberOfLines = 0
    posterCommentLabel.numberOfLines = 0
    contentTitleLabel.numberOfLines = 0
    contentDomainLabel.numberOfLines = 0
    actorCommentLabel.numberOfLines = 0
    prepareViewHierarchy()
    setData()
    prepareLayout()
  }

  func prepareViewHierarchy() {
    addSubview(actionLabel)
    addSubview(optionsLabel)
    addSubview(posterImageView)
    addSubview(posterNameLabel)
    addSubview(posterHeadlineLabel)
    addSubview(posterTimeLabel)
    addSubview(posterCommentLabel)
    addSubview(contentImageView)
    addSubview(contentTitleLabel)
    addSubview(contentDomainLabel)
    addSubview(likeLabel)
    addSubview(commentLabel)
    addSubview(shareLabel)
    addSubview(actorImageView)
    addSubview(actorCommentLabel)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setData() {
    actionLabel.text = "lorem"
    posterNameLabel.text = "lorem"
    posterHeadlineLabel.text = "lorem"
    posterTimeLabel.text = "lorem"
    posterCommentLabel.text = "lorem"
    contentTitleLabel.text = "lorem"
    contentDomainLabel.text = "lorem"
    actorCommentLabel.text = "lorem"
    likeLabel.text = "Like"
    commentLabel.text = "Comment"
    shareLabel.text = "Share"
    optionsLabel.text = "..."
    setNeedsLayout()
  }

  private var layout: Layout?

  func prepareLayout() {
    self.layout = VStack(alignment: .leading) {
      HStack {
        actionLabel
        Spacer()
        Spacer(8)
        optionsLabel
      }

      Spacer(8)
      HStack(alignment: .top) {
        posterImageView
          .resizable()
          .frame(width: 50, height: 50)

        Spacer(8)

        VStack(alignment: .leading) {
          posterNameLabel
          Spacer(8)
          posterHeadlineLabel
          Spacer(8)
          posterTimeLabel
        }
      }
      Spacer(8)
      posterCommentLabel
      Spacer(8)
      contentImageView
        .resizable()
        .frame(height: 200)
      Spacer(8)
      contentTitleLabel
      Spacer(8)
      contentDomainLabel
      Spacer(8)
      HStack {
        likeLabel
        Spacer()
        commentLabel
        Spacer()
        shareLabel
      }
      Spacer(8)
      HStack(alignment: .top) {
        actorImageView
          .resizable()
          .frame(width: 50, height: 50)
        Spacer(8)
        actorCommentLabel
      }
    }
    .padding(8)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    layout?.applyFrame(bounds)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    layout?.sizeThatFits(size) ?? .zero
  }
}
