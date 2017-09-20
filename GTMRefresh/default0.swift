import UIKit
class DefaultGTMRefreshHeader: GTMRefreshHeader, SubGTMRefreshHeaderProtocol {
    var pullDownToRefresh = GTMRLocalize("pullDownToRefresh")
    var releaseToRefresh = GTMRLocalize("releaseToRefresh")
    var refreshSuccess = GTMRLocalize("refreshSuccess")
    var refreshFailure = GTMRLocalize("refreshFailure")
    var refreshing = GTMRLocalize("refreshing")
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
        self.contentView.addSubview(self.loaddingIndicator)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: frame.width * 0.5 - 70 - 20, y: frame.height * 0.5)
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
        self.loaddingIndicator.stopAnimating()
        messageLabel.text =  self.pullDownToRefresh
    }
    func toRefreshingState() {
        self.loaddingIndicator.isHidden = false
        self.loaddingIndicator.startAnimating()
        messageLabel.text = self.refreshing
    }
    func toPullingState() {
        self.loaddingIndicator.isHidden = true
        messageLabel.text = self.pullDownToRefresh
    }
    func toWillRefreshState() {
        messageLabel.text = self.releaseToRefresh
        self.loaddingIndicator.isHidden = true
    }
    func changePullingPercent(percent: CGFloat) {
        // here do nothing
    }
    func willBeginEndRefershing(isSuccess: Bool) {
        self.loaddingIndicator.isHidden = true
        if isSuccess {
            messageLabel.text =  self.refreshSuccess
        } else {
            messageLabel.text =  self.refreshFailure
        }
    }
    func willCompleteEndRefershing() {
    }
}
class DefaultGTMLoadMoreFooter: GTMLoadMoreFooter, SubGTMLoadMoreFooterProtocol {
    var pullUpToRefreshText: String = GTMRLocalize("pullUpToRefresh")
    public var loaddingText: String = GTMRLocalize("loadMore")
    public var noMoreDataText: String = GTMRLocalize("noMoreData")
    public var releaseLoadMoreText: String = GTMRLocalize("releaseLoadMore")
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
    }
    // MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: frame.width * 0.5 - 70 - 30, y: frame.height * 0.5)
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
        self.loaddingIndicator.isHidden = true
        self.loaddingIndicator.stopAnimating()
        messageLabel.text =  self.pullUpToRefreshText
    }
    func toNoMoreDataState() {
        self.loaddingIndicator.isHidden = true
        self.loaddingIndicator.stopAnimating()
        messageLabel.text =  self.noMoreDataText
    }
    func toWillRefreshState() {
        messageLabel.text =  self.releaseLoadMoreText
    }
    func toRefreshingState() {
        self.loaddingIndicator.isHidden = false
        self.loaddingIndicator.startAnimating()
        messageLabel.text =  self.loaddingText
    }
}
