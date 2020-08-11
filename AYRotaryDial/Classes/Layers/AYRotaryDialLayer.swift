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

//MARK: - AYRotaryDialLayerDelegate protocol
public protocol AYRotaryDialLayerDelegate {
  var dialBackgroundColor: UIColor { get }
  var numberCircleBackgroundColor: UIColor { get }
  var numberCircleTextColor: UIColor { get }
  var numberCircleTextFont: UIFont { get }
  var separatorBackgroundColor: UIColor { get }
}

//MARK: - AYRotaryDialLayer class (CALayer)
class AYRotaryDialLayer: CALayer {
  
  //MARK: typealias
  public typealias AYAnimationProcess = ((CALayer?) -> ())
  public typealias AYNumberDidRotate = ((Int?) -> ())
  
  //MARK: properties
  public var uiDelegate: AYRotaryDialLayerDelegate?
    
  public var animationDidStart: AYAnimationProcess?
  public var animationDidFinish: AYAnimationProcess?
  
  public var numberDidRotate: AYNumberDidRotate?
  
  private var separatorWidth = CGFloat(8)

  private var initialTapPoint = CGPoint.zero
  private var rotationDegrees = CGFloat.zero
  
  private var side = CGFloat.zero

  private var numbersCount = Int(10)
  
  private var circleLayer: CALayer?
  private var numericLayers: [AYNumericLayer] = []
  private var separatorLayer: CALayer?

  private var draggingNumber: AYNumericLayer?
  
  private var isDragAnimationProceed = false
  
  private var separatorRotationDegrees = CGFloat(-60)
  
  //MARK: inits
  override public init() {
    super.init()
    setup()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  //MARK: livecycle
  override public func layoutSublayers() {
    super.layoutSublayers()
    if !isDragAnimationProceed {
      sublayers?.forEach { $0.removeFromSuperlayer() }
      setup()
    }
  }
  
}

//MARK: - AYRotaryDialLayer extension (methods)
extension AYRotaryDialLayer {
  func tap(on point: CGPoint) -> Bool {
    isDragAnimationProceed = true
    initialTapPoint = point
    draggingNumber = numericLayers.first(where: {
      $0.contains($0.convert(initialTapPoint, from: $0.superlayer))
    })
    return true
  }
  
  func continueMoving(with currentTouchPoint: CGPoint, previousTouchPoint: CGPoint) -> Bool {
    guard let numericLayer = draggingNumber else { return false }
    
    let initialTouchPoint = convert(initialTapPoint, to: superlayer)
    
    let currentNumberPoint = convert(numericLayer.center, to: superlayer)
    let lastNumberPoint = convert(numericLayers.last?.center ?? .zero, to: superlayer)
    let separatorPoint = convert(separatorLayer?.center ?? .zero, to: superlayer)
    
    let angle0 = angle(between: initialTouchPoint, previousTouchPoint)
    var angle1 = angle(between: initialTouchPoint, currentTouchPoint)
    var angle2 = angle(between: currentNumberPoint, separatorPoint)
    var angle3 = angle(between: separatorPoint, lastNumberPoint)
    
    let isForward = angle0 < angle1
    
    angle1 = angle1 < .zero ? angle1 + .twoPi : angle1
    angle2 = angle2 < .zero ? angle2 + .twoPi : angle2
    angle3 = angle3 < .zero ? angle3 + .twoPi : angle3
    
    rotationDegrees = angle1.rad2deg
    
    guard angle1 <= CGFloat.twoPi - angle3 else {
      if isForward {
        finishMoving(from: rotationDegrees.deg2rad)
        numberDidRotate?(numericLayer.number)
      } else {
        finishMoving(from: .zero)
      }
      return false
    }
    
    guard angle1 < angle2 else {
      numberDidRotate?(numericLayer.number)
      finishMoving(from: rotationDegrees.deg2rad)
      return false
    }
    
    CATransaction.begin()
    CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
    circleLayer?.transform = .rotation(degrees: rotationDegrees)
    CATransaction.commit()
    
    return true
  }
  
  func finishMoving(from: CGFloat? = nil, to: CGFloat = .zero) {
    CATransaction.begin()
    
    animationDidStart?(self)
    
    CATransaction.setCompletionBlock { [weak self] in
      self?.isDragAnimationProceed = false
      self?.animationDidFinish?(self)
    }
    
    let from = from ?? rotationDegrees.deg2rad
    let duration = (from - to) / CGFloat.twoPi * 2
    
    circleLayer?.transform = CATransform3DIdentity
    
    let easeOutSine = CAMediaTimingFunction(controlPoints: 0.39, 0.575, 0.565, 1)
    
    let animation = CABasicAnimation(keyPath: "transform.rotation.z")
    animation.fromValue = from
    animation.toValue = to
    animation.duration = CFTimeInterval(duration)
    animation.timingFunction = easeOutSine
    circleLayer?.add(animation, forKey: animation.keyPath)
    
    CATransaction.commit()
    
    initialTapPoint = .zero
    rotationDegrees = 0
    
    draggingNumber = nil
  }
}

//MARK: - Fileprivate extension (setup)
fileprivate extension AYRotaryDialLayer {
  func setup() {
    numericLayers.removeAll()
    if side == 0 { side = bounds.height / 8 }
    
    let circle = CALayer()
    circle.frame = bounds
    circle.backgroundColor = uiDelegate?.dialBackgroundColor.cgColor
    
    (Int.zero..<numbersCount).forEach {
      var rect = bounds
      rect.size.height -= side * 2
      rect.size.width -= side * 2
      
      let point = rect.incircleDevidePoint(for: $0, in: numbersCount)
      
      let numberCircle = AYNumericLayer()
      numberCircle.frame = CGRect(
        x: point.x + side / 2,
        y: point.y + side / 2,
        width: side,
        height: side
      )
      
      let number = $0 + 1

      numberCircle.backgroundColor = uiDelegate?.numberCircleBackgroundColor.cgColor
      numberCircle.cornerRadius = numberCircle.bounds.height / 2
      numberCircle.masksToBounds = true
      numberCircle.setNumber(
        number >= numbersCount ? number - numbersCount : number,
        with: uiDelegate?.numberCircleTextFont ?? UIFont.dialDefault,
        and: uiDelegate?.numberCircleTextColor
      )
    
      circle.addSublayer(numberCircle)
          
      numericLayers.append(numberCircle)
    }
    
    var rect = bounds
    rect.size.height -= side * 2
    rect.size.width -= side * 2
    
    let point = rect.incircleDevidePoint(for: numbersCount, in: numbersCount)
    
    let separator = CAShapeLayer.triangleLayer(
      frame: CGRect(
        x: point.x + side,
        y: point.y + side,
        width: separatorWidth,
        height: side
      )
    )
    
    separator.fillColor = uiDelegate?.separatorBackgroundColor.cgColor
    separator.transform = .rotation(degrees: separatorRotationDegrees)
    
    circle.cornerRadius = bounds.height / 2
    circle.masksToBounds = true
        
    addSublayer(circle)
    circleLayer = circle
    
    addSublayer(separator)
    separatorLayer = separator
  }
}

//MARK: - CAShapeLayer fileprivate extension
fileprivate extension CAShapeLayer {
  static func lineLayer(frame: CGRect) -> CAShapeLayer {
    let shape = CAShapeLayer()
    shape.frame = frame
    return shape
  }
  
  static func triangleLayer(frame: CGRect) -> CAShapeLayer {
    let path = CGMutablePath()
    
    path.move(to: CGPoint(x: 0, y: frame.height))
    path.addLine(to: CGPoint(x: frame.width / 2, y: 0))
    path.addLine(to: CGPoint(x: frame.width, y: frame.height))
    path.addLine(to: CGPoint(x: 0, y: frame.height))
    
    let shape = CAShapeLayer()
    shape.path = path
    shape.frame = frame
    return shape
  }
}
