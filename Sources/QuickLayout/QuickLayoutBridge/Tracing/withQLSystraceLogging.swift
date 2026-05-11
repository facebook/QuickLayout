/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import QuickLayoutCore
import UIKit

/// Wraps a layout/measure block with systrace begin/end events.
///
/// Fast path when no listener is registered (the 99% case): a single
/// non-inlinable function-call to `QuickLayoutTracing.currentListener()` plus
/// a nil-check, then the block runs directly.
///
/// IMPORTANT: must read `listener` via `currentListener()` and NOT directly
/// via `QuickLayoutTracing.listener`. The Swift `-O` + WMO optimizer treats
/// the public static var as if it were always nil (no setter visible from
/// this module) and dead-code-eliminates the entire nil-checked branch when
/// the read is direct. Reading via the `@inline(never)` accessor forces a
/// real cross-module function call whose result the optimizer cannot fold.
/// See `QLSystraceListener.swift:currentListener` for the full diagnosis.
@MainActor
@inline(never)
func withQLSystraceLogging<T>(
  view: UIView,
  event: QLOperation,
  _ block: () throws -> T
) rethrows -> T {
  guard let listener = QuickLayoutTracing.currentListener() else { return try block() }
  let viewType: Any.Type = type(of: view)
  listener.willPerformLayoutOperation(event, viewType: viewType)
  defer { listener.didPerformLayoutOperation(event, viewType: viewType) }
  return try block()
}
