import UIKit

class ImagePresenter: UIView {
    // UI
    fileprivate var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addTarget()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public/Internal
    
    public func present(image: UIImage, atSize size: CGSize, fromStartPoint startPoint: CGPoint) {
        // initial point.
        self.startPoint = startPoint
        frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        center = startPoint
        layer.transform = CATransform3DMakeScale(0, 0, 0)
        
        imageView.image = image
        presentOrDismissImage(needsToShow: true)
    }
    
    // MARK: - Actions
    @objc fileprivate func didTapImage() {
        presentOrDismissImage(needsToShow: false)
        
    }
    
    // MARK: - Fileprivate
    fileprivate weak var parentView: UIView!
    fileprivate var startPoint : CGPoint!
    fileprivate lazy var tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
    
    fileprivate func addTarget() {
        imageView.addGestureRecognizer(tap)
    }
    
    fileprivate func presentOrDismissImage(needsToShow flag: Bool) {
        let targetNumber = CGFloat(flag ? 1 : 0.1)
        let topView = self.getMostTopViewController()?.view
        flag ? topView?.addGestureRecognizer(tap) : topView?.removeGestureRecognizer(tap)
        UIView.animate(withDuration: 0.3, animations: {
            self.center = flag ? self.superview!.center : self.startPoint
            self.alpha = flag ? 1 : 0
            self.layer.transform = CATransform3DMakeScale(targetNumber, targetNumber, targetNumber)
        })
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
