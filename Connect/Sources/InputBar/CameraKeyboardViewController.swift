//
//  CameraKeyboardViewController.swift
//  Connect
//
//  Created by James Kim on 7/1/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation
import Photos
import AVFoundation

public protocol CamerakeyBoardViewControllerDelegate: AnyObject {
    func cameraKeyboardViewController(_ controller: CameraKeyboardViewController, didSelectVideo: URL, duration: TimeInterval)
    func cameraKeyboardViewController(_ controller: CameraKeyboardViewController, didSelectImageData: Data, metadata: ImageMetadata)
    func cameraKeyboardViewControllerWantsToOpenFullScreenCamera(_ controller: CameraKeyboardViewController)
    func cameraKeyboardViewControllerWantsToopenCameraRoll(_ controller: CameraKeyboardViewController)
}

open class CameraKeyboardViewController: UIViewController {
    
    //UI
    internal var collectionView: UICollectionView!
    internal var goBackButton: UIButton!
    internal var cameraRollButton: UIButton!
    
    
    init(assetLibrary: AssetLibrary = AssetLibrary(), permissions: PhotoPermissionsController = PhotoPermissionsControllerStrategy()) {
        self.assetLibrary = assetLibrary
        self.permissions = permissions
        super.init(nibName: nil, bundle: nil)
   
        //ViewDidLoad
        setupUI()
        setupObservers()
        addTargets()
    }
    
    
    
    // MARK: - Public
    open weak var delegate: CamerakeyBoardViewControllerDelegate?
    
    // MARK: - Actions
    
    fileprivate func hideOrShowBackButton(needsToShow: Bool) {
        UIView.animate(withDuration: 0.35) {[unowned self] in
            self.goBackButton.alpha = needsToShow ? 1 : 0
        }
    }
    
    @objc fileprivate func applicationDidBecomeActive(_ notification: Notification) {
        assetLibrary.refetchAssets()
    }
    
    @objc fileprivate func goBackBtnPressed(_ sender: UIButton) {
        
    }
    
    @objc fileprivate func openCameraRollPressed(_ sender: UIButton) {
        delegate?.cameraKeyboardViewControllerWantsToOpenFullScreenCamera(self)
    }
    
    // MARK: - Fileprivate
    fileprivate var permissions: PhotoPermissionsController!
    fileprivate var lastLayoutSize = CGSize.zero
    fileprivate let collectionViewLayout = UICollectionViewLayout()
    fileprivate let sideMargin: CGFloat = 14
    fileprivate var viewWasHidden = false
    fileprivate var callStateObserverToken: Any?
    fileprivate var goBackButtonRevealed = false {
        didSet {
            hideOrShowBackButton(needsToShow: goBackButtonRevealed)
        }
    }
    
    fileprivate var assetLibrary: AssetLibrary = AssetLibrary()
    
    
    fileprivate func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(_:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    fileprivate func addTargets() {
        goBackButton.addTarget(self, action: #selector(goBackBtnPressed(_:)), for: .touchUpInside)
        cameraRollButton.addTarget(self, action: #selector(openCameraRollPressed(_:)), for: .touchUpInside)
    }
    
    
    
    
    
    
    
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CameraKeyboardViewController: AssetLibraryDelegate {
    public func assetLibraryDidChange(_ library: AssetLibrary) {
        collectionView.reloadData()
    }
}




extension CameraKeyboardViewController {
    fileprivate func setupUI() {
        goBackButton = UIButton.create(withImageName: "")
    }
}






















