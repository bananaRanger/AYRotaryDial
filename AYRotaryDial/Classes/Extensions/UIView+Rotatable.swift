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

protocol Rotatable {
  var center: CGPoint { get }
  func angle(between point1: CGPoint, _ point2: CGPoint) -> CGFloat
}

extension UIView: Rotatable {
  func angle(between point1: CGPoint, _ point2: CGPoint) -> CGFloat {
    let vector1 = CGVector(dx: point1.x - center.x, dy: point1.y - center.y)
    let vector2 = CGVector(dx: point2.x - center.x, dy: point2.y - center.y)

    return atan2(vector2.dy, vector2.dx) - atan2(vector1.dy, vector1.dx)
  }
}

extension CALayer: Rotatable {
  func angle(between point1: CGPoint, _ point2: CGPoint) -> CGFloat {
    let vector1 = CGVector(dx: point1.x - center.x, dy: point1.y - center.y)
    let vector2 = CGVector(dx: point2.x - center.x, dy: point2.y - center.y)

    return atan2(vector2.dy, vector2.dx) - atan2(vector1.dy, vector1.dx)
  }
}

