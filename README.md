# SwiftyKit

[![CI Status](http://img.shields.io/travis/jzucker2/SwiftyKit.svg?style=flat)](https://travis-ci.org/jzucker2/SwiftyKit)
[![Version](https://img.shields.io/cocoapods/v/SwiftyKit.svg?style=flat)](http://cocoapods.org/pods/SwiftyKit)
[![License](https://img.shields.io/cocoapods/l/SwiftyKit.svg?style=flat)](http://cocoapods.org/pods/SwiftyKit)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyKit.svg?style=flat)](http://cocoapods.org/pods/SwiftyKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SwiftyKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftyKit"
```

## Notes

```
/// A type-erased key path, from any root type to any resulting value type.
public class AnyKeyPath : Hashable {

/// The root type for this key path.
public static var rootType: Any.Type { get }

/// The value type for this key path.
public static var valueType: Any.Type { get }

/// The hash value.
///
/// Hash values are not guaranteed to be equal across different executions of
/// your program. Do not save hash values to use during a future execution.
final public var hashValue: Int { get }

/// Returns a Boolean value indicating whether two values are equal.
///
/// Equality is the inverse of inequality. For any values `a` and `b`,
/// `a == b` implies that `a != b` is `false`.
///
/// - Parameters:
///   - lhs: A value to compare.
///   - rhs: Another value to compare.
public static func ==(a: AnyKeyPath, b: AnyKeyPath) -> Bool
}

/// A partially type-erased key path, from a concrete root type to any
/// resulting value type.
public class PartialKeyPath<Root> : AnyKeyPath {
}

/// A key path from a specific root type to a specific resulting value type.
public class KeyPath<Root, Value> : PartialKeyPath<Root> {
}

/// A key path that supports reading from and writing to the resulting value.
public class WritableKeyPath<Root, Value> : KeyPath<Root, Value> {
}

/// A key path that supports reading from and writing to the resulting value
/// with reference semantics.
public class ReferenceWritableKeyPath<Root, Value> : WritableKeyPath<Root, Value> {
}
```

## Author

jzucker2, jordan.zucker@gmail.com

## License

SwiftyKit is available under the MIT license. See the LICENSE file for more info.
