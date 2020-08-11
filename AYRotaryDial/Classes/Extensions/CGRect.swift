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

extension CGRect {
  func incircleDevidePoint(for index: Int, in count: Int, with occupancyRate: CGFloat = -1.4) -> CGPoint {
    return center.point(on: incircleRadius, with: occupancyRate * .pi * CGFloat(index) / CGFloat(count))
  }
}

extension CGRect {
  var center: CGPoint {
    set { self.origin = CGPoint(x: newValue.x - width / 2, y: newValue.y - height / 2) }
    get { return CGPoint(x: origin.x + width / 2, y: origin.y + height / 2) }
  }
  
  var incircleRadius: CGFloat {
    return min(width, height) / 2
  }
}

extension CGPoint {
  func point(on distance: CGFloat, with angle: CGFloat) -> CGPoint {
    return CGPoint(x: x + distance * cos(angle - .pi / 2), y: y + distance * sin(angle - .pi / 2))
  }
}



