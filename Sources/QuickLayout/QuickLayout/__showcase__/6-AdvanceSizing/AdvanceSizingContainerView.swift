/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import QuickLayout

@QuickLayout
final class AdvanceSizingContainerView: UIView {

  private let exampleView = AdvanceSizingView(with: "This is an example view", image: UIImage(systemName: "lightbulb"))
  private let sizeInfoOne = UILabel()
  private let sizeInfoTwo = UILabel()

  init() {
    let firstExampleSize = AdvanceSizingView.sizeThatFits(UIScreen.main.bounds.size, with: "Hi", image: UIImage(systemName: "hand.wave"))
    sizeInfoOne.numberOfLines = 0
    sizeInfoOne.textAlignment = .center
    sizeInfoOne.text = "Size with title 'Hi' and waving image. Width: \(firstExampleSize.width), height: \(firstExampleSize.height)"

    let secondExampleSize = AdvanceSizingView.sizeThatFits(UIScreen.main.bounds.size, with: "Hello World", image: nil)
    sizeInfoTwo.numberOfLines = 0
    sizeInfoTwo.textAlignment = .center
    sizeInfoTwo.text = "Size with title 'Hello World' and no image. Width: \(secondExampleSize.width), height: \(secondExampleSize.height)"

    super.init(frame: .zero)
  }

  @MainActor required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  var body: Layout {
    VStack(spacing: 12) {
      exampleView
      Spacer(20)
      sizeInfoOne
      sizeInfoTwo
    }
    .padding(20)
  }
}

// MARK: Preview code

@available(iOS 17, *)
#Preview {
  AdvanceSizingContainerView()
}
