# React Hooks

*Hook* 是 React 16.8 的新增特性。

React 的核心是组件。v16.8 版本之前，组件的标准写法是类（class）。

React 团队希望，组件不要变成复杂的容器，最好只是数据流的管道。开发者根据需要，组合管道即可。 **组件的最佳写法应该是函数，而不是类。**

## 类和函数的差异

**类（class）是数据和逻辑的封装。** 也就是说，组件的状态和操作方法是封装在一起的。如果选择了类的写法，就应该把相关的数据和操作，都写在同一个 class 里面。

**函数一般来说，只应该做一件事，就是返回一个值。** 如果你有多个操作，每个操作应该写成一个单独的函数。而且，数据的状态应该与操作方法分离。根据这种理念，React 的函数组件只应该做一件事情：返回组件的 HTML 代码，而没有其他的功能。只进行单纯的数据计算（换算）的函数，在函数式编程里面称为 **"纯函数"**（pure function）。

## Hook 的含义：

React Hooks 的意思是，组件尽量写成纯函数，如果需要外部功能和副作用，就用钩子来为函数组件引入副效应。**

**Hook 使你在无需修改组件结构的情况下复用状态逻辑。

以下为常用钩子：

## useEffect()：副作用钩子

函数组件的主体只应该用来返回组件的 HTML 代码，所有的其他操作（副效应）都必须通过钩子引入。

发送网络请求，手动变更 DOM，记录日志，这些都是常见的无需清除的操作。因为我们在执行完这些操作之后，就可以忽略他们了。

```jsx
 useEffect(() => {
        const fetchPosts = async () => {
            const res = await axios.post("/posts")
            console.log(res)
        }
        fetchPosts()
    }, [])
```



## useContext()：共享状态钩子

如果需要在组件之间共享状态，可以使用`useContext()`。

在设置用户登录功能时，需要保存用户登录状态，并且将状态共享给子组件。

```
export const Context = createContext(INITIAL_STATE)
```

第一步就是使用 React Context API，在组件外部建立一个 Context。

```jsx
 <Context.Provider value={{
            user: state.user,//共享属性
            dispatch
        }}>
            {children}
</Context.Provider>
```

==Context.Provider==提供了一个 Context 对象，这个对象可以被子组件共享。

Login页面中，useContext钩子用来Context对象并从中获取user,dispatch属性。

```
const { dispatch,user } = useContext(Context)
```

## useReducer()：action 钩子

React 本身不提供状态管理功能，通常需要使用外部库。这方面最常用的库是 Redux。

Redux 的核心概念是，组件发出 action 与状态管理器通信。状态管理器收到 action 以后，使用 Reducer 函数算出新的状态。存储器中的状态不是直接改变的，而是通过不同的*动作*改变的。

![img](https://facebook.github.io/flux/img/overview/flux-simple-f8-diagram-with-client-action-1300w.png)

动作对应用状态的影响是用一个[reducer](https://redux.js.org/basics/reducers)来定义的。在实践中，reducer是一个函数，它被赋予当前状态和一个动作作为参数。它*返回*一个新的状态。

```javascript
**const** [state, dispatch] = useReducer(Reducer, INITIAL_STATE)
```

`useReducers()`钩子用来引入 Reducer 功能。Reducer定义如下：

```javascript
const Reducer = (state, actions) => {
  switch (action.type) {
    case 'INCREMENT'://决定行动的类型。
      return state + 1
    case 'DECREMENT':
      return state - 1
    case 'ZERO':
      return 0
    default: 
      return state
  }
}
```

## 参考连接

https://www.ruanyifeng.com/blog/2020/09/react-hooks-useeffect-tutorial.html

https://www.ruanyifeng.com/blog/2019/09/react-hooks.html

https://zh-hans.reactjs.org/docs/hooks-state.html

