/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

/// Operations within QuickLayout's per-view layout pipeline that get traced.
///
/// `@frozen`: the QL pipeline entry points are fixed; adding a new operation
/// would already be a source-breaking change for listener implementations, so
/// listeners can switch exhaustively without `@unknown default`.
@frozen
public enum QLOperation: Sendable, Hashable {
  case layoutSubviews
  case sizeThatFits
  /// User-authored `var body` evaluation — fires only on cache miss inside
  /// `getBody`. Separating this from the outer event lets traces attribute
  /// time between user code and framework cost.
  case bodyEvaluation
}

/// Receives systrace lifecycle events for QuickLayout layout/measure operations.
///
/// Implementations are expected to be cheap on the hot path — events fire on every
/// `layoutSubviews` / `sizeThatFits` / body evaluation when a listener is registered.
/// QuickLayout itself depends only on this protocol; concrete implementations live
/// in higher-level bridge libraries provided by the consuming app, so QuickLayout's
/// framework deps stay minimal.
public protocol QLSystraceListener: AnyObject, Sendable {
  @MainActor func willPerformLayoutOperation(_ operation: QLOperation, viewType: Any.Type)
  @MainActor func didPerformLayoutOperation(_ operation: QLOperation, viewType: Any.Type)
}

/// Process-wide registration point for the QuickLayout systrace listener.
///
/// Set once during app startup. When `listener` is `nil` (the default), all
/// instrumentation in QuickLayout is a single nil-check and a no-op.
///
/// MainActor-isolated: QuickLayout itself is main-thread-only by contract
/// (see QuickLayout/thread-safety.mdx), and listener wiring runs on main as
/// part of app startup.
public enum QuickLayoutTracing {
  @MainActor public static var listener: (any QLSystraceListener)?

  /// Non-inlinable accessor for `listener` — REQUIRED to defeat WMO dead-code
  /// elimination at consumer call sites.
  ///
  /// QuickLayoutCore is `enable_library_evolution = True`, but consumers like
  /// `QuickLayoutBridge` are also `enable_library_evolution = True` and end up
  /// linked into the same dynamic framework. Under `-O` + WMO, the
  /// Swift optimizer concludes that the only writes to `listener` it can see
  /// are absent from the consumer module's WMO scope and folds the public
  /// static var read to "always nil", DCE-ing every nil-checked branch in
  /// `withQLSystraceLogging`. Reading the var directly produces a binary that
  /// has the setter wired but no getter — the listener becomes write-only.
  ///
  /// `@inline(never)` + `public` forces the optimizer to emit a real cross-
  /// module function call here, which it cannot prove the result of, so the
  /// nil-check survives.
  @inline(never)
  @MainActor public static func currentListener() -> (any QLSystraceListener)? {
    return listener
  }
}
