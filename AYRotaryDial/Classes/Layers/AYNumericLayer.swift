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

//MARK: - AYNumericLayer class (CALayer)
public class AYNumericLayer: CALayer {
  
  //MARK: properties
  public var number: Int? {
    guard let text = text() else { return nil }
    return Int(text)
  }
  
  //MARK: methods
  public func setNumber(_ number: Int, with font: UIFont, and color: UIColor?) {
    guard sublayers?.isEmpty == true || sublayers == nil else {
      sublayers?.forEach { $0.removeFromSuperlayer() }
      return
    }

    let textlayer = CATextLayer()
    textlayer.frame = CGRect(
      x: .zero,
      y: font.yOffset(for: bounds),
      width: bounds.width,
      height: bounds.height
    )

    textlayer.string = String(number)
    textlayer.fontSize = font.pointSize
    textlayer.font = font.cfTypeRef
    textlayer.truncationMode = .end
    textlayer.alignmentMode = .center
    textlayer.contentsScale = UIScreen.main.scale
    textlayer.backgroundColor = UIColor.clear.cgColor
    textlayer.foregroundColor = color?.cgColor
    
    addSublayer(textlayer)
  }
  
}

//MARK: - AYNumericLayer fileprivate extension
fileprivate extension AYNumericLayer {
  func text() -> String? {
    guard let layer = sublayers?.first(
      where: { $0.isKind(of: CATextLayer.self) }
      ) as? CATextLayer else { return nil }
        
    return layer.string as? String
  }
}

