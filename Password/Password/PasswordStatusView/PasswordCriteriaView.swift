//
//  PasswordCriteriaView.swift
//  Password
//
//  Created by Elizeu RS on 27/06/22.
//

import Foundation
import UIKit

class PasswordCriteriaView: UIView {
  
  let stackView = UIStackView()
  let imageView = UIImageView()
  let label = UILabel()
  
  let checkmarkImage = UIImage(systemName: "checkmark.circle")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
  let xmarkImage = UIImage(systemName: "xmark.circle")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
  let circleImage = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
  
  var isCriteriaMet: Bool = false {
    didSet {
      if isCriteriaMet {
        imageView.image = checkmarkImage
      } else {
        imageView.image = xmarkImage
      }
    }
  }
  
  func reset() {
    isCriteriaMet = false
    imageView.image = circleImage
  }
  
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//
//    style()
//    layout()
//  }
  
  init(text: String) {
    // meaning this view will initially not have any size, auto layout will take care of that for us.
    super.init(frame: .zero)
    
    label.text = text
    
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 200, height: 40)
  }
}

extension PasswordCriteriaView {
  
  func style() {
    translatesAutoresizingMaskIntoConstraints = false
//    backgroundColor = .systemOrange
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.spacing = 8
//    stackView.backgroundColor = .systemRed
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .preferredFont(forTextStyle: .subheadline)
    label.textColor = .secondaryLabel
//    label.text = "uppercase letter (A-Z)"
  }
  
  func layout() {
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(label)
    
    addSubview(stackView)
    
    // stack
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
    // image
    NSLayoutConstraint.activate([
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
    ])
    
    // chcr
    imageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
  }
}
