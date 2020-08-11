# AYRotaryDial

[![CI Status](https://img.shields.io/travis/antonyereshchenko@gmail.com/AYRotaryDial.svg?style=flat)](https://travis-ci.org/antonyereshchenko@gmail.com/AYRotaryDial)
[![Version](https://img.shields.io/cocoapods/v/AYRotaryDial.svg?style=flat)](https://cocoapods.org/pods/AYRotaryDial)
[![License](https://img.shields.io/cocoapods/l/AYRotaryDial.svg?style=flat)](https://cocoapods.org/pods/AYRotaryDial)
[![Platform](https://img.shields.io/cocoapods/p/AYRotaryDial.svg?style=flat)](https://cocoapods.org/pods/AYRotaryDial)

<p align="center">
  <img width="72%" height="72%" src="https://github.com/bananaRanger/AYRotaryDial/blob/master/Resources/logo.png?raw=true">
</p>

## About

AYRotaryDial is the UI control based on layers. This control gives you the possibility for an input phone number like by cool old rotary dial phone.

## Installation

AYRotaryDial is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
inhibit_all_warnings!

target 'YOUR_TARGET_NAME' do
  use_frameworks!
	pod 'AYRotaryDial'
end
```

### Demo

<p align="center">
  <img width="24%" height="24%" src="https://github.com/bananaRanger/AYRotaryDial/blob/master/Resources/demo.gif?raw=true">
</p>

## Usage

<p align="center">
  <img width="50%" height="50%" src="https://github.com/bananaRanger/AYRotaryDial/blob/master/Resources/expl.png?raw=true">
</p>

```swift
// 'rotaryDial' - object of 'AYRotaryDial' type.

rotaryDial.uiDelegate = self
rotaryDial.numberDidRotate = { [weak self] number in
  print(number)
}
```

## Author

[📧](mailto:anton.yereshchenko@gmail.com?subject=[GitHub]%20Source%20AYRotaryDial) Anton Yereshchenko

## License

AYRotaryDial is available under the MIT license. See the LICENSE file for more info.

## Used in project

Icons & photos:

Icons8 - https://icons8.com
