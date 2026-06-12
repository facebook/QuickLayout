/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import FBServerSnapshotTestCase
import FBTestImageGenerator
import QuickLayoutBridge

// MARK: - Types

extension VerticalAlignment {
  private struct CustomVerticalAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
      context[VerticalAlignment.bottom]
    }
  }
  static let custom = VerticalAlignment(
    CustomVerticalAlignment.self
  )
}

// MARK: - Tests

@MainActor
final class AlignmentGuidesServerSnaspshotTests: FBServerSnapshotTestCase {

  func testAlignmentGuideTaskList() {
    /// Expecting a task list with two categories, where
    /// tasks in each category are inset by 10 points from the leading edge.
    let groceriesTitleLabel = {
      let label = UILabel()
      label.text = "Groceries"
      label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
      return label
    }()

    let groceryItemLabels = ["Milk", "Eggs", "Bananas"].map {
      let label = UILabel()
      label.text = $0
      return label
    }

    let tasksTitleLabel = {
      let label = UILabel()
      label.text = "Tasks"
      label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
      return label
    }()

    let taskItemLabels = ["Laundry", "Cook dinner"].map {
      let label = UILabel()
      label.text = $0
      return label
    }

    let layout = VStack(alignment: .leading, spacing: 5) {
      groceriesTitleLabel
      for item in groceryItemLabels {
        item.alignmentGuide(.leading) { _ in -10 }
      }
      Spacer(20)
      tasksTitleLabel
      for item in taskItemLabels {
        item.alignmentGuide(.leading) { _ in -10 }
      }
    }

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 300)),
      alignment: .center,
      containerBackground: .white
    )
  }

  func testInvalidAlignmentGuideBehavior() {
    /// Expecting a task list with no insets.

    let groceryItemLabels = ["Milk", "Eggs", "Bananas"].map {
      let label = UILabel()
      label.text = $0
      return label
    }

    let layout = VStack(alignment: .leading, spacing: 5) {
      for (index, item) in groceryItemLabels.enumerated() {
        item.alignmentGuide(.leading) { _ in
          switch index {
          case 0: .nan
          case 1: .infinity
          default: 0
          }
        }
      }
    }

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 300)),
      alignment: .center,
      containerBackground: .white
    )
  }

  func testNestedVStackAlignmentBehavior() {
    let greenView = {
      let view = UIView()
      view.backgroundColor = .systemGreen
      return view
    }()
    let blueView = {
      let view = UIView()
      view.backgroundColor = .systemBlue
      return view
    }()
    let redView = {
      let view = UIView()
      view.backgroundColor = .systemRed
      return view
    }()
    let layout = VStack(alignment: .leading) {
      greenView
        .frame(width: 50, height: 50)
      HStack {
        blueView
          .frame(width: 50, height: 50)
          .alignmentGuide(.leading) { _ in -10 }
      }
      redView
        .frame(width: 50, height: 50)
        .alignmentGuide(.leading) { _ in -10 }
    }
    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 300)),
      alignment: .center,
      containerBackground: .white
    )
  }

  func testNestedZStackAlignmentBehavior() {
    let greenView = {
      let view = UIView()
      view.backgroundColor = .systemGreen
      return view
    }()
    let blueView = {
      let view = UIView()
      view.backgroundColor = .systemBlue
      return view
    }()
    let redView = {
      let view = UIView()
      view.backgroundColor = .systemRed
      return view
    }()
    let layout = ZStack(alignment: .topLeading) {
      greenView
        .frame(width: 70, height: 60)
      HStack {
        blueView
          .frame(width: 50, height: 50)
          .alignmentGuide(.leading) { _ in -10 }
      }
      redView
        .frame(width: 50, height: 50)
        .alignmentGuide(.leading) { _ in -10 }
    }
    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 300)),
      alignment: .center,
      containerBackground: .white
    )
  }
  func testAlignmentGuidesArePropagatedByLayoutsWithSingleChildElements() {
    let greenView = {
      let view = UIView()
      view.backgroundColor = .systemGreen
      return view
    }()
    let blueView = {
      let view = UIView()
      view.backgroundColor = .systemBlue
      return view
    }()
    let redView = {
      let view = UIView()
      view.backgroundColor = .systemRed
      return view
    }()
    let yellowView = {
      let view = UIView()
      view.backgroundColor = .systemYellow
      return view
    }()
    let clearView = {
      let view = UIView()
      view.backgroundColor = .clear
      return view
    }()
    let clearView2 = {
      let view = UIView()
      view.backgroundColor = .clear
      return view
    }()
    let layout = VStack(alignment: .leading) {
      ZStack {
        blueView
          .alignmentGuide(.leading) { _ in -15 }
          .frame(width: 50, height: 50)
          .padding(8)
          .aspectRatio(CGSize(width: 1, height: 1))

      }
      VStack {
        redView
          .alignmentGuide(.leading) { _ in -5 }
          .frame(width: 50, height: 50)
          .padding(8)
          .offset(x: 0, y: 0)
      }
      HStack {
        greenView
          .alignmentGuide(.leading) { _ in 5 }
          .frame(width: 50, height: 50)
          .padding(8)
          .aspectRatio(CGSize(width: 1, height: 1))
          .overlay {
            clearView
          }
      }
      HFlow {
        yellowView
          .alignmentGuide(.leading) { _ in 15 }
          .frame(width: 50, height: 50)
          .padding(8)
          .aspectRatio(CGSize(width: 1, height: 1))
          .background {
            clearView2
          }
      }
    }
    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 500)),
      alignment: .center,
      containerBackground: .white
    )
  }

  func testDefaultAlignmentGuidesAreNotPropagatedThroughMultipleChildContainers() {
    let layout = buildAlignmentGuidePropagationLayout(with: .bottom)
    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 500)),
      alignment: .center,
      containerBackground: .white
    )
  }

  func testCustomAlignmentGuidesArePropagatedThroughMultipleChildContainers() {
    let layout = buildAlignmentGuidePropagationLayout(with: .custom)
    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 500)),
      alignment: .center,
      containerBackground: .white
    )
  }

  func testCustomAlignmentGuidePropagationPassesCorrectDimensions() {
    let iconView = UIImageView(image: UIImage(systemName: "face.smiling")!) // swiftlint:disable:this force_unwrapping
    let titleView = UILabel()
    let subtitleLabel = UILabel()

    titleView.text = "Mauris fringilla ligula felis, nec pharetra velit congue id. Aenean hendrerit arcu lorem, in tempor est posuere id."
    titleView.font = UIFont.preferredFont(forTextStyle: .headline)
    titleView.numberOfLines = 0

    subtitleLabel.text = "Lorem ipsum dolor sit amet consectetur adipiscing elit"
    subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    subtitleLabel.numberOfLines = 0

    iconView.layer.borderColor = UIColor.systemGray.cgColor
    iconView.layer.borderWidth = 1

    let layout = HStack(alignment: .custom) {
      iconView
        .resizable()
        .frame(width: 20, height: 20)
        .alignmentGuide(.custom, computeValue: { d in d[.top] + d.height / 2 })
      Spacer(16)
      VStack(alignment: .leading) {
        titleView
          .alignmentGuide(.custom, computeValue: { d in d[.top] + d.height / 2 })
        subtitleLabel
      }
      Spacer()
    }
    .padding(16)

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 500)),
      alignment: .center,
      containerBackground: .white
    )
  }

  func testReferencingSameAlignmentIDWithinGuide() {
    let titleView = UILabel()
    titleView.text = "Title"
    titleView.font = .systemFont(ofSize: 17, weight: .bold)

    let iconView = UIImageView(image: UIImage(systemName: "face.smiling")!) // swiftlint:disable:this force_unwrapping

    let layout = VStack(alignment: .leading) {
      titleView
      iconView
        .alignmentGuide(.leading) { d in
          d[.leading] + 10
        }
    }
    .padding(16)

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 500)),
      alignment: .center,
      containerBackground: .white
    )
  }

  func testCorrectDimensionsArePassedToAlignmentGuide() {
    let titleView = UILabel()
    titleView.text = "Right"
    titleView.font = .systemFont(ofSize: 17)

    let titleView2 = UILabel()
    titleView2.text = "Left"
    titleView2.font = .systemFont(ofSize: 17)

    let layout = VStack(alignment: .leading) {
      VStack(alignment: .leading) {
        titleView
      }
      VStack(alignment: .leading) {
        titleView2
          .alignmentGuide(.leading) { d in
            d.width
          }
          .padding(.horizontal, 20)
      }
    }
    .padding(16)

    takeSnapshot(
      with: layout,
      in: .exact(CGSize(width: 300, height: 500)),
      alignment: .center,
      containerBackground: .white
    )
  }

  // MARK: - Private

  private func buildAlignmentGuidePropagationLayout(with alignment: VerticalAlignment) -> Layout {
    struct Model {
      let emojiString: String
      let emojiTitle: String
      let emojiDescription: String?
    }
    struct EmojiViews {
      let emojiView: UIView
      let emojiTitleView: UIView
      let emojiDescriptionView: UIView?
    }
    let titleView = UILabel()
    titleView.text = "Odd one out?"
    titleView.font = .systemFont(ofSize: 17, weight: .bold)
    let models: [Model] = [
      .init(emojiString: "🍔", emojiTitle: "Burger", emojiDescription: nil),
      .init(emojiString: "🍇", emojiTitle: "Grape", emojiDescription: nil),
      .init(emojiString: "🏡", emojiTitle: "House", emojiDescription: "This one!"),
      .init(emojiString: "🍎", emojiTitle: "Apple", emojiDescription: nil),
    ]
    let emojiViews = models.map {
      let emojiView = UILabel()
      emojiView.text = $0.emojiString
      let titleView = UILabel()
      titleView.text = $0.emojiTitle
      let descriptionView: UILabel?
      if let description = $0.emojiDescription {
        descriptionView = UILabel()
        descriptionView?.text = description
        descriptionView?.textColor = .secondaryLabel
        descriptionView?.font = .systemFont(ofSize: 13)
        emojiView.font = .systemFont(ofSize: 34)
      } else {
        descriptionView = nil
      }
      return EmojiViews(emojiView: emojiView, emojiTitleView: titleView, emojiDescriptionView: descriptionView)
    }
    return VStack(spacing: 30) {
      titleView
      HStack(alignment: alignment, spacing: 16) {
        for emojiViewData in emojiViews {
          VStack {
            emojiViewData.emojiView
            emojiViewData.emojiTitleView
              .alignmentGuide(alignment) { _ in 0 }
            emojiViewData.emojiDescriptionView
          }
        }
      }
    }
  }
}
