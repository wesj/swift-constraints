//: A UIKit based Playground for presenting user interface

import UIKit
import Foundation

// self |-5-child1-10-child2-5-| self
prefix operator |-
prefix operator ^-
postfix operator -|
postfix operator -^
infix operator ~: AdditionPrecedence
infix operator /<=: AdditionPrecedence
infix operator />=: AdditionPrecedence
infix operator /=: AdditionPrecedence

struct Constraint<T:AnyObject> {
    let anchor: NSLayoutAnchor<T>?
    let view: UIView?
    let constant: CGFloat
    let priority: UILayoutPriority?

    init(anchor: NSLayoutAnchor<T>? = nil,
         view: UIView? = nil,
         constant: CGFloat = 0,
         priority: UILayoutPriority? = nil) {
        self.anchor = anchor
        self.view = view
        self.constant = constant
        self.priority = priority
    }
}

typealias ConstraintX = Constraint<NSLayoutXAxisAnchor>
typealias ConstraintY = Constraint<NSLayoutYAxisAnchor>

@discardableResult
prefix func |-(rhs: ConstraintX) -> ConstraintX {
    print("|- with constraint (\(rhs.constant))")
    guard let view = rhs.view?.superview else {
        return rhs;
    }
    let l = ConstraintX(anchor: view.leadingAnchor,
                        view: view)
    return l - rhs
}

@discardableResult
prefix func ^-(rhs: ConstraintY) -> ConstraintY {
    print("^- with constraint (\(rhs.constant))")
    guard let view = rhs.view?.superview else {
        return rhs
    }
    let l = ConstraintY(anchor: view.topAnchor,
                        view: view)
    return l - rhs
}

@discardableResult
prefix func |-(rhs: UIView) -> ConstraintX {
    print("|- with view")
    guard let anchor = rhs.superview?.leadingAnchor else {
        return ConstraintX(
            anchor: rhs.trailingAnchor,
            view: rhs)
    }

    let l = ConstraintX(anchor: anchor)
    let r = ConstraintX(anchor: rhs.leadingAnchor, view: rhs)
    return l - r
}

@discardableResult
prefix func ^-(rhs: UIView) -> ConstraintY {
    print("^- with view")
    guard let anchor = rhs.superview?.topAnchor else {
        return ConstraintY(
            anchor: rhs.bottomAnchor,
            view: rhs)
    }
    let l = ConstraintY(anchor: anchor,
                        view: rhs.superview)
    let r = ConstraintY(anchor: rhs.topAnchor,
                        view: rhs)
    return l - r
}

@discardableResult
prefix func |-(rhs: Double) -> ConstraintX {
    print("|- with double \(rhs)")
    return ConstraintX(constant: CGFloat(rhs))
}

@discardableResult
prefix func ^-(rhs: Double) -> ConstraintY {
    print("|- with double \(rhs)")
    return ConstraintY(constant: CGFloat(rhs))
}

@discardableResult
prefix func |-(rhs: ConstraintY) -> ConstraintY {
    print("|- with constraint (\(rhs.constant))")
    guard let view = rhs.view?.superview else {
        return rhs
    }
    let l = ConstraintY(anchor: view.topAnchor,
                        view: view)
    return l - rhs
}

@discardableResult
prefix func |-(rhs: UIView) -> ConstraintY {
    print("|- with view")
    guard let anchor = rhs.superview?.topAnchor else {
        return ConstraintY(
            anchor: rhs.bottomAnchor,
            view: rhs)
    }
    let l = ConstraintY(anchor: anchor,
                        view: rhs.superview)
    let r = ConstraintY(anchor: rhs.topAnchor,
                        view: rhs)
    return l - r
}

@discardableResult
func -(lhs: NSLayoutXAxisAnchor, rhs: UIView) -> ConstraintX {
    print("- with anchor and view")
    let l = ConstraintX(anchor: lhs)
    let r = ConstraintX(anchor: rhs.leadingAnchor,
                        view: rhs)
    return l - r
}

@discardableResult
func -(lhs: NSLayoutXAxisAnchor, rhs: ConstraintX) -> ConstraintX {
    print("- with anchor and constraint")
    let l = ConstraintX(anchor: lhs)
    return l - rhs
}

@discardableResult
func -(lhs: NSLayoutYAxisAnchor, rhs: UIView) -> ConstraintY {
    print("- with anchor and view")
    let l = ConstraintY(anchor: lhs)
    let r = ConstraintY(anchor: rhs.topAnchor,
                        view: rhs)
    return l - r
}

@discardableResult
func -(lhs: NSLayoutYAxisAnchor, rhs: ConstraintY) -> ConstraintY {
    print("- with anchor and constraint")
    let l = ConstraintY(anchor: lhs)
    return l - rhs
}

@discardableResult
func -(lhs: NSLayoutYAxisAnchor, rhs: Double) -> ConstraintY {
    print("- with anchor and double")
    let l = ConstraintY(anchor: lhs)
    let r = ConstraintY(constant: CGFloat(rhs))
    return l - r
}

@discardableResult
func -(lhs: ConstraintX, rhs: UIView) -> ConstraintX {
    print("- with constraint (\(lhs.constant)) and view")
    let r = ConstraintX(anchor: rhs.leadingAnchor,
                        view: rhs)
    return lhs - r
}

@discardableResult
func -(lhs: ConstraintX, rhs: NSLayoutXAxisAnchor) -> ConstraintX {
    print("- with constraint (\(lhs.constant)) and anchor")
    let builder = ConstraintX(anchor: rhs)
    return lhs - builder
}

@discardableResult
func -(lhs: ConstraintY, rhs: NSLayoutYAxisAnchor) -> ConstraintY {
    print("- with constraint (\(lhs.constant)) and anchor")
    let builder = ConstraintY(anchor: rhs)
    return lhs - builder
}

@discardableResult
func -(lhs: ConstraintX, rhs: Double) -> ConstraintX {
    print("- with constraint (\(lhs.constant)) and double \(rhs)")
    return ConstraintX(anchor: lhs.anchor,
                       view: lhs.view,
                       constant: lhs.constant + CGFloat(rhs))
}

@discardableResult
func -(lhs: ConstraintY, rhs: Double) -> ConstraintY {
    print("- with constraint (\(lhs.constant)) and double \(rhs)")
    return ConstraintY(anchor: lhs.anchor,
                       view: lhs.view,
                       constant: lhs.constant + CGFloat(rhs))
}

@discardableResult
func -(lhs: ConstraintY, rhs: UIView) -> ConstraintY {
    print("- with constraint (\(lhs.constant)) and view")
    let rBuilder = ConstraintY(anchor: rhs.topAnchor,
                               view: rhs)
    return lhs - rBuilder
}

@discardableResult
func -(lhs: ConstraintX, rhs: ConstraintX) -> ConstraintX {
    let const = (lhs.constant + rhs.constant)
    print("- with two constraints \(const)")
    guard let lAnchor = lhs.anchor ?? rhs.view?.superview?.leadingAnchor,
          let rAnchor = rhs.anchor ?? lhs.view?.superview?.trailingAnchor else {
            return Constraint(
                anchor: rhs.anchor ?? lhs.anchor,
                view: rhs.view ?? lhs.view,
                constant: const)
    }

    lAnchor.constraint(equalTo: rAnchor,
                       constant: -const).isActive = true
    return Constraint(anchor: rhs.view?.trailingAnchor ?? rAnchor,
                      view: rhs.view ?? lhs.view?.superview)
}

@discardableResult
func -(lhs: ConstraintY, rhs: ConstraintY) -> ConstraintY {
    let const = (lhs.constant + rhs.constant)
    print("- with two constraints \(const)")
    guard let lAnchor = lhs.anchor ?? rhs.view?.superview?.topAnchor,
        let rAnchor = rhs.anchor ?? lhs.view?.superview?.bottomAnchor else {
            return Constraint(
                anchor: rhs.anchor ?? lhs.anchor,
                view: rhs.view ?? lhs.view,
                constant: const)
    }

    let c = lAnchor.constraint(equalTo: rAnchor,
                               constant: -const)
    c.isActive = true
    c.priority = rhs.priority ?? lhs.priority ?? .required
    return Constraint(anchor: rhs.view?.bottomAnchor ?? rAnchor,
                      view: rhs.view ?? lhs.view?.superview)
}

@discardableResult
postfix func -|(lhs: UIView) -> ConstraintX {
    print("-| with view")
    guard let anchor = lhs.superview?.trailingAnchor else {
        return Constraint(anchor: lhs.leadingAnchor,
                          view: lhs)
    }
    let l = Constraint(anchor: lhs.trailingAnchor,
                       view: lhs)
    let r = Constraint(anchor: anchor)
    l - r
    return Constraint(anchor: lhs.leadingAnchor,
                      view: lhs)
}

@discardableResult
postfix func -^(lhs: UIView) -> ConstraintY {
    print("-^ with view")
    guard let anchor = lhs.superview?.bottomAnchor else {
        return Constraint(anchor: lhs.topAnchor,
                          view: lhs)
    }
    let l = Constraint(anchor: lhs.bottomAnchor,
                       view: lhs)
    let r = Constraint(anchor: anchor,
                       view: lhs.superview)
    l - r
    return Constraint(anchor: lhs.topAnchor,
                      view: lhs)
}

@discardableResult
func ~(lhs: ConstraintX, rhs: Double) -> ConstraintX {
    if rhs <= 500 {
        return ConstraintX(anchor: lhs.anchor,
                           view: lhs.view,
                           constant: lhs.constant,
                           priority: .defaultLow)
    } else if rhs <= 750 {
        return ConstraintX(anchor: lhs.anchor,
                           view: lhs.view,
                           constant: lhs.constant,
                           priority: .defaultHigh)
    }
    return ConstraintX(anchor: lhs.anchor,
                       view: lhs.view,
                       constant: lhs.constant,
                       priority: .required)
}

@discardableResult
func ~(lhs: ConstraintY, rhs: Double) -> ConstraintY {
    var priority: UILayoutPriority = .required
    if rhs <= 500 {
        priority = .defaultLow
    } else if rhs <= 750 {
        priority = .defaultHigh
    }
    return ConstraintY(anchor: lhs.anchor,
                       view: lhs.view,
                       constant: lhs.constant,
                       priority: priority)
}

@discardableResult
func ~(lhs: ConstraintY, rhs: ConstraintY) -> ConstraintY {
    var priority: UILayoutPriority = .required
    if rhs.constant <= 500 {
        priority = .defaultLow
    } else if rhs.constant <= 750 {
        priority = .defaultHigh
    }
    return ConstraintY(anchor: lhs.anchor,
                       view: lhs.view,
                       constant: lhs.constant,
                       priority: priority)
}

@discardableResult
postfix func -|(lhs: Double) -> ConstraintX {
    print("-| with double \(lhs)")
    return ConstraintX(constant: CGFloat(lhs))
}

@discardableResult
postfix func -^(lhs: Double) -> ConstraintY {
    print("-^ with double \(lhs)")
    return ConstraintY(constant: CGFloat(lhs))
}

@discardableResult
postfix func -|(lhs: ConstraintX) -> ConstraintX {
    print("-| with constraint")
    guard let view = lhs.view?.superview else {
        return Constraint(anchor: lhs.view?.leadingAnchor,
                          view: lhs.view)
    }
    let r = Constraint(anchor: view.trailingAnchor,
                       view: view)
    return lhs - r
}

@discardableResult
postfix func -|(lhs: ConstraintY) -> ConstraintY {
    print("-| with constraint")
    guard let view = lhs.view?.superview else {
        return Constraint(anchor: lhs.view?.topAnchor,
                          view: lhs.view)
    }
    let r = Constraint(anchor: view.bottomAnchor,
                       view: view)
    return lhs - r
}

@discardableResult
postfix func -^(lhs: ConstraintY) -> ConstraintY {
    print("-| with constraint")
    guard let view = lhs.view?.superview else {
        return ConstraintY(anchor: lhs.view?.topAnchor,
                           view: lhs.view)
    }
    return lhs - view.bottomAnchor
}

@discardableResult
func /=(lhs: ConstraintX, rhs: UIView) -> ConstraintX {
    guard let v = lhs.view else {
        print("Can't Match width")
        return lhs
    }
    print("Match width")
    v.widthAnchor.constraint(equalTo: rhs.widthAnchor).isActive = true
    return lhs
}

@discardableResult
func />=(lhs: ConstraintX, rhs: UIView) -> ConstraintX {
    guard let v = lhs.view else {
        print("Can't Match width")
        return lhs
    }
    print("Greater width")
    v.widthAnchor.constraint(greaterThanOrEqualTo: rhs.widthAnchor).isActive = true
    return lhs
}

@discardableResult
func /<=(lhs: ConstraintX, rhs: UIView) -> ConstraintX {
    guard let v = lhs.view else {
        print("Can't Match width")
        return lhs
    }
    print("Less width")
    v.widthAnchor.constraint(lessThanOrEqualTo: rhs.widthAnchor).isActive = true
    return lhs
}

@discardableResult
func /=(lhs: ConstraintX, rhs: Double) -> ConstraintX {
    guard let v = lhs.view else {
        print("Can't Match width")
        return lhs
    }
    print("Equal constant width")
    v.widthAnchor.constraint(equalToConstant: CGFloat(rhs)).isActive = true
    return lhs
}

@discardableResult
func />=(lhs: ConstraintX, rhs: Double) -> ConstraintX {
    guard let v = lhs.view else {
        print("Can't Match width")
        return lhs
    }
    print("Greater constant width")
    v.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(rhs)).isActive = true
    return lhs
}

@discardableResult
func /<=(lhs: ConstraintX, rhs: Double) -> ConstraintX {
    guard let v = lhs.view else {
        print("Can't Match width")
        return lhs
    }
    print("Less constant width")
    v.widthAnchor.constraint(lessThanOrEqualToConstant: CGFloat(rhs)).isActive = true
    return lhs
}

@discardableResult
func /=(lhs: ConstraintY, rhs: UIView) -> ConstraintY {
    guard let v = lhs.view else {
        return lhs
    }
    v.heightAnchor.constraint(equalTo: rhs.heightAnchor).isActive = true
    return lhs
}

@discardableResult
func />=(lhs: ConstraintY, rhs: UIView) -> ConstraintY {
    guard let v = lhs.view else {
        return lhs
    }
    v.heightAnchor.constraint(greaterThanOrEqualTo: rhs.heightAnchor).isActive = true
    return lhs
}

@discardableResult
func /<=(lhs: ConstraintY, rhs: UIView) -> ConstraintY {
    guard let v = lhs.view else {
        return lhs
    }
    v.heightAnchor.constraint(lessThanOrEqualTo: rhs.heightAnchor).isActive = true
    return lhs
}

@discardableResult
func /=(lhs: ConstraintY, rhs: Double) -> ConstraintY {
    guard let v = lhs.view else {
        return lhs
    }
    v.heightAnchor.constraint(equalToConstant: CGFloat(rhs)).isActive = true
    return lhs
}

@discardableResult
func />=(lhs: ConstraintY, rhs: Double) -> ConstraintY {
    guard let v = lhs.view else {
        return lhs
    }
    v.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(rhs)).isActive = true
    return lhs
}

@discardableResult
func /<=(lhs: ConstraintY, rhs: Double) -> ConstraintY {
    guard let v = lhs.view else {
        return lhs
    }
    v.heightAnchor.constraint(lessThanOrEqualToConstant: CGFloat(rhs)).isActive = true
    return lhs
}

@discardableResult
func -(lhs: UIView, rhs: ConstraintX) -> ConstraintX {
    let l = ConstraintX(anchor: lhs.trailingAnchor,
                        view: lhs)
    return l - rhs
}


class MyViewController : UIViewController {
    private func makeLabel(_ name: String,
                           _ color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = name
        label.textColor = .black
        label.backgroundColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view

        view.translatesAutoresizingMaskIntoConstraints = false

        let label = makeLabel("Match label 2 width", .red)
        let label2 = makeLabel("Label 2", .green)
        let label3 = makeLabel("Height 150", .blue)

        // |-label==label2-20-label2=120@250-20@750-label3>=50-|
        |-label/>=label2-label2-|
        |-label3-|
        ^-label-^
        label.topAnchor-20-label2-20-label.bottomAnchor
        ^-50-label-50-label3/<=150~250-50~250-^

        verifyConstraints(view.constraints,
            [NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: label, attribute: .leading, multiplier: 1.0, constant: 0.0),
             NSLayoutConstraint(item: label, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: label2, attribute: .width, multiplier: 1.0, constant: 0.0),
             NSLayoutConstraint(item: label2, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0),
             NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: label2, attribute: .leading, multiplier: 1.0, constant: 0.0),
             NSLayoutConstraint(item: label3, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0),
             NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: label3, attribute: .leading, multiplier: 1.0, constant: 0.0),
             NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0),
             NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: label, attribute: .top, multiplier: 1.0, constant: 0.0),
             ]
        )
    }

    func verifyConstraints(_ current: [NSLayoutConstraint],
                           _ expected: [NSLayoutConstraint]) {
        if (current.count != expected.count) {
            print("FAIL: List lengths don't match: \(current.count) != (expected.count)")
        }

        for (index, c) in current.enumerated() {
            print("Index \(index)")
            verifyConstraint(c, expected[index])
            //if c != expected[index] {
                // print("FAIL at \(index): \(c) \(expected[index])")
            //}
        }
    }

    func verifyConstraint(_ current: NSLayoutConstraint,
                          _ expected: NSLayoutConstraint) {
        if current.constant != expected.constant {
            print(" -- Constant is wrong: \(current.constant) \(expected.constant)")
        }

        if current.firstAnchor != expected.firstAnchor {
            print(" -- firstAnchor is wrong: \(current.firstAnchor) \(expected.firstAnchor)")
        }

        if current.secondAnchor != expected.secondAnchor {
            print(" -- secondAnchor is wrong: \(current.secondAnchor) \(String(describing: expected.secondAnchor))")
        }

        if current.firstAttribute != expected.firstAttribute {
            print(" -- firstAttribute is wrong: \(current.firstAttribute.rawValue) \(expected.firstAttribute.rawValue)")
        }

        if current.secondAttribute != expected.secondAttribute {
            print(" -- secondAttribute is wrong: \(current.secondAttribute.rawValue) \(expected.secondAttribute.rawValue)")
        }

        if current.multiplier != expected.multiplier {
            print(" -- multiplier is wrong: \(current.multiplier) \(expected.multiplier)")
        }

        if current.priority != expected.priority {
            print(" -- priority is wrong: \(current.priority) \(expected.priority)")
        }

        if current.relation != expected.relation {
            print(" -- relation is wrong: \(current.relation) \(expected.relation)")
        }
    }
    
}

