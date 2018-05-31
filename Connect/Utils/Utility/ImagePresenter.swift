//
//  ImagePresenter.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/31/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class ImagePresenter: UIView {
    
    // UI
    fileprivate var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addTarget()
    }
    
    // MARK: - Public/Internal
    
    public func setup(withSize size:CGSize)  {
        frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        center = superview!.center
        layer.transform = CATransform3DMakeScale(0, 0, 0)
    }
    
    public func present(image: UIImage) {
        imageView.image = image
        getParentViewController()?.view.bringSubview(toFront: self)
        presentOrDismissImage(needsToShow: true)
    }
    
    // MARK: - Actions
    @objc fileprivate func didTapImage() {
        presentOrDismissImage(needsToShow: false)
    }
    
    // MARK: - Fileprivate
    fileprivate var targetImage: UIImage!
    
    fileprivate func addTarget() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        imageView.addGestureRecognizer(tap)
    }
    
    fileprivate func presentOrDismissImage(needsToShow flag: Bool) {
        let targetNumber = CGFloat(flag ? 1 : 0.1)
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = flag ? 1 : 0
            self.layer.transform = CATransform3DMakeScale(targetNumber, targetNumber, targetNumber)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImagePresenter {
    fileprivate func setupUI() {
        imageView = UIImageView.create(withImageKey: .noImage)
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
}
