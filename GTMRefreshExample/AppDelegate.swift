 import UIKit
 @UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var nav : Nav?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        nav = Nav()
        self.window!.rootViewController = nav
        self.window?.makeKeyAndVisible()
        return true
    }
 }
 class Nav: UINavigationController {
    var count = 0
    var label : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.pushViewController(Page1(), animated: true)
    }
 }
 import GTMRefresh
 class Page1: UITableViewController {
    let rowsTitles =  ["1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.gtm_addRefreshHeaderView(DefaultGTMRefreshHeader1()) {
            [weak self] in
            print("execute refreshBlock")
            self?.refresh()
        }
        self.tableView.gtm_addLoadMoreFooterView() {
            [weak self] in
            print("execute loadMoreBlock")
            self?.loadMore()
        }
    }
 }
 extension Page1{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsTitles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = rowsTitles[indexPath.row]
        return cell!
    }
 }
 extension Page1{
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
 }
