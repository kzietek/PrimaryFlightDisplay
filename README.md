# PrimaryFlightDisplay

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/PrimaryFlightDisplay.svg?style=flat-square)](https://cocoapods.org/pods/PrimaryFlightDisplay)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/PrimaryFlightDisplay.svg?style=flat-square)](http://cocoadocs.org/docsets/PrimaryFlightDisplay)
[![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/kouky/MavlinkPrimaryFlightDisplay/blob/master/LICENSE)


PrimaryFlightDisplay is a Mac + iOS framework for use in ground control station and telemetry systems for unmanned aerial vehicles (UAV).

![Screenshot](http://kouky.org/assets/primary-flight-display/default-screenshot.png)

## Features

- [x] Artificial horizon
- [x] Pitch Ladder
- [x] Heading tape indicator
- [x] Airspeed tape indicator
- [x] Altitude tape indicator
- [x] Crisp proceduarlly generated graphics
- [x] Highly configurable colors, sizes, and tape indicator scales
- [x] No dependenices other than Apple's Sprite Kit framework
- [x] Flight stack and protocol agnostic

## Requirements

- iOS 9.0+ / Mac OS X 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 7.2+

## Installation

Build and install the framework using Cocoapods or Carthage.

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build PrimaryFlightDisplay

To integrate PrimaryFlightDisplay into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'PrimaryFlightDisplay'
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate PrimaryFlightDisplay into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "kouky/PrimaryFlightDisplay"
```

Run `carthage update` to build the framework and drag the built `PrimaryFlightDisplay.framework` into your Xcode project.

## Usage

Construct a new `PrimaryFlightDisplayView`, and add it it your view hierarchy.


```swift
let flightView = PrimaryFlightDisplayView(frame: frame)
flightView.autoresizingMask = [.ViewHeightSizable, .ViewWidthSizable]
addSubview(flightView)
```

Send flight data to the primary flight display using the following API methods. The new flight data values will be animated immediately.

```swift
    flightView.setAttitude(rollRadians: Double(1), pitchRadians: Double(1.5))
    flightView.setHeadingDegree(Double(300))
    flightView.setAirSpeed(Double(20))
    flightView.setAltitude(Double(165))
```

## Example Project

[MavlinkPrimaryFlightDisplay](https://github.com/kouky/MavlinkPrimaryFlightDisplay) demonstrates how to:
- integrate the PrimaryFlightDisplay framework into a Mac application
- connect to Pixhawk over USB, Bluetooth, and 3DR radio telemetry
- decode MAVLink attitude, heading, airspeed, and altitude messages
- send decoded data to the primary flight display for real time updates


## Contributing

Pull requests are welcome on the `master` branch.
