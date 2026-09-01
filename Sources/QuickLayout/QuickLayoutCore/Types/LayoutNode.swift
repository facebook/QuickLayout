/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import Foundation
import UIKit

public struct GridInfo: Sendable {
  public let alignment: Alignment?
  public let unitPoint: UnitPoint?
  public let columnAlignment: HorizontalAlignment?
}

public struct LayoutNode: Sendable {

  public static let empty = LayoutNode(view: nil, dimensions: ElementDimensions(.zero))

  public let view: UIView?
  public let dimensions: ElementDimensions
  public let gridInfo: GridInfo?
  public let children: [Child]

  /// Optional caller-supplied identifier, propagated from a `.tag(_:)` modifier
  /// Lets callers locate a specific element's resolved node when walking
  /// the computed layout tree — useful for `ViewProxy` leaves, which
  /// carry no `view` identity.
  public let tag: String?

  public init(view: UIView?, dimensions: ElementDimensions, gridInfo: GridInfo? = nil, tag: String? = nil) {
    self.view = view
    self.dimensions = dimensions
    self.gridInfo = gridInfo
    self.children = []
    self.tag = tag
  }

  init(view: UIView?, size: CGSize, children: [Child], alignmentGuides: AlignmentGuides, tag: String? = nil) {
    self.view = view
    self.children = children
    self.gridInfo = nil
    self.dimensions = ElementDimensions(size, alignmentGuides: alignmentGuides)
    self.tag = tag
  }
  init(view: UIView?, dimensions: ElementDimensions, gridInfo: GridInfo?, children: [Child], tag: String? = nil) {
    self.view = view
    self.dimensions = dimensions
    self.gridInfo = gridInfo
    self.children = children
    self.tag = tag
  }

  public var size: CGSize {
    return CGSize(width: dimensions.width, height: dimensions.height)
  }

  /// Returns a copy of this node with `tag` set, preserving everything else.
  /// Used by `TagElement` to stamp the caller's identifier onto the child's
  /// resolved node.
  func withTag(_ tag: String?) -> LayoutNode {
    LayoutNode(view: view, dimensions: dimensions, gridInfo: gridInfo, children: children, tag: tag)
  }

  public struct Child: Sendable {

    public let position: CGPoint
    public let layout: LayoutNode

    public init(position: CGPoint, layout: LayoutNode) {
      self.position = position
      self.layout = layout
    }
  }
}
