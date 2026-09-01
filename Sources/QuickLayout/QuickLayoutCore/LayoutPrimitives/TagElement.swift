/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import Foundation
import UIKit

/// A layout-neutral modifier that stamps a caller-supplied `tag` onto the
/// resolved `LayoutNode` of its child. It does not affect sizing, positioning,
/// flexibility, or view extraction — it only forwards to the child and copies
/// the tag onto the returned node.
///
/// This lets callers identify a specific element when walking the computed
/// layout tree, which is especially useful for `ViewProxy` leaves: proxies
/// produce nodes with `view == nil`, so without a tag there is no way to map a
/// resolved size back to the proxy that produced it.
///
/// Placement in the modifier chain selects which node is tagged (and therefore
/// which resolved size the tag reports): `element.tag("x").padding(8)` tags the
/// inner (unpadded) node, while `element.padding(8).tag("x")` tags the outer
/// (padded) node.
public struct TagElement: Layout {

  private let child: Element
  private let tag: String

  public init(child: Element, tag: String) {
    self.child = child
    self.tag = tag
  }

  public func quick_flexibility(for axis: Axis) -> Flexibility {
    child.quick_flexibility(for: axis)
  }

  public func quick_layoutPriority() -> CGFloat {
    child.quick_layoutPriority()
  }

  public func quick_layoutThatFits(_ proposedSize: CGSize) -> LayoutNode {
    child.quick_layoutThatFits(proposedSize).withTag(tag)
  }

  public func quick_extractViewsIntoArray(_ views: inout [UIView]) {
    child.quick_extractViewsIntoArray(&views)
  }

  public func quickInternal_isSpacer() -> Bool {
    child.quickInternal_isSpacer()
  }
}
