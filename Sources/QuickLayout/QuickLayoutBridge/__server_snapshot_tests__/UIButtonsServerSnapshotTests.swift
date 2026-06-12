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
final class UIButtonsServerSnapshotTests: FBServerSnapshotTestCase {

  func testButtonsWithDifferentTypes() {

    let button0 = UIButton()
    button0.setTitleColor(.systemBlue, for: .normal)
    button0.setTitleColor(.systemBlue.withAlphaComponent(0.7), for: .highlighted)
    button0.setTitle("Button 0", for: .normal)

    let button1 = UIButton(type: .system)
    button1.setTitle("Button 1", for: .normal)

    let button2 = UIButton(type: .custom)
    button2.setTitleColor(.systemBlue, for: .normal)
    button2.setTitleColor(.systemBlue.withAlphaComponent(0.7), for: .highlighted)
    button2.setTitle("Button 2", for: .normal)

    let button3 = UIButton(type: .detailDisclosure)
    button3.setTitle("Button 3", for: .normal)

    let button4 = UIButton(type: .infoDark)
    button4.setTitle("Button 4", for: .normal)

    let button5 = UIButton(type: .infoLight)
    button5.setTitle("Button 5", for: .normal)

    let button6 = UIButton(type: .contactAdd)
    button6.setTitle("Button 6", for: .normal)

    let layout = VStack(spacing: 8) {
      button0
      button1
      button2
      button3
      button4
      button5
      button6
    }

    takeSnapshot(
      with: layout,
      in: .proposed(CGSize(width: 320, height: 480))
    )
  }

  func testButtonsWithConfigs() {
    if #available(iOS 15.0, *) {
      let icon = FBTestImageGenerator.image(with: .systemBlue, size: CGSize(width: 10, height: 10))
      var button0Config = UIButton.Configuration.plain()
      button0Config.title = "Button 1"
      button0Config.subtitle = "Subtitle 1"
      button0Config.image = icon
      let button0 = UIButton(configuration: button0Config)

      var button1Config = UIButton.Configuration.plain()
      button1Config.title = "Button 1"
      button1Config.subtitle = "Subtitle 1"
      button1Config.image = icon
      button1Config.titlePadding = 8
      button1Config.imagePadding = 4
      let button1 = UIButton(configuration: button1Config)

      var button2Config = UIButton.Configuration.bordered()
      button2Config.title = "Button 1"
      button2Config.subtitle = "Subtitle 1"
      button2Config.image = icon
      button2Config.titlePadding = 8
      button2Config.imagePadding = 4
      let button2 = UIButton(configuration: button2Config)

      var button3Config = UIButton.Configuration.tinted()
      button3Config.title = "Button 1"
      button3Config.subtitle = "Subtitle 1"
      button3Config.image = icon
      button3Config.titlePadding = 8
      button3Config.imagePadding = 4
      let button3 = UIButton(configuration: button3Config)

      var button4Config = UIButton.Configuration.gray()
      button4Config.title = "Button 1"
      button4Config.subtitle = "Subtitle 1"
      button4Config.image = icon
      button4Config.titlePadding = 8
      button4Config.imagePadding = 4
      let button4 = UIButton(configuration: button4Config)

      var button5Config = UIButton.Configuration.filled()
      button5Config.title = "Button 1"
      button5Config.subtitle = "Subtitle 1"
      button5Config.image = icon
      button5Config.titlePadding = 8
      button5Config.imagePadding = 4
      let button5 = UIButton(configuration: button5Config)

      let layout = VStack(spacing: 8) {
        button0
        button1
        button2
        button3
        button4
        button5
      }

      takeSnapshot(
        with: layout,
        in: .proposed(CGSize(width: 320, height: 480))
      )
    }
  }
}
