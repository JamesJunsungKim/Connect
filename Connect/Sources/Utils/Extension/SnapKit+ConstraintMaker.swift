//
//  Codium+Exposure.swift
//  CodiumLayout
//
//  Created by James Kim on 7/2/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import SnapKit

/// Set constraints of a single item
public func constraint<A:UIView>(_ first: A, block:(ConstraintMaker)->Void) {
    let maker = ConstraintMaker(item: first)
    block(maker)
    var constraints: [Constraint] = []
    for description in maker.descriptions {
        guard let constraint = description.constraint else {
            continue
        }
        constraints.append(constraint)
    }
    for constraint in constraints {
        constraint.activateIfNeeded(updatingExisting: false)
    }
}

/// Set constraints of two items
public func constraint<A:UIView,B:UIView>(_ first: A,_ second: B, block:(ConstraintMaker, ConstraintMaker)->Void) {
    let firstMaker = ConstraintMaker(item: first)
    let secondMaker = ConstraintMaker(item: second)
    block(firstMaker, secondMaker)
    var constraints: [Constraint] = []
    [firstMaker, secondMaker].forEach({
        for description in $0.descriptions {
            guard let constraint = description.constraint else {
                continue
            }
            constraints.append(constraint)
        }
    })
    for constraint in constraints {
        constraint.activateIfNeeded(updatingExisting: false)
    }
}

/// Set constraints of three items
public func constraint<A:UIView,B:UIView,C:UIView>(_ first: A,_ second: B,_ third: C, block:(ConstraintMaker, ConstraintMaker,ConstraintMaker)->Void) {
    let firstMaker = ConstraintMaker(item: first)
    let secondMaker = ConstraintMaker(item: second)
    let thirdMaker = ConstraintMaker(item: third)
    block(firstMaker, secondMaker, thirdMaker)
    var constraints: [Constraint] = []
    [firstMaker, secondMaker, thirdMaker].forEach({
        for description in $0.descriptions {
            guard let constraint = description.constraint else {
                continue
            }
            constraints.append(constraint)
        }
    })
    for constraint in constraints {
        constraint.activateIfNeeded(updatingExisting: false)
    }
}

/// Set constraints of four items
public func constraint<A:UIView,B:UIView,C:UIView,D:UIView>(_ first: A,_ second: B,_ third: C,_ fourth:D, block:(ConstraintMaker, ConstraintMaker,ConstraintMaker, ConstraintMaker)->Void) {
    let firstMaker = ConstraintMaker(item: first)
    let secondMaker = ConstraintMaker(item: second)
    let thirdMaker = ConstraintMaker(item: third)
    let fourthMaker = ConstraintMaker(item: fourth)
    block(firstMaker, secondMaker, thirdMaker, fourthMaker)
    var constraints: [Constraint] = []
    [firstMaker, secondMaker, thirdMaker, fourthMaker].forEach({
        for description in $0.descriptions {
            guard let constraint = description.constraint else {
                continue
            }
            constraints.append(constraint)
        }
    })
    for constraint in constraints {
        constraint.activateIfNeeded(updatingExisting: false)
    }
}

/// Set constraints of five items
public func constraint<A:UIView,B:UIView,C:UIView,D:UIView,E:UIView>(_ first: A,_ second: B,_ third: C,_ fourth:D,fifth:E, block:(ConstraintMaker, ConstraintMaker,ConstraintMaker, ConstraintMaker, ConstraintMaker)->Void) {
    let firstMaker = ConstraintMaker(item: first)
    let secondMaker = ConstraintMaker(item: second)
    let thirdMaker = ConstraintMaker(item: third)
    let fourthMaker = ConstraintMaker(item: fourth)
    let fifthMaker = ConstraintMaker(item: fifth)
    block(firstMaker, secondMaker, thirdMaker, fourthMaker,fifthMaker)
    var constraints: [Constraint] = []
    [firstMaker, secondMaker, thirdMaker, fourthMaker, fifthMaker].forEach({
        for description in $0.descriptions {
            guard let constraint = description.constraint else {
                continue
            }
            constraints.append(constraint)
        }
    })
    for constraint in constraints {
        constraint.activateIfNeeded(updatingExisting: false)
    }
}

/// Set constraints of six items
public func constraint<A:UIView,B:UIView,C:UIView,D:UIView,E:UIView,F:UIView>(_ first: A,_ second: B,_ third: C,_ fourth:D,fifth:E, sixth:F, block:(ConstraintMaker, ConstraintMaker,ConstraintMaker, ConstraintMaker, ConstraintMaker, ConstraintMaker)->Void) {
    let firstMaker = ConstraintMaker(item: first)
    let secondMaker = ConstraintMaker(item: second)
    let thirdMaker = ConstraintMaker(item: third)
    let fourthMaker = ConstraintMaker(item: fourth)
    let fifthMaker = ConstraintMaker(item: fifth)
    let sixthMaker = ConstraintMaker(item: sixth)
    block(firstMaker, secondMaker, thirdMaker, fourthMaker,fifthMaker, sixthMaker)
    var constraints: [Constraint] = []
    [firstMaker, secondMaker, thirdMaker, fourthMaker, fifthMaker,sixthMaker].forEach({
        for description in $0.descriptions {
            guard let constraint = description.constraint else {
                continue
            }
            constraints.append(constraint)
        }
    })
    for constraint in constraints {
        constraint.activateIfNeeded(updatingExisting: false)
    }
}

/// Set constraints of seven items
public func constraint<A:UIView,B:UIView,C:UIView,D:UIView,E:UIView,F:UIView,G:UIView>(_ first: A,_ second: B,_ third: C,_ fourth:D,fifth:E, sixth:F,seventh:G, block:(ConstraintMaker, ConstraintMaker,ConstraintMaker, ConstraintMaker, ConstraintMaker, ConstraintMaker,ConstraintMaker)->Void) {
    let firstMaker = ConstraintMaker(item: first)
    let secondMaker = ConstraintMaker(item: second)
    let thirdMaker = ConstraintMaker(item: third)
    let fourthMaker = ConstraintMaker(item: fourth)
    let fifthMaker = ConstraintMaker(item: fifth)
    let sixthMaker = ConstraintMaker(item: sixth)
    let seventhMaker = ConstraintMaker(item: seventh)
    block(firstMaker, secondMaker, thirdMaker, fourthMaker,fifthMaker, sixthMaker,seventhMaker)
    var constraints: [Constraint] = []
    [firstMaker, secondMaker, thirdMaker, fourthMaker, fifthMaker,sixthMaker, seventhMaker].forEach({
        for description in $0.descriptions {
            guard let constraint = description.constraint else {
                continue
            }
            constraints.append(constraint)
        }
    })
    for constraint in constraints {
        constraint.activateIfNeeded(updatingExisting: false)
    }
}

/// Set constraints of eight items
public func constraint<A:UIView,B:UIView,C:UIView,D:UIView,E:UIView,F:UIView,G:UIView, H:UIView>(_ first: A,_ second: B,_ third: C,_ fourth:D,fifth:E, sixth:F,seventh:G,eighth:H, block:(ConstraintMaker, ConstraintMaker,ConstraintMaker, ConstraintMaker, ConstraintMaker, ConstraintMaker,ConstraintMaker,ConstraintMaker)->Void) {
    let firstMaker = ConstraintMaker(item: first)
    let secondMaker = ConstraintMaker(item: second)
    let thirdMaker = ConstraintMaker(item: third)
    let fourthMaker = ConstraintMaker(item: fourth)
    let fifthMaker = ConstraintMaker(item: fifth)
    let sixthMaker = ConstraintMaker(item: sixth)
    let seventhMaker = ConstraintMaker(item: seventh)
    let eighthMaker = ConstraintMaker(item: eighth)
    block(firstMaker, secondMaker, thirdMaker, fourthMaker,fifthMaker, sixthMaker,seventhMaker,eighthMaker)
    var constraints: [Constraint] = []
    [firstMaker, secondMaker, thirdMaker, fourthMaker, fifthMaker,sixthMaker, seventhMaker,eighthMaker].forEach({
        for description in $0.descriptions {
            guard let constraint = description.constraint else {
                continue
            }
            constraints.append(constraint)
        }
    })
    for constraint in constraints {
        constraint.activateIfNeeded(updatingExisting: false)
    }
}

/// Set constraints of nine items
public func constraint<A:UIView,B:UIView,C:UIView,D:UIView,E:UIView,F:UIView,G:UIView, H:UIView, I:UIView>(_ first: A,_ second: B,_ third: C,_ fourth:D,fifth:E, sixth:F,seventh:G,eighth:H,nineth:I, block:(ConstraintMaker, ConstraintMaker,ConstraintMaker, ConstraintMaker, ConstraintMaker, ConstraintMaker,ConstraintMaker,ConstraintMaker,ConstraintMaker)->Void) {
    let firstMaker = ConstraintMaker(item: first)
    let secondMaker = ConstraintMaker(item: second)
    let thirdMaker = ConstraintMaker(item: third)
    let fourthMaker = ConstraintMaker(item: fourth)
    let fifthMaker = ConstraintMaker(item: fifth)
    let sixthMaker = ConstraintMaker(item: sixth)
    let seventhMaker = ConstraintMaker(item: seventh)
    let eighthMaker = ConstraintMaker(item: eighth)
    let ninethMaker = ConstraintMaker(item: nineth)
    block(firstMaker, secondMaker, thirdMaker, fourthMaker,fifthMaker, sixthMaker,seventhMaker,eighthMaker,ninethMaker)
    var constraints: [Constraint] = []
    [firstMaker, secondMaker, thirdMaker, fourthMaker, fifthMaker,sixthMaker, seventhMaker,eighthMaker,ninethMaker].forEach({
        for description in $0.descriptions {
            guard let constraint = description.constraint else {
                continue
            }
            constraints.append(constraint)
        }
    })
    for constraint in constraints {
        constraint.activateIfNeeded(updatingExisting: false)
    }
}

/// Set constraints of ten items
public func constraint<A:UIView,B:UIView,C:UIView,D:UIView,E:UIView,F:UIView,G:UIView, H:UIView, I:UIView,J:UIView>(_ first: A,_ second: B,_ third: C,_ fourth:D,fifth:E, sixth:F,seventh:G,eighth:H,nineth:I,tenth:J, block:(ConstraintMaker, ConstraintMaker,ConstraintMaker, ConstraintMaker, ConstraintMaker, ConstraintMaker,ConstraintMaker,ConstraintMaker,ConstraintMaker,ConstraintMaker)->Void) {
    let firstMaker = ConstraintMaker(item: first)
    let secondMaker = ConstraintMaker(item: second)
    let thirdMaker = ConstraintMaker(item: third)
    let fourthMaker = ConstraintMaker(item: fourth)
    let fifthMaker = ConstraintMaker(item: fifth)
    let sixthMaker = ConstraintMaker(item: sixth)
    let seventhMaker = ConstraintMaker(item: seventh)
    let eighthMaker = ConstraintMaker(item: eighth)
    let ninethMaker = ConstraintMaker(item: nineth)
    let tenthMaker = ConstraintMaker(item: tenth)
    block(firstMaker, secondMaker, thirdMaker, fourthMaker,fifthMaker, sixthMaker,seventhMaker,eighthMaker,ninethMaker,tenthMaker)
    var constraints: [Constraint] = []
    [firstMaker, secondMaker, thirdMaker, fourthMaker, fifthMaker,sixthMaker, seventhMaker,eighthMaker,ninethMaker,tenthMaker].forEach({
        for description in $0.descriptions {
            guard let constraint = description.constraint else {
                continue
            }
            constraints.append(constraint)
        }
    })
    for constraint in constraints {
        constraint.activateIfNeeded(updatingExisting: false)
    }
}




extension ConstraintMaker {
    
    public func sameTo(_ target: UIView) {
        self.left.right.top.bottom.equalTo(target)
    }
    
    public func sizeEqualTo(width:CGFloat, height:CGFloat) {
        self.size.equalTo(CGSize(width: width, height: height))
    }
    
    public func leftRightEqualToSuperView(withOffset value: CGFloat) {
        self.left.equalToSuperview().offset(value)
        self.right.equalToSuperview().offset(-value)
    }
    
    public func topBottomEqualToSuperView(withOffset value: CGFloat) {
        self.top.equalToSuperview().offset(value)
        self.bottom.equalToSuperview().offset(-value)
    }
    
    public func topRightqualToSuperView(withOffset value: CGFloat) {
        self.top.equalToSuperview().offset(value)
        self.right.equalToSuperview().offset(-value)
    }
    public func leftBottomEqualToSuperView(withOffset value: CGFloat) {
        self.left.equalToSuperview().offset(value)
        self.bottom.equalToSuperview().offset(-value)
    }
}












