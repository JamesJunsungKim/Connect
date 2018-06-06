//
//  MasterAlbumCell.swift
//  Connect
//
//  Created by James Kim on 6/3/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

class MasterAlbumCell: ReusableTableViewCell {
    typealias Object = AlbumInfo
    
    //UI
    fileprivate var firstImageView: UIImageView!
    fileprivate var secondImageView: UIImageView!
    fileprivate var thirdImageView: UIImageView!
    fileprivate var albumTitleLabel: UILabel!
    fileprivate var photoNumberLabel: UILabel!
    fileprivate var separatorLine: UIView!
    
    enum Section: Int {
        case allPhotos = 0
        case smartAlbums = 1
        case userCollections = 2
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func prepareForReuse() {
        array.forEach({$0.image = nil; $0.backgroundColor = .clear})
    }
    
    func configure(withObject object: AlbumInfo, parentViewController: UIViewController, currentIndexPath: IndexPath, userInfo: [String : Any]?) {
        
        separatorLine.isHidden = Section(rawValue: currentIndexPath.section)! == .allPhotos ? false : true
        albumTitleLabel.text = object.name
        photoNumberLabel.text = "\(object.totalNumber)"
        show(images: object.images)
    }
    
    // MARK: - Fileprivate
    fileprivate lazy var array = [firstImageView!, secondImageView!, thirdImageView!]
    
    fileprivate func show(images:[UIImage]?) {
        array.forEach({$0.isHidden = true})
        guard let targetImages = images else {
            let image = array.first!
            image.backgroundColor = .lightGray
            image.isHidden = false
            return
        }
        for index in 0..<targetImages.count {
            array[index].image = targetImages[index]
            array[index].isHidden = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MasterAlbumCell {
    fileprivate func setupUI() {
        firstImageView = UIImageView.create()
        secondImageView = UIImageView.create()
        thirdImageView = UIImageView.create()
        
        albumTitleLabel = UILabel.create(text: "All Photo", textAlignment: .left, textColor: .black, fontSize: 17, boldFont: false, numberofLine: 1)
        photoNumberLabel = UILabel.create(text: "1222", textAlignment: .left, textColor: .mainGray, fontSize: 15, boldFont: false, numberofLine: 1)
        
        separatorLine = UIView.create()
        
        let arrowImageView = UIImageView.create(withImageKey: .rightArrow)
        
        let stackView = UIStackView.create(views: [albumTitleLabel, photoNumberLabel], axis: .vertical, alignment: .leading, distribution: .equalSpacing, spacing: 5)
        
        let groupForImages : [UIImageView] = [firstImageView, secondImageView, thirdImageView]
        groupForImages.forEach({$0.contentMode = .scaleAspectFill; $0.setCornerRadious(value: 1)})
        
        let groupForMainView: [UIView] = [thirdImageView, secondImageView, firstImageView, separatorLine, stackView, arrowImageView]
        groupForMainView.forEach(addSubview(_:))
        
        firstImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-8)
            make.sizeEqualTo(width: 70, height: 70)
        }
        
        secondImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(firstImageView)
            make.bottom.equalToSuperview().offset(-17)
            make.sizeEqualTo(width: 65, height: 65)
        }
        
        thirdImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(firstImageView)
            make.bottom.equalToSuperview().offset(-25)
            make.sizeEqualTo(width: 60, height: 60)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.left.equalTo(firstImageView.snp.right).offset(15)
            make.right.equalTo(arrowImageView.snp.left).offset(-20)
            make.centerY.equalTo(secondImageView)
            make.height.equalTo(50)
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(stackView)
            make.sizeEqualTo(width: 15, height: 15)
            make.right.equalToSuperview().offset(-15)
        }
        
        separatorLine.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-0.5)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
