# CSS3

## CSS 选择器及优先级

- id选择器(#myid)
- 类选择器(.myclass)
- 属性选择器(a[rel="external"])
- 伪类选择器(a:hover, li:nth-child)
- 标签选择器(div, h1,p)
- 相邻选择器（h1 + p）
- 子选择器(ul > li)
- 后代选择器(li a)
- 通配符选择器(*)

优先级：

- `!important`
- 内联样式（1000）
- ID选择器（0100）
- 类选择器/属性选择器/伪类选择器（0010）
- 元素选择器/伪元素选择器（0001）
- 关系选择器/通配符选择器（0000）

带!important 标记的样式属性优先级最高； 样式表的来源相同时：`!important > 行内样式>ID选择器 > 类选择器 > 标签 > 通配符 > 继承 > 浏览器默认属性`

## position

- **固定定位 fixed**： 元素的位置相对于浏览器窗口是固定位置，即使窗口是滚动的它也不会移动。Fixed 定 位使元素的位置与文档流无关，因此不占据空间。 Fixed 定位的元素和其他元素重叠。它如果搭配`top`、`bottom`、`left`、`right`这四个属性一起使用，表示元素的初始位置是基于视口计算的，否则初始位置就是元素的默认位置。

  ![img](D:\Desktop\Aldur\markdownFiles\image\CSS3\bg2019111802.jpg)

- **相对定位 relative**： 如果对一个元素进行相对定位，它将出现在它所在的位置上。相对于默认位置（即`static`时的位置）进行偏移，它必须搭配`top`、`bottom`、`left`、`right`这四个属性一起使用，用来指定偏移的方向和距离。

  ![img](D:\Desktop\Aldur\markdownFiles\image\CSS3\bg2019111721.jpg)

- **绝对定位 absolute**： 相对于上级元素（一般是父元素）进行偏移，即定位基点是父元素，如果元素没有已定位的父元素，那 么它的位置相对于。absolute 定位使元素的位置与文档流无关，因此不占据空间。 absolute 定位的元素和其他元素重叠。定位基点（一般是父元素）不能是`static`定位，否则定位基点就会变成整个网页的根元素`html`。另外，`absolute`定位也必须搭配`top`、`bottom`、`left`、`right`这四个属性一起使用。

  ![img](D:\Desktop\Aldur\markdownFiles\image\CSS3\bg2019111801.jpg)

- **粘性定位 sticky**： 元素先按照普通文档流定位，然后相对于该元素在流中的 flow root（BFC）和 containing block（最近的块级祖先元素）定位。而后，元素定位表现为在跨越特定阈值前为相对定 位，之后为固定定位。

- **默认定位 Static**： 默认值。如果省略`position`属性，浏览器就认为该元素是`static`定位。元素出现在正常的流中（忽略 top, bottom, left, right 或者 z-index 声 明）。 inherit: 规定应该从父元素继承 position 属性的值。注意，`static`定位所导致的元素位置，是浏览器自主决定的，所以这时`top`、`bottom`、`left`、`right`这四个属性无效。

## 元素水平垂直居中

- **水平居中**

  - 对于 行内元素 : `text-align: center`;

  - 对于确定宽度的块级元素：

    （1）width和margin实现。`margin: 0 auto`;

    （2）绝对定位和margin-left: -width/2, 前提是父元素position: relative

  - 对于宽度未知的块级元素

    （1）`table标签配合margin左右auto实现水平居中`。使用table标签（或直接将块级元素设值为 display:table），再通过给该标签添加左右margin为auto。

    （2）inline-block实现水平居中方法。display：inline-block和text-align:center实现水平居中。

    （3）`绝对定位+transform`，translateX可以移动本身元素的50%。

    （4）flex布局使用`justify-content:center`

- **垂直居中**

  1. 利用 `line-height` 实现居中，这种方法适合纯文字类
  2. 通过设置父容器 相对定位 ，子级设置 `绝对定位`，标签通过margin实现自适应居中
  3. 弹性布局 flex :父级设置display: flex; 子级设置margin为auto实现自适应居中
  4. 父级设置相对定位，子级设置绝对定位，并且通过位移 transform 实现
  5. `table 布局`，父级通过转换成表格形式，`然后子级设置 vertical-align 实现`。（需要注意的是：vertical-align: middle使用的前提条件是内联元素以及display值为table-cell的元素）

## 隐藏页面中某个元素的方法

1.`opacity：0`，该元素隐藏起来了，但不会改变页面布局，并且，如果该元素已经绑定 一些事件，如click 事件，那么点击该区域，也能触发点击事件的

2.`visibility：hidden`，该元素隐藏起来了，但不会改变页面布局，但是不会触发该元素已 经绑定的事件 ，隐藏对应元素，在文档布局中仍保留原来的空间（重绘）

3.`display：none`，把元素隐藏起来，并且会改变页面布局，可以理解成在页面中把该元素。 不显示对应的元素，在文档布局中不再分配空间（回流+重绘）

## 页面布局：flex

设置或检索弹性盒模型对象的子元素如何分配空间。用在<u>子容器</u>上

flex-flow：<' flex-direction '> || <' flex-wrap '>

`<' flex-direction '>：` `定义弹性盒子元素的排列方向。 `flex-direction：row | row-reverse | column | column-reverse`

- row：主轴与行内轴方向作为默认的书写模式。即横向从左到右排列（左对齐）。
- row-reverse：对齐方式与row相反。
- column：主轴与块轴方向作为默认的书写模式。即纵向从上往下排列（顶对齐）。
- column-reverse：对齐方式与column相反。

<' flex-wrap '>控制flex容器是单行或者多行.`flex-wrap：nowrap | wrap | wrap-reverse`

- nowrap：flex容器为单行。该情况下flex子项可能会溢出容器
- wrap：flex容器为多行。该情况下flex子项溢出的部分会被放置到新行，子项内部会发生断行
- wrap-reverse：反转 wrap 排列。

#### justify-content

设置或检索弹性盒子元素在<u>主轴（横轴）</u>方向上的定位方式。

- flex-start（默认值）：左对齐
- flex-end：右对齐
- center： 居中
- space-between：两端对齐，项目之间的间隔都相等。
- space-around：每个子元素两侧的间隔相等。所以，子元素之间的间隔比子元素与边框的间隔大一倍

#### align-content

调整伸缩子元素在<u>侧轴(纵轴)</u>上的定位方式，如果子元素只有一根轴线，该属性不起作用。

- flex-start：与交叉轴的起点对齐。
- flex-end：与交叉轴的终点对齐。
- center：与交叉轴的中点对齐。
- space-between：与交叉轴两端对齐，轴线之间的间隔平均分布。
- space-around：每根轴线两侧的间隔都相等。所以，轴线之间的间隔比轴线与边框的间隔大一倍。
- stretch（默认值）：轴线占满整个交叉轴。

#### align-items

定义flex子项在flex容器的当前行的侧轴（纵轴）方向上的定位方式。

##### 语法：

```
align-items：flex-start | flex-end | center | baseline | stretch
```

- flex-start：交叉轴的起点对齐。
- flex-end：交叉轴的终点对齐。
- center：交叉轴的中点对齐。
- baseline: 项目的第一行文字的基线对齐。
- stretch（默认值）：如果项目未设置高度或设为auto，将占满整个容器的高度。

#### align-self

定义flex子项单独在侧轴（纵轴）方向上的对齐方式。align-self属性允许单个项目有与其他项目不一样的对齐方式，可覆盖align-items属性。默认值为auto，表示继承父元素的align-items属性，如果没有父元素，则等同于stretch。

##### 语法：

```
align-self：auto | flex-start | flex-end | center | baseline | stretch
```

## 浮动布局

浮动布局:当元素浮动以后可以向左或向右移动，直到它的外边缘碰到包含它的框或者另外一个浮动元素的边框为止。元素浮动以后会脱离正常的文档流，所以文档的普通流中的框就变的好像浮动元素不存在一样。

**优点**

这样做的优点就是在图文混排的时候可以很好的使文字环绕在图片周围。另外当元素浮动了起来之后，它有着块级元素的一些性质例如可以设置宽高等，但它与inline-block还是有一些区别的，第一个就是关于横向排序的时候，float可以设置方向而inline-block方向是固定的；还有一个就是inline-block在使用时有时会有空白间隙的问题

**缺点**

最明显的缺点就是浮动元素一旦脱离了文档流，就无法撑起父元素，`会造成父级元素高度塌陷`。

### 清除浮动的方式

- 添加额外标签

```css
<div class="parent">
//添加额外标签并且添加clear属性
<div style="clear:both"></div>
//也可以加一个br标签
</div>
```

- 父级添加overflow属性，或者设置高度
- 建立伪类选择器清除浮动

```css
//在css中添加:after伪元素
.parent:after{
    /* 设置添加子元素的内容是空 */
    content: '';
    /* 设置添加子元素为块级元素 */
    display: block;
    /* 设置添加的子元素的高度0 */
    height: 0;
    /* 设置添加子元素看不见 */
    isibility: hidden;
    /* 设置clear：both */
    clear: both;
}
```

## Rem 布局

首先 Rem 相对于根(html)的 font-size 大小来计算。简单的说它就是一个相对单例 如:font-size:10px;,那么（1rem = 10px）了解计算原理后首先解决怎么在不同设备上设置 html 的 font-size 大小。其实 rem 布局的本质是等比缩放，一般是基于宽度。

### **优点**：

可以快速适用移动端布局，字体，图片高度

### **缺点**：

①目前 ie 不支持，对 pc 页面来讲使用次数不多；
②数据量大：所有的图片，盒子都需要我们去给一个准确的值；才能保证不同机型的适配；
③在响应式布局中，必须通过 js 来动态控制根元素 font-size 的大小。也就是说 css 样式和 js 代码有一定的耦合性。且必须将改变 font-size 的代码放在 css 样式之前。

## 百分比布局

通过百分比单位 " % " 来实现响应式的效果。通过百分比单位可以使得浏览器中的组件的宽和高随着浏览器的变化而变化，从而实现响应式的效果。 直观的理解，我们可能会认为子元素的百分比完全相对于直接父元素，height 百分比相 对于 height，width 百分比相对于 width。 padding、border、margin 等等不论是垂直方向还是水平方向，都相对于直接父元素的 width。 除了 border-radius 外，还有比如 translate、background-size 等都是相对于自身的。

**缺点**：

（1）计算困难
（2）各个属性中如果使用百分比，相对父元素的属性并不是唯一的。造成我们使用百分比单位容易使布局问题变得复杂。

## 参考网站：

[CSS3新特性，兼容性，兼容方法总结 - Jesse131 - 博客园 (cnblogs.com)](https://www.cnblogs.com/jesse131/p/5441199.html)

[前端必备八股文 - 丹青-水墨 - 博客园 (cnblogs.com)](https://www.cnblogs.com/tccg/p/15248664.html)

[CSS 定位详解 - 阮一峰的网络日志 (ruanyifeng.com)](https://www.ruanyifeng.com/blog/2019/11/css-position.html)