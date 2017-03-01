## 第一天

### 1.准备工作(创建项目)

1>删除掉没用的文件
2>修改支持版本
3>导入图片
4>设置图标图片
5>设置启动动画(要把在 target 中的加载的启动视图故事板的名称删掉)
6>修改软件名称

### 2.搭建三级控制器(搭建项目整体的框架结构)

1>默认情况下我们创建的文件(视图控制器)都会放在同一个文件夹中,因为APP中需要创建很多视图控制器,Model,View等,如果放在一个文件夹中会很乱,所以我们会对它们通过文件夹分类

  演示: 1.首先直接在Xcode中创建文件夹,我们会发现在工程目录的文件夹中没有刚才创建的文件夹(这样创建只会创建简单的文件夹,我们创建的文件夹只是虚拟的,叫做分组) 2.在工程目录中直接创建文件夹,然后在xcode的中导入该文件夹(在xcode中只是通过文件夹的名称创建对应关系的分组,当修改分组的名字的时候,文件夹不会随着修改)
  
2>每一个视图控制器都有一些相同的元素,我们一个个添加比较麻烦,那我们该怎么办???我们可以创建一个基视图控制器,每一个视图控制器都继承于这个基视图控制器,我们只需修改这个基视图控制器其他视图控制器也具有这样的特性,并且其他的视图控制器也会出现这样的情况,所以我们可以先创建一个基文件夹,然后创建一个基视图控制器,一个基导航控制器

3>创建每一个界面的视图控制器(继承与我们创建的基视图控制器)
4>通过storyBoard的方式创建三级视图控制器,设置入口

### 3.自定义导航控制器
1>修改导航栏的背景图片:我们只需要修改BaseNavigationController的背景图片,其他的都是由这个类创建的对象,自然也会改变
2>修改状态栏(两步走): 1.首先在Plist文件中加入View controller-based status bar appearance,状态改为YES 2.复写- (UIStatusBarStyle)preferredStatusBarStyle这个方法
3>修改导航栏标题的字体颜色: 1.自定义 2.修改导航栏的样式 3.修改属性
另外一种思路:我们也可以在标签控制器中自定义导航控制器,我们首先需要获取标签控制器管理下的所有当前显示的导航栏类,对该类的对象进行自定义(参见代码)(只需要知道就可以)

### 4.自定义标签控制器( 1.移除系统自带的标签控制器的按钮 2.添加自定义的按钮)
==声明==:之前的将标签栏隐藏掉直接用自定义整个标签栏的做法仍然适用,但是我们为了多学一点知识,我将换一种方式来进行标签栏的自定义

1>移除系统自带的标签控制器的按钮
(1.在标签控制器中,首先看一下系统TabBar自带的子视图有哪些,打印一下 2.然后对这些子视图进行遍历,挑选出是UITabBarButton这个类的进行移除)
注意:最后运行的时候发现按钮并没有被移除掉,这是为什么?? 在三级控制器中, 按钮在标签控制器的didViewLoad中被移除,但是故事板没有全部加载完成,在加载导航控制器的时候,其他导航控制器添加修改标签名称的时候发现按钮没有了,又给自动加上了按钮,所以说我们移除按钮的时间需要调整一下,在视图将要显示的时候移除按钮.
重点理解: 1.为什么不能直接判断UITabBarButton这个类  2.为什么通过什么方式可以移除UITabBarButton类的按钮  3.为什么移除按钮的方法要写到视图将要出现的方法中

2>自定义按钮的样式
    (1).设置标签栏的背景颜色
    (2).因为要在标签栏上添加按钮,所以我们需要定义每个按钮的大小,每个按钮是根据屏幕的大小来确定的,所以我们需要定义屏幕的宏定义
    (3).按钮的创建有两种方式:
        第一种:直接创建按钮,修改frame,添加图片,标题,创建点击事件,最后通过调整边缘值来调整图片和标题的相对位置
        第二种:子类化一个UIControl的子类,在该类中添加图片和标题,然后创建一个一个的对象,作为标签栏的按钮(给按钮设置tag值)
    (4).点击按钮的背景动画:首先将这个背景视图设置为全局,在创建按钮之前创建出来该背景,设置大小,在创建第一个按钮的时候初始化该背景图片的位置,点击哪个按钮直接将背景图片的中心设置为点击按钮的中心
    

### 5.视图翻转
#### &&创建单独的项目演示:
1>下面视图控制器的View在翻转,导航栏上的按钮也是在翻转
2>首先创建一个新的项目来演示
3>动画都是骗人的,看起来像是一个View从正面翻转到背面,但是我们知道View的背面是不可能添加View的,我们只能一层一层的添加,那怎么办?其实这只是一个View的动画效果
4>首先我们创建一个全局的View,然后创建一个按钮,在按钮的点击事件中实现全局View的翻转动画,我们只能看到翻转看不到翻转内容的改变,那我们该怎么做呢?
5>接下来我们还可以再创建两个View放到全局的View的上面,在翻转的过程中改变两个View的隐藏状态,最终就实现了翻转改变内容的效果

#### &&项目中的实现:
1>首先设置导航栏上的==按钮==:(两种方案:1.Button上放置两个图片,修改两个图片的隐藏状态        
2.在一个View上添加两个按钮,修改两个按钮的隐藏状态--->选择这种方案)

(1).创建一个父视图(设置tag值),创建两个Button,并且将父视图添加成导航栏的右边项,将两个按钮设置背景和图片添加到父视图上,设置两个按钮的隐藏状态,设置两个按钮的tag值
(2).两个按钮设置为同一个点击事件,通过tag值获取到两个按钮,通过点击对父视图进行翻转,并且更改两个按钮的显示状态.
注意点: 基本功能实现以后,就要注意细节,翻转可以实现这样的效果,先向左翻转,然后向右翻转,可以通过判断来实现(也可以通过三目运算来实现)

2>然后实现视图控制器中View的翻转动画
(1).创建两个全局的视图(海报视图(UIView),列表视图(UITableView))
(2).在按钮的点击事件中,添加View翻转动画(注意细节)

## 第二天

### 1.json数据的认识

1>首先看一下json文件的样子
2>理解一下json文件的概念和用法: 看相关文件
3>打开json文件,看一下json文件的结构(技巧:双击括号,可以将括号内的内容全部选择出来)
结构分析:
(1).格式----->  名称:值
(2).值可以是,数字(不加双引号),字符串(加双引号),逻辑值,数组,字典,null
### 2.解析json数据

1>含义:将json格式的数据转换成Model数据的方式
2>json文件不能直接从json类型转化成对象类型,中间需要转化成二进制文件过渡一下,所以需要三步走:第一步,获取json文件的路径.第二部,将该路径下的json文件转化成二进制文件.第三部,用NSJSONSerialization的类方法,将二进制文件转化成对象

3>接下来,我们要将这一条条的数据,转化成model对象(具体需要参见代码)
    (1).创建model对象,将model对象中的每一个属性都编辑好
    (2).导入model类,然后分层将我们需要的数据取出来,创建多个Model对象,把对应的数据存放到我们的Model数据中
    (3).然后将我们创建的model对象存放到创建的全局可变数组中(记得初始化这个全局的可变数组)
4>这样的话我们可以通过利用这个全局的可变数组,可以找到每一个model对象和里面的数据

### 3.表视图单元格的定制

1>首先我们需要创建一个UITableViewCell类型的cell(自带Xib文件),然后进行xib文件的设置
2>在代码中修改cell的类型,还需要将XIB的注册方式修改为nib文件注册
3>修改在xib文件中修改Cell的ID值
4>然后我们可以在moviewCell中设置界面数据,其中图片的设置较为复杂,我们需要用到第三方框架UIImageView+WebCache.h (这个是重点)
5>最后我们发现tableview最底端滑不上来,这是因为tableView的高度不合适,需要重新设置一下

### 4.星星视图的创建

1>首先向同学们展示一下,星星视图显示的原理,用背景视图的方式来加载图片,这样会平铺图片
2>创建一个UIView,名字为星星视图的类,这个通过这个类可以创建出我们想要的星星视图
3>然后在这个视图当中我们创建我们需要创建的灰色星星视图和黄色星星视图(黄色星星的宽度和评分有关系,所以还需要定义一个评分的全局变量)(但是有一个问题:评分在init方法中还没有值,这样黄色视图显示不出来)
4>然后在xib文件中添加星星视图,设置该视图的类为StartView,然后连线到对应的视图
5>在星星视图中我们需要调用awakeFromNib的方法,在调用xib文件的时候自动调用这个方法,在这个方法中我们创建星星视图
6>我们还需要重写评分的set方法,在SET方法中对黄色视图的frame重新进行设置

7>设置星星的放大,首先计算星星的放大比例(starView的高度除以 每个星星的高度),然后开始放大星星视图,修改星星视图的起始点坐标
8>在黄星星视图比例SET方法中,重新调节黄星星视图的宽度,等于灰色视图乘以比例

9>修改一下细节: 去掉单元格点击选中效果
10>记录日志

## 第三天

### 1.UICollectionView (集合视图)
1>简单说明CollectionView的概念

2>创建colletionView的四个步骤: 创建布局对象,创建集合对象,设置数据源和代理并且实现方法,注册单元格并且创建单元格

3>完成布局对象的设置
(1).item的大小
(2).相对于滚动方向,行与行之间的最小间距(没一行的Item的大小可能不一样,但是两行最小的间距最小为30)
(3).相对于滚动方向,同一行每一个Item之间的最小间距()
(4).滚动方向

### 2. 将 UICollectionView集合到项目中
1>首先我们需要对界面的构成进行分析,我们中间的界面可以分为三部分,上面可以下拉的view,中间的collectionView,下面显示名称的label

2>我们可以将这三部分都放到一个View上,首先创建出一个单独的postView的类,然后在这个类中将我们需要三个视图创建出来

3>首先创建中间的集合视图
(1).四步走战略(子类化集合视图,子类化集合视图的Item)
(2).向集合视图传递数据(让海报图片显示出来)
(3).子类化布局对象,把布局的相关信息和功能都添加子类化中,并且还可以添加一下新的功能

4>首页中间UICollectionView的翻转效果
(1).实现翻转效果,我们要在点击单元格的事件中,实现翻转功能
(2).子类化一个翻转详情视图,创建xib
(3).在cell子类化中创建翻转详情视图视图
(4).在cell子类化中创建一个翻转视图的方法,在外面能访问到
(5).在UICollectionView的代理方法中,结束显示单元格的时候,让布局恢复到正面向上(这个需要给学生们讲一讲复用池的作用)

## 第四天
### 1.首页中间UICollectionView的放大缩小效果
1>将集合视图的布局对象子类化-->继承UICollectionViewFlowLayout这个类,然后将代码转移
### 2.首页中间UICollectionView的自动居中
1>上一节课简单的介绍了UICollectionView的缩放功能,接下来说一下UICollectionView的自动对齐功能
2>自动对齐功能有两种解决方式,一种是scrollView的代理方法,另一种是布局对象的方法,我们使用第二种
3>然后我们可以改变一下collectionView的滚动减速的速率

### 4.将collectionView抽离,创建一个基集合视图,将两个collectionView共有的特性放到这个基collectionView中,使得头部视图也可以使用
1>创建一个基collectionView类和基collectionFlowLayout类
2>把一些共同用到的属性和方法在在这两个类中实现中实现: 间隔 横向滑动 自动居中
3>然后创建大滑动视图和小滑动视图(继承于上面创建的基类)

##第五天

1.设置postView上面的滑动头视图
1>首先设置滑动视图的collectionView:初始化方法,注册单元格,数据源最后一个方法,偏移量
2>然后设置 collectionView的布局类
3>在postView的方法中创建头视图(UIImageView),button(包括按钮的点击事件),小的集合视图

2.设置头视图和中间视图的同步滑动(KVO)
1>在将要结束拖拽的方法中,计算出当前最终要停留在第几个页面,并且将这个属性设置为集合视图的属性,同理在小的集合视图中做同样的操作(注意当前位置的计算)
2>两个UICollectionView同步滑动,实现这样的效果,核心就是 相互监控,互相监控对方显示图片的索引值,只要对方的索引值一改变,自己就会滚动到对方索引值的位置,这样很容易想到KVO传值的方法
3>但是在KVO方法中,被监控的对象必须是原对象(不可以是新建的对象),所以在两个View中很难获得对方的原对象,这样我们可以可以想到一个办法,就是----- 找到一个第三者,因为他们都放在同一个视图上,在这个视图上可以监控两个collectionView,只要有一个发生变化,这个视图就会监控到,然后改变另一个collectionView的位置(在这个视图上是可以获得原collectionView对象的),所以我们可以在第三者中实现这个方法,能实现同步滑动
4>注意:1.如果滑动小的集合视图,就是滑动大的,并且修改大的当前值(如果不判断每次滑动的值都改变,则会不挺的触发kvo造成野指针错误),判断的话,可以阻止下一次的索引值更新
2.如果滑动大的集合视图,就是滑动小的,并且修改小的当前值(如果不判断每次滑动的值都改变,则会不挺的触发kvo造成野指针错误),判断的话,可以阻止下一次的索引值更新
3.更新底部名字
1>初始化下面的名称
2>在kvo的观察方法中进行名称的更新

##第六天

1.添加遮罩视图
2.添加手势
3.将高级的手势内容讲解一下

##第七天(新闻界面)

1.创建model类,并且加载数据
2.创建表视图(在storyboard中直接拖动),然后配置表视图
3.创建单元格的cell(添加xib)
4.将json文件的转换方法封装一下
5.用KVC的方式给model赋值,并且增加纠错功能
6.给cell实现基本的界面(xib)
7.头视图放大的效果

##第八天(新闻界面点击界面(网页和图片展示))

1.web界面搭建
1>简单的介绍一下web页面的加载(具体参加相关的备课代码)
2.图片界面的搭建
1>首先创建图片详情的视图控制器,里面是集合视图
2>然后点击集合视图的每一个cell的,会模态出一个视图控制器,在这个视图控制器中添加一个collectionView
3>在collectionView的Cell上面是一个scrollView,在scrollView中是对应的图片

##第九天(top界面)

1.创建model类并且添加属性,创建UICollectionviewCell类
2.加载数据,创建集合视图,创建相关的Cell
3.完善点击Cell的事件
4.在Cell的点击事件中跳转到下一个视图控制器,在这个视图控制器中添加一个表视图,然后再给表视图设置头视图

##第十天(更多界面,引导界面和启动动画)

更多界面:
1.在storyBoard中将最后一个更多界面搭建成功,如果需要在storyBoard中添加静态单元格,需要将当前的控制器修改为表视图控制器UITableViewController
2.设置静态单元格(高度,里面的布局,图片)
3.在点击cell单元格的方法中,添加点击第一个单元格,弹出警告框,点击确定进行缓存清理
4.在单元格将要显示的时候刷新缓存大小(需要给对应cell上的Label设置tag值)
5.在视图将要出现的代理方法中,还有点击清除缓存的按钮中刷新表视图
6.讲解一下沙盒路径的相关知识(参见代码)

引导界面和启动动画
1.首先创建一个导向视图控制器,在这里面创建一个滑动视图
2.然后创建一个控制器,在这个控制器中实现启动的动画
3.在APPDelegeta中进行判断,是否是首次打开应用,如果是首次打开应用,首先将导向控制器设置为当前window的根视图控制器,然后点击@开始旅行按钮再将window的根视图控制器设置为启动动画的视图控制器,如果不是首次直接将启动动画控制器设置为window的根视图控制器

4.最后讲解一下内存警告的相关事项
