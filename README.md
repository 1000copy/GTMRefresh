<p align="center">
<a href="https://github.com/GTMYang/GTMRefresh"><img src="https://raw.githubusercontent.com/GTMYang/GTMRefresh/master/logo.png"></a>
</p>

GTMRefresh
===================
`GTMRefresh` 用Swift重写的MJRefresh

# Introduction

- 自定义方便
- 代码简洁
- 支持: UITableView, UICollectionView, UIScrollView, UIWebView 


# Demo
使用默认的下拉和上拉效果
```swift
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

```

#开源协议
本项目遵循 MIT 协议开源，具体请查看根目录下的 [LICENSE](https://raw.githubusercontent.com/GTMYang/GTMRefresh/master/LICENSE) 文件。


