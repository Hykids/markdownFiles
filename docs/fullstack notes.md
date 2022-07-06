# Node.js后端

### **nodemon**

如果我们对应用的代码做了修改，我们必须重新启动应用，以便看到这些修改。我们重启应用的方法是：首先通过输入\*Ctrl+C\*来关闭它，然后再重启应用。

与React中方便的工作流程相比，即浏览器在发生变化后自动重新加载，这感觉有点麻烦。解决这个问题的方法是[nodemon](https://github.com/remy/nodemon)。

\*nodemon将观察nodemon启动时所在目录中的文件，如果有任何文件发生变化，nodemon将自动重启你的node应用。

```bash
npm install --save-dev nodemon

# 在任意目录执行该命令都可以
# 也就是说，所有需要 --global安装的包都可以再任意目录执行
npm install --global nodemon
```

安装完毕后，使用：

```
node app.js 

# 使用nodemon
nodemon app.js
```

![image-20220621131926015](C:\Users\25874\AppData\Roaming\Typora\typora-user-images\image-20220621131926015.png)

### 目录结构

```bash
├── index.js
├── app.js
├── build
│   └── ...
├── controllers
│   └── notes.js//路由处理
├── models
│   └── note.js
├── package-lock.json
├── package.json
├── utils
│   ├── config.js//处理环境变量
│   ├── logger.js//控制台打印输出
│   └── middleware.js
```

#### 路由器对象到底是什么

一个路由器对象是一个孤立的中间件和路由实例。你可以把它看作是一个 "小型应用"，只能够执行中间件和路由功能。每个Express应用都有一个内置的应用路由器。

路由器实际上是一个**中间件**，它可以用来在一个地方定义 "相关的路由"，它通常被放在自己的模块中。

```javascript
const notesRouter = require('express').Router()

//...

module.exports = notesRouter
```



### HTTP 请求类型

[HTTP标准](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html)谈到了与请求类型有关的两个属性：**安全**和**幂等**。

安全意味着执行的请求不能在服务器中引起任何*副作用*。我们所说的副作用是指数据库的状态<u>不能因为请求而改变</u>，而且响应必须只返回服务器上已经存在的数据。

#### 安全方法

实施者应该意识到该软件代表了用户在互联网上的交互，并且应该小心让用户意识到他们可能采取的任何可能对他们自己或他人产生意想不到的意义的行动。

特别是，已经建立了约定，即 GET 和 HEAD 方法不应该具有采取除检索之外的操作的意义。这些方法应该被认为是“安全的”。这允许用户代理以特殊的方式表示其他方法，例如 POST、PUT 和 DELETE，以便用户意识到正在请求可能不安全的操作。

当然，不可能确保服务器不会因为执行 GET 请求而产生副作用；事实上，一些动态资源认为这是一个特性。这里的重要区别是用户没有请求副作用，因此不能对它们负责。

#### 幂等方法

方法还可以具有“幂等性”的属性，因为（除了错误或过期问题）N > 0 个相同请求的副作用与单个请求相同。GET、HEAD、PUT 和 DELETE 方法共享此属性。此外，方法 OPTIONS 和 TRACE 不应该有副作用，因此本质上是幂等的。

但是，一个由多个请求组成的序列可能是非幂等的，即使在该序列中执行的所有方法都是幂等的。（如果整个序列的单次执行总是产生不会因重新执行该序列的全部或部分而改变的结果，则序列是幂等的。）例如，如果序列的结果取决于稍后按相同顺序修改的值。

根据定义，从不产生副作用的序列是幂等的（前提是没有在同一组资源上执行并发操作）。

POST是唯一的HTTP请求类型，既不*安全*也不*幂等*。如果我们向*/api/notes*发送5个不同的HTTP POST请求，其正文为*{content:"many same", important: true}*，服务器上产生的5个笔记都会有相同的内容。

### CORS

*跨源资源共享（Cross-origin resource sharing）是一种机制，它允许网页上的限制性资源（如字体）从第一个资源所来自的域之外的另一个域被请求。一个网页可以自由嵌入跨源图像、样式表、脚本、iframe和视频。某些 "跨域 "请求，特别是Ajax请求，在默认情况下是被同源安全策略所禁止的。*

在我们的环境中，问题在于，默认情况下，在浏览器中运行的应用的JavaScript代码只能与同一<u>来源</u>（如果两个 URL 的 [protocol](https://developer.mozilla.org/zh-CN/docs/Glossary/Protocol)、[port (en-US)](https://developer.mozilla.org/en-US/docs/Glossary/Port) (如果有指定的话) 和 [host](https://developer.mozilla.org/zh-CN/docs/Glossary/Host) 都相同的话，则这两个 URL 是*同源*）的服务器通信。

- 跨域的原理

  **跨域**，是指浏览器不能执行其他网站的脚本。它是由浏览器的`同源策略`造成的。
  **同源策略**,是浏览器对 JavaScript 实施的安全限制，只要`协议、域名、端口`有任何一个不同，都被当作是不同的域。
  **跨域原理**，即是通过各种方式，`避开浏览器的安全限制`。

- 解决方案

  最初做项目的时候，使用的是jsonp，但存在一些问题，使用get请求不安全，携带数据较小，后来也用过iframe，但只有主域相同才行，也是存在些问题，后来通过了解和学习发现使用代理和proxy代理配合起来使用比较方便，就引导后台按这种方式做下服务器配置，在开发中使用proxy，在服务器上使用nginx代理，这样开发过程中彼此都方便，效率也高；现在h5新特性还有 windows.postMessage()

  - **JSONP**：
    ajax 请求受同源策略影响，不允许进行跨域请求，而 script 标签 src 属性中的链 接却可以访问跨域的 js 脚本，利用这个特性，服务端不再返回 JSON 格式的数据，而是 返回一段调用某个函数的 js 代码，在 src 中进行了调用，这样实现了跨域。

    步骤：

    1. 去创建一个script标签
    2. script的src属性设置接口地址
    3. 接口参数，必须要带一个自定义函数名，要不然后台无法返回数据
    4. 通过定义函数名去接受返回的数据

因为我们的服务器在localhost 3001端口，而我们的前端在localhost 3000端口，它们没有相同的起源。请记住，[同源策略](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy)和 CORS 并不是专门针对 React 或 Node。它们实际上是网络应用操作的普遍原则。我们可以通过使用 Node's [cors](https://github.com/expressjs/cors) 中间件来允许来自其他\*原点\*的请求。在你的后端仓库中，用命令安装\*cors\*。

```bash
npm install cors
```

并允许来自所有源的请求

```js
const cors = require('cors')

app.use(cors())
```

https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS



# react前端

创建react app

```
npx create-react-app my-app
cd my-app
npm start
```

### Rudex

[Redux](https://redux.js.org/)库，安装命令如下：

```bash
npm install redux
```

Reducer不应该从应用代码中直接调用。还原器只是作为创建存储的*createStore*函数的一个参数。

```js
import { createStore } from 'redux'

const counterReducer = (state = 0, action) => {
  // ...
}

const store = createStore(counterReducer)
```

一个还原器的状态必须由[immutable](https://en.wikipedia.org/wiki/Immutable_object)(unchangeable object)对象组成。如果状态有变化，旧的对象不会被改变，但它会被一个新的、改变了的对象所取代。这正是我们对新的还原器所做的：旧的数组被新的数组所取代。

存储器现在使用还原器来处理*操作*，这些操作被*分派*或"发送"到存储器的[dispatch](https://redux.js.org/api/store#dispatchaction)-方法。

```js
store.dispatch({type: 'INCREMENT'})
```

```js
import React from 'react'
import ReactDOM from 'react-dom/client'

import { createStore } from 'redux'

const counterReducer = (state = 0, action) => {
  switch (action.type) {
    case 'INCREMENT':
      return state + 1
    case 'DECREMENT':
      return state - 1
    case 'ZERO':
      return 0
    default:
      return state
  }
}

const store = createStore(counterReducer)

const App = () => {
  return (
    <div>
      <div>
        {store.getState()}
      </div>
      <button
        onClick={e => store.dispatch({ type: 'INCREMENT' })}
      >
        plus
      </button>
      <button
        onClick={e => store.dispatch({ type: 'DECREMENT' })}
      >
        minus
      </button>
      <button
        onClick={e => store.dispatch({ type: 'ZERO' })}
      >
        zero
      </button>
    </div>
  )
}

const renderApp = () => {
  ReactDOM.createRoot(document.getElementById('root')).render(<App />)
}

renderApp()//调用方法
store.subscribe(renderApp)//监听变化
```

当商店里的状态改变时，React不能自动重新渲染应用。因此，我们注册了一个函数*renderApp*，它渲染了整个应用，用*store.subscribe*方法来监听商店的变化。请注意，我们必须立即调用*renderApp*方法。没有这个调用，应用的第一次渲染就不会发生。

### Reducer

Store 收到 Action 以后，必须给出一个新的 State，这样 View 才会发生变化。这种 State 的计算过程就叫做 Reducer。

Reducer 是一个函数，它接受 Action 和当前 State 作为参数，返回一个新的 State。

```javascript
const reducer = function (state, action) {
  // ...
  return new_state;
}
```

实际应用中，Reducer 函数不用像上面这样手动调用，`store.dispatch`方法会触发 Reducer 的自动执行。为此，Store 需要知道 Reducer 函数，做法就是在生成 Store 的时候，将 Reducer 传入`createStore`方法。





# 常用命令

### 结束进程

```
netstat -aon|findstr 端口号

TASKKILL /F /PID 进程号
```

