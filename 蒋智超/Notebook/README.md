# Notebook实现原理
抽象一个`JZCBaseTableViewController`,定义基本的数据展示，删除，和与`JZCDetailViewController` 的交互，  
其他的`Lists`，`Collections`，`SearchResults`均继承`JZCBaseTableViewController`，不同之处重写父类的方法
