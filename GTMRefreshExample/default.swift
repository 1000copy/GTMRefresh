import UIKit
import GTMRefresh
class DefaultGTMRefreshHeader1: GTMRefreshHeader, SubGTMRefreshHeaderProtocol {
    var pullDownToRefresh = GTMRLocalize("pullDownToRefresh")
    var releaseToRefresh = GTMRLocalize("releaseToRefresh")
    var refreshSuccess = GTMRLocalize("refreshSuccess")
    var refreshFailure = GTMRLocalize("refreshFailure")
    var refreshing = GTMRLocalize("refreshing")
    var txtColor: UIColor? {
        didSet {
            if let color = txtColor {
                self.messageLabel.textColor = color
            }
        }
    }
    var idleImage: UIImage? {
        didSet {
            if let idleImg = idleImage {
                self.pullingIndicator.image = idleImg
            }
        }
    }
    var sucImage: UIImage?
    var failImage: UIImage?
    lazy var pullingIndicator: UIImageView = {
        let pindicator = UIImageView()
        pindicator.image = UIImage(named: "arrow_down", in: Bundle(for: GTMRefreshHeader.self), compatibleWith: nil)
        return pindicator
    }()
    lazy var loaddingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .gray
        //indicator.backgroundColor = UIColor.white
        return indicator
    }()
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.messageLabel)
        self.contentView.addSubview(self.pullingIndicator)
        self.contentView.addSubview(self.loaddingIndicator)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: frame.width * 0.5 - 70 - 20, y: frame.height * 0.5)
        pullingIndicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        pullingIndicator.mj_center = center
        loaddingIndicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        loaddingIndicator.mj_center = center
        messageLabel.frame = self.bounds
    }
    // MARK: SubGTMRefreshHeaderProtocol
    /// 控件的高度
    ///
    /// - Returns: 控件的高度
    func contentHeight() -> CGFloat {
        return 60.0
    }
    func toNormalState() {
        self.loaddingIndicator.isHidden = true
        self.pullingIndicator.isHidden = false
        self.loaddingIndicator.stopAnimating()
        messageLabel.text =  self.pullDownToRefresh
        if let img = self.idleImage {
            pullingIndicator.image = img
        } else {
            pullingIndicator.image = UIImage(named: "arrow_down", in: Bundle(for: DefaultGTMRefreshHeader1.self), compatibleWith: nil)
        }
    }
    func toRefreshingState() {
        self.pullingIndicator.isHidden = true
        self.loaddingIndicator.isHidden = false
        self.loaddingIndicator.startAnimating()
        messageLabel.text = self.refreshing
    }
    func toPullingState() {
        self.loaddingIndicator.isHidden = true
        messageLabel.text = self.pullDownToRefresh
        guard pullingIndicator.transform == CGAffineTransform(rotationAngle: CGFloat(-Double.pi+0.000001))  else{
            return
        }
        UIView.animate(withDuration: 0.4, animations: {
            self.pullingIndicator.transform = CGAffineTransform.identity
        })
    }
    func toWillRefreshState() {
        messageLabel.text = self.releaseToRefresh
        self.loaddingIndicator.isHidden = true
        guard pullingIndicator.transform == CGAffineTransform.identity else{
            return
        }
        UIView.animate(withDuration: 0.4, animations: {
            self.pullingIndicator.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi+0.000001))
        })
    }
    func changePullingPercent(percent: CGFloat) {
        // here do nothing
    }
    func willBeginEndRefershing(isSuccess: Bool) {
        self.pullingIndicator.isHidden = false
        self.pullingIndicator.transform = CGAffineTransform.identity
        self.loaddingIndicator.isHidden = true
        if isSuccess {
            messageLabel.text =  self.refreshSuccess
            if let img = self.sucImage {
                pullingIndicator.image = img
            } else {
                pullingIndicator.image = UIImage(named: "success", in: Bundle(for: DefaultGTMRefreshHeader1.self), compatibleWith: nil)
            }
        } else {
            messageLabel.text =  self.refreshFailure
            if let img = self.failImage {
                pullingIndicator.image = img
            } else {
                pullingIndicator.image = UIImage(named: "failure", in: Bundle(for: DefaultGTMRefreshHeader1.self), compatibleWith: nil)
            }
        }
    }
    func willCompleteEndRefershing() {
    }
}
class DefaultGTMLoadMoreFooter1: GTMLoadMoreFooter, SubGTMLoadMoreFooterProtocol {
    var pullUpToRefreshText: String = GTMRLocalize("pullUpToRefresh")
    public var loaddingText: String = GTMRLocalize("loadMore")
    public var noMoreDataText: String = GTMRLocalize("noMoreData")
    public var releaseLoadMoreText: String = GTMRLocalize("releaseLoadMore")
    var txtColor: UIColor? {
        didSet {
            if let color = txtColor {
                self.messageLabel.textColor = color
            }
        }
    }
    var idleImage: UIImage? {
        didSet {
            if let idleImg = idleImage {
                self.pullingIndicator.image = idleImg
            }
        }
    }
    lazy var pullingIndicator: UIImageView = {
        let pindicator = UIImageView()
        if let img = self.idleImage {
            pindicator.image = img
        } else {
            pindicator.image = UIImage(named: "arrow_down", in: Bundle(for: GTMLoadMoreFooter.self), compatibleWith: nil)
        }
        return pindicator
    }()
    lazy var loaddingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .gray
        indicator.backgroundColor = UIColor.white
        return indicator
    }()
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.messageLabel)
        self.contentView.addSubview(self.pullingIndicator)
        self.contentView.addSubview(self.loaddingIndicator)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard newSuperview != nil else {
            return
        }
        self.pullingIndicator.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi+0.000001))
    }
    // MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: frame.width * 0.5 - 70 - 30, y: frame.height * 0.5)
        pullingIndicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        pullingIndicator.mj_center = center
        loaddingIndicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        loaddingIndicator.mj_center = center
        messageLabel.frame = self.bounds
    }
    // MARK: SubGTMLoadMoreFooterProtocol
    /// 控件的高度
    ///
    /// - Returns: 控件的高度
    func contentHeith() -> CGFloat {
        return 50.0
    }
    func toNormalState() {
        pullingIndicator.isHidden = false
        self.loaddingIndicator.isHidden = true
        self.loaddingIndicator.stopAnimating()
        messageLabel.text =  self.pullUpToRefreshText
        UIView.animate(withDuration: 0.4, animations: {
            self.pullingIndicator.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi+0.000001))
        })
    }
    func toNoMoreDataState() {
        pullingIndicator.isHidden = true
        self.loaddingIndicator.isHidden = true
        self.loaddingIndicator.stopAnimating()
        messageLabel.text =  self.noMoreDataText
    }
    func toWillRefreshState() {
        messageLabel.text =  self.releaseLoadMoreText
        UIView.animate(withDuration: 0.4, animations: {
            self.pullingIndicator.transform = CGAffineTransform.identity
        })    }
    func toRefreshingState() {
        self.loaddingIndicator.isHidden = false
        self.loaddingIndicator.startAnimating()
        messageLabel.text =  self.loaddingText
    }
}
