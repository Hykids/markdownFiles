# MongoDB

是面向文档的<u>非关系型</u>(NoSQL类型)数据库，数据结构未键值对组成；文档的键（key）值(value)不再是固定的类型与大小。而关系型数据库中每个表的字段都是一样的，灵活性比较差。

```javascript
npm install mongodb --save
```

连接服务器与数据库

```javascript
const MongoClient = require('mongodb').MongoClient;
const assert = require('assert');

// Connection URL
const url = 'mongodb://localhost:27017';

// Database Name
const dbName = 'myproject';

// Create a new MongoClient
const client = new MongoClient(url);

// Use connect method to connect to the Server
client.connect(function(err) {
  assert.equal(null, err);
  console.log("Connected successfully to server");

  const db = client.db(dbName);

  client.close();
});

```

