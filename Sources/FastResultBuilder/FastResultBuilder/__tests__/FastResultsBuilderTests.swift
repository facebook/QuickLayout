/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

import FastResultBuilder
import Foundation
import XCTest

@resultBuilder
public struct StackArrayBuilder<T> {
  public static func buildBlock() -> [T] { [] }
  public static func buildExpression(_ expression: T) -> [T] { [expression] }
  public static func buildExpression(_ expression: T?) -> [T] { [expression].compactMap { $0 } }
  public static func buildExpression(_ expression: [T]) -> [T] { expression }
  public static func buildBlock(_ components: [T]...) -> [T] { components.flatMap { $0 } }
  public static func buildArray(_ components: [[T]]) -> [T] { components.flatMap { $0 } }
  public static func buildOptional(_ component: [T]?) -> [T] { component ?? [] }
  public static func buildEither(first component: [T]) -> [T] { component }
  public static func buildEither(second component: [T]) -> [T] { component }
  public static func buildLimitedAvailability(_ component: [T]) -> [T] { component }
}

struct Foo {
  @FastArrayBuilder<Int> var values: [Int] {
    1
    2
    10 as Int?

    for i in 1...10 {
      i
    }

    if true {
      99
    }

    if false {
      0
    } else {
      1
    }
  }
}

struct Bar {
  @StackArrayBuilder<Int> var values: [Int] {
    1
    2
    10 as Int?

    for i in 1...10 {
      i
    }

    if true {
      99
    }

    if false {
      0
    } else {
      1
    }
  }
}

final class FastResultsBuilderTests: XCTestCase {
  func test1() {
    XCTAssertEqual(Foo().values, [1, 2, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 99, 1])
  }

  func ignore_testPerf1() {
    self.measure {
      for _ in 1...100000 {
        XCTAssertEqual(Foo().values, [1, 2, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 99, 1])
      }
    }
  }

  func ignore_testPerf2() {
    self.measure {
      for _ in 1...100000 {
        XCTAssertEqual(Bar().values, [1, 2, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 99, 1])
      }
    }
  }
}
