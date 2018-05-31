//
//  MustBeDeleted.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/26/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

struct Dummy {}

class Test: UIViewController {
    fileprivate var a : ImagePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        a = ImagePresenter(frame: .zero)
        view.addSubview(a)
        a.setup(withSize: CGSize(width: 200, height: 200))
        let btn = UIButton.create(title: "Click")
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.sizeEqualTo(width: 70, height: 20)
        }
        btn.addTarget(self, action: #selector(b), for: .touchUpInside)
        
    }
    @objc fileprivate func b() {
        a.present(image: UIImage.create(forKey: .personPlaceHolder))
    }
}
