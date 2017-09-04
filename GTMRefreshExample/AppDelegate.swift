 import UIKit
 @UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let page = Page1()
        self.window!.rootViewController = page
        self.window?.makeKeyAndVisible()
        return true
    }
 }
 import GTMRefresh
 
 class Page1: UITableViewController {
    
    var models = [SectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let section0 = SectionModel(rowsCount: 4,
                                    sectionTitle:"Default",
                                    rowsTitles: ["Tableview","CollectionView","ScrollView","WebView"],
                                    rowsTargetControlerNames:["DefaultTableViewController","DefaultCollectionViewController","DefaultScrollViewController","DefaultWebViewController"])
        
        
        let section1 = SectionModel(rowsCount: 7,
                                    sectionTitle:"Customize",
                                    rowsTitles: ["QQ","YahooWeather","Curve Mask","Youku","TaoBao","QQ Video","DianPing"],
                                    rowsTargetControlerNames:["QQStyleHeaderViewController","YahooWeatherTableViewController","CurveMaskTableViewController","YoukuTableViewController","TaobaoTableViewController","QQVideoTableviewController","DianpingTableviewController"])
        models.append(section0)
        models.append(section1)
        
        self.tableView.gtm_addRefreshHeaderView {
            [weak self] in
            print("excute refreshBlock")
            self?.refresh()
        }
        
        self.tableView.gtm_addLoadMoreFooterView {
            [weak self] in
            print("excute loadMoreBlock")
            self?.loadMore()
        }
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        // text
        self.tableView.pullDownToRefreshText("下拉刷新")
            .releaseToRefreshText("松开刷新")
            .refreshSuccessText("刷新成功")
            .refreshFailureText("刷新失败")
            .refreshingText("刷新中")
        // color
        self.tableView.headerTextColor(.red)
        // icon
        self.tableView.headerIdleImage(UIImage.init(named: "dropdown_anim__00048"))
        self.tableView.pullUpToRefreshText("上拉装入").loaddingText("装入中...").noMoreDataText("没有更多数据").releaseLoadMoreText("松开则装入")
        self.tableView.footerIdleImage(UIImage.init(named: "dropdown_anim__00048"))
        
    }
    func refresh() {
        perform(#selector(endRefresing), with: nil, afterDelay: 3)
    }
    
    func endRefresing() {
        self.tableView.endRefreshing(isSuccess: true)
    }
    func loadMore() {
        perform(#selector(endLoadMore), with: nil, afterDelay: 3)
    }
    
    func endLoadMore() {
        self.tableView.endLoadMore(isNoMoreData: true)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionModel = models[section]
        return sectionModel.sectionTitle
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = models[section]
        return sectionModel.rowsCount
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            
        }
        let sectionModel = models[(indexPath as NSIndexPath).section]
        cell?.textLabel?.text = sectionModel.rowsTitles[(indexPath as NSIndexPath).row]
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionModel = models[(indexPath as NSIndexPath).section]
        var className = sectionModel.rowsTargetControlerNames[(indexPath as NSIndexPath).row]
        className = "GTMRefreshExample.\(className)"
        if let cls = NSClassFromString(className) as? UIViewController.Type{
            let dvc = cls.init()
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
 }
 
