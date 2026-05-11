/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import QuickLayoutCore
@_exported import UIKit

@MainActor
struct ScopedLayoutCache {
  static var bodyCache: [ObjectIdentifier: Layout]?
  static var layoutCache: [ObjectIdentifier: LayoutNode]?
  static var viewsWithCache: Set<UIView>?

  private static weak var currentOwner: UIView?

  static func enter(_ view: UIView) {
    if Self.currentOwner == nil {
      Self.bodyCache = [:]
      Self.layoutCache = [:]
      Self.viewsWithCache = []
      Self.currentOwner = view
    }
  }

  static func leave(_ view: UIView) {
    if Self.currentOwner === view {
      Self.bodyCache = nil
      Self.layoutCache = nil
      Self.viewsWithCache = nil
      Self.currentOwner = nil
    }
  }
}

/**
 _QuickLayoutViewImplementation provides a canonical implementation of QuickLayout integration
 for a UIView with a Declarative interface. You shouldn't use this directly, but you may
 inherit usage via the Declarative protocol or upcoming macro support.
*/
@MainActor
public struct _QuickLayoutViewImplementation {

  // MARK: - Public
  public static func willMove(_ view: UIView, toWindow newWindow: UIWindow?) {
    guard view.isBodyEnabled else { return }
    let storage = getStorage(view)
    storage.bodyAppearanceCoordinator.coordinateMove(to: newWindow)
  }

  public static func layoutSubviews(_ view: UIView & HasBody) {
    guard view.isBodyEnabled else {
      removeBodyIfNeeded(view)
      return
    }
    withQLSystraceLogging(view: view, event: .layoutSubviews) {
      let cachingIsEnabled = view.isCachingEnabled
      if cachingIsEnabled {
        ScopedLayoutCache.enter(view)
      }

      let body = getBody(view)
      updateBodyIfNeeded(view, body)
      let storage = getStorage(view)
      storage.bodyAppearanceCoordinator.beginViewAppearanceUpdates()
      let layoutDirection: LayoutDirection = view.effectiveUserInterfaceLayoutDirection == .rightToLeft ? .rightToLeft : .leftToRight
      var cachedLayout: LayoutNode?
      let cacheKey = ScopedLayoutCache.layoutCache != nil ? ObjectIdentifier(view) : nil
      if let cacheKey, let layout = ScopedLayoutCache.layoutCache?[cacheKey], layout.size == view.bounds.size {
        cachedLayout = layout
      }
      body._applyFrame(view.bounds, alignment: .center, layoutDirection: layoutDirection, cachedLayout: cachedLayout)
      storage.bodyAppearanceCoordinator.commitViewAppearanceUpdates()

      if cachingIsEnabled {
        if let viewsWithCache = ScopedLayoutCache.viewsWithCache {
          for subview in viewsWithCache {
            subview.layoutIfNeeded()
          }
        }

        ScopedLayoutCache.leave(view)
      }
    }
  }

  public static func sizeThatFits(_ view: UIView & HasBody, size: CGSize) -> CGSize? {
    guard view.isBodyEnabled, view.isBodySizingEnabled else { return nil }
    return withQLSystraceLogging(view: view, event: .sizeThatFits) {
      let body = getBody(view)
      updateBodyIfNeeded(view, body)
      let layoutDirection: LayoutDirection = view.effectiveUserInterfaceLayoutDirection == .rightToLeft ? .rightToLeft : .leftToRight
      let layout = body.layoutThatFits(size, layoutDirection: layoutDirection)
      let cacheKey = ScopedLayoutCache.layoutCache != nil ? ObjectIdentifier(view) : nil
      if let cacheKey {
        ScopedLayoutCache.viewsWithCache?.insert(view)
        ScopedLayoutCache.layoutCache?[cacheKey] = layout
      }
      return layout.size
    }
  }

  public static func quick_flexibility(_ view: UIView & HasBody, for axis: Axis) -> Flexibility? {
    guard view.isBodyEnabled else { return nil }
    return getBody(view).quick_flexibility(for: axis)
  }

  // MARK: - Private

  private static var bodyStateKey: UInt8 = 0

  private static func getStorage(_ view: UIView) -> BodyState {
    guard let storage = objc_getAssociatedObject(view, &_QuickLayoutViewImplementation.bodyStateKey) as? BodyState else {
      let newStorage = BodyState()
      objc_setAssociatedObject(view, &_QuickLayoutViewImplementation.bodyStateKey, newStorage, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      return newStorage
    }
    return storage
  }

  private static func removeBodyIfNeeded(_ view: UIView) {
    updateBodyIfNeeded(view, EmptyLayout())
  }

  private static func updateBodyIfNeeded(_ view: UIView, _ newBody: Layout) {
    let newViews = newBody.views()
    let storage = getStorage(view)
    guard newViews != storage.activeSubviews else { return }
    // We need a real diff to ensure correct view ordering
    for operation in newViews.difference(from: storage.activeSubviews) {
      switch operation {
      case .insert(let index, let insertedView, _):
        storage.bodyAppearanceCoordinator.coordinateAppearance(of: insertedView, in: view.bodyContainerView, index: index)
      case .remove(_, let view, _):
        storage.bodyAppearanceCoordinator.coordinateDisappearance(of: view)
      }
    }
    storage.activeSubviews = newViews
  }

  private static func getBody(_ view: UIView & HasBody) -> Layout {
    let cacheKey = ScopedLayoutCache.bodyCache != nil ? ObjectIdentifier(view) : nil
    if let cacheKey, let body = ScopedLayoutCache.bodyCache?[cacheKey] {
      return body
    }
    return withQLSystraceLogging(view: view, event: .bodyEvaluation) {
      let disableActions = CATransaction.disableActions()
      CATransaction.setDisableActions(true)
      let body = view.body
      if let cacheKey {
        ScopedLayoutCache.bodyCache?[cacheKey] = body
      }
      CATransaction.setDisableActions(disableActions)
      return body
    }
  }
}
