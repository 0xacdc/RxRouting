# RxRouting

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/RxRouting.svg)](https://cocoapods.org/pods/RxRouting)
[![Build Status](https://travis-ci.org/e-sites/RxRouting.svg?branch=master)](https://travis-ci.com/e-sites/RxRouting)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

RxRouting proves a reactive way to handle deeplinks.

> *Thanks to [devxoul](https://github.com/devxoul) his [URLNavigator](https://github.com/devxoul/URLNavigator) library for (parts) of his url matching code*

## Installation

### CocoaPods

```ruby
pod 'RxRouting'
```

### Carthage

```ruby
github 'e-sites/RxRouting'
```

## Getting started

```swift
// Handles an URL that is openened from an external application (e.g. Safari).
func handle(url: URL) -> Bool

// Registers a url pattern
func register(_ url: String) -> Observable<RouteMatchResult>
```

## Usage

### AppDelegate.swift

To handle links that open your app, forward the `URL` to `RxRouting` so it can be dispatched to the subscribed observers.

```swift
import RxRouting

func application(_ app: UIApplication,
                 open url: URL,
                 options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    if RxRouting.instance.handle(url: url) {
        return true
    }
    return false
}
```

### Registering

The listen for incoming URL's, register your pattern

```swift
RxRouting.instance
    .register("rxroutingexample://user/<userid:int>"
    .subscribe(onNext: { result in
        // result is a RouteMatchResult
    }.disposed(by: disposeBag)
```

## Available patterns

Pattern|Swift type|Pattern|Example
-|-|-|-
`<value>`|`String`|`scheme://users/gender/<gender>`|`scheme://users/gender/male`
`<value:int>`|`Int`|`scheme://user/<userid:int>`|`scheme://user/5123`
`<value:float>`|`Float`|`scheme://temperatures/<temp:float>`|`scheme://temperatures/31.5`
`<value:bool>`|`Bool`|`scheme://users/active/<available:bool>`|`scheme://users/active/true`
`<value:uuid>`|`UUID`|`scheme://users/<userid:uuid>`|`scheme://users/f3383db8-9a6d-494c-b1af-2438148204c0`
`<value:date>`|`Date`|`scheme://news/<newsdate:date>`|`scheme://news/2019-06-22`