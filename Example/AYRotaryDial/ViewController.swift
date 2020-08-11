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

import AYRotaryDial

class ViewController: UIViewController {
  @IBOutlet weak var rotaryDial: AYRotaryDial!
  @IBOutlet weak var txtField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    rotaryDial.uiDelegate = self
    rotaryDial.numberDidRotate = { [weak self] number in
      self?.txtField.text?.append(String(number))
    }
    
    txtField.setupPlaceholder(text: "ex. +380501234567")
    txtField.font = .boldSystemFont(ofSize: 22)
    txtField.textColor = .white
  }
}

//MARK: - IBActions
extension ViewController {
  @IBAction func btnAsteriskTouchUpInside(_ sender: UIButton) {
    txtField.text?.append("*")
  }
  
  @IBAction func btnPlusTouchUpInside(_ sender: UIButton) {
    txtField.text?.append("+")
  }
  
  @IBAction func btnHashtagTouchUpInside(_ sender: UIButton) {
    txtField.text?.append("#")
  }
  
  @IBAction func btnDeleteTouchUpInside(_ sender: UIButton) {
    guard txtField.text?.isEmpty == false else { return }
    txtField.text?.removeLast()
  }
  
  @IBAction func btnPhoneTouchUpInside(_ sender: UIButton) {
    guard txtField.text?.isEmpty == false else { return }
    guard let text = txtField.text,
      let number = URL(string: "tel://" + text) else { return }
    UIApplication.shared.open(number)
  }
}

//MARK: - AYRotaryDialLayerDelegate protocol implementation
extension ViewController: AYRotaryDialLayerDelegate {
  var dialBackgroundColor: UIColor {
    return UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1.0)
  }
  
  var numberCircleBackgroundColor: UIColor {
    return .white
  }
  
  var numberCircleTextColor: UIColor {
    return .black
  }
  
  var numberCircleTextFont: UIFont {
    let font = UIFont(name: "GillSans-BoldItalic", size: 22)
    return font ?? UIFont.dialDefault
  }
  
  var separatorBackgroundColor: UIColor {
    return .red
  }
}

//MARK: - UITextField fileprivate extension (Placeholder color)
fileprivate extension UITextField {
  func setupPlaceholder(text: String, color: UIColor = .white, with alpha: CGFloat = 0.32) {
    attributedPlaceholder = NSAttributedString(
      string: text,
      attributes: [NSAttributedString.Key.foregroundColor: color.withAlphaComponent(alpha)]
    )
  }
}
