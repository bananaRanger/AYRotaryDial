// MIT License
//
// Copyright (c) 2020 Anton Yereshchenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

//MARK: - AYRotaryDial class (UIControl)
@IBDesignable
open class AYRotaryDial: UIControl {
  
  //MARK: typealias
  public typealias AYNumberDidRotate = ((Int) -> ())

  //MARK: properties
  public var numberDidRotate: AYNumberDidRotate?

  public var uiDelegate: AYRotaryDialLayerDelegate? {
    didSet {
      rotaryDialLayer?.uiDelegate = uiDelegate
    }
  }

  override public class var layerClass: AnyClass {
    return AYRotaryDialLayer.self
  }
  
  private var rotaryDialLayer: AYRotaryDialLayer? {
    return layer as? AYRotaryDialLayer
  }
  
  //MARK: inits
  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
}

//MARK: - Events
extension AYRotaryDial {
  override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    super.beginTracking(touch, with: event)
    let point = touch.location(in: self)
    return rotaryDialLayer?.tap(on: point) ?? false
  }
  
  override open func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    super.continueTracking(touch, with: event)
    return rotaryDialLayer?.continueMoving(
      with: touch.location(in: superview),
      previousTouchPoint: touch.previousLocation(in: superview)
    ) ?? false
  }
  
  override open func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    super.endTracking(touch, with: event)
    rotaryDialLayer?.finishMoving()
  }
  
  override open func cancelTracking(with event: UIEvent?) {
    super.cancelTracking(with: event)
    rotaryDialLayer?.finishMoving()
  }
}

//MARK: - Fileprivate extension (setup)
fileprivate extension AYRotaryDial {
  func setup() {
    rotaryDialLayer?.uiDelegate = AYRotaryDialLayerConstants()
    rotaryDialLayer?.animationDidStart = { [weak self] layer in
      self?.isUserInteractionEnabled = false
    }
    rotaryDialLayer?.animationDidFinish = { [weak self] layer in
      self?.isUserInteractionEnabled = true
    }
    rotaryDialLayer?.numberDidRotate = { [weak self] number in
      if let number = number { self?.numberDidRotate?(number) }
    }
  }
}

//MARK: - RotaryDialLayerConstants fileprivate struct (Constants)
fileprivate struct AYRotaryDialLayerConstants: AYRotaryDialLayerDelegate {
  var dialBackgroundColor = UIColor.orange
  var numberCircleBackgroundColor = UIColor.white
  var numberCircleTextColor = UIColor.black
  var numberCircleTextFont = UIFont.dialDefault
  var separatorBackgroundColor = UIColor.yellow
}
