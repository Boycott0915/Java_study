# 1.为什么使用 `Thread(Runnable target)` 以及代理模式的解释

你问到了一个非常核心的问题：为什么在Java多线程中，我们使用 `Thread(Runnable target)`，为什么说这是一种代理模式。我来详细解释一下。

## 为什么需要 `Thread(Runnable target)`

首先，需要澄清一个概念：**不是"Runnable为什么要用Thread"，而是"为什么创建线程时需要将Runnable对象传递给Thread"**。

在Java中，Thread类和Runnable接口的关系是：

```java
public class Thread extends Object implements Runnable {
    // Thread类内部实现
    private Runnable target;
    
    public Thread(Runnable target) {
        init(null, target, "Thread-" + nextThreadNum(), 0);
    }
    
    public void run() {
        if (target != null) {
            target.run();
        }
    }
}
```

从知识库[3]中可以看到：

> Thread类是Runnable接口的子类；因此Thread类覆写run()方法。 Public void run(){ if (target != nu11) {targrt.run();}}

## 代理模式的解释

这就是为什么说这是一种**代理模式**。

### 什么是代理模式？

代理模式是一种设计模式，它为其他对象提供一种代理以控制对这个对象的访问。在Java多线程中，Thread类充当了Runnable对象的代理。

### 为什么是代理模式？

1. **任务与线程分离**：
   - Runnable接口定义了任务（`run()`方法）
   - Thread类负责线程管理（启动、调度等）
   - Thread类通过`target.run()`将任务委托给Runnable对象执行
2. **具体流程**：
   - 创建Runnable任务对象（`MyTask task = new MyTask()`）
   - 将任务对象传递给Thread（`Thread thread = new Thread(task)`）
   - 调用Thread的start()方法（`thread.start()`）
   - Thread的run()方法被调用，内部执行`target.run()`（即任务对象的run()方法）
3. **代理关系**：
   - Thread = 代理（负责线程管理）
   - Runnable = 被代理对象（负责任务逻辑）
   - Thread通过调用Runnable的run()方法，将任务执行委托给Runnable对象

## 为什么需要这种设计？

从知识库[2]中可以找到关键解释：

> 但这样还是不够灵活，比如我希望抢票任务在main方法执行的同时，再提交给一个线程池执行。此时继承的方案就不够灵活了。需要把任务和线程拆分开，也就是Runnable#run。

从知识库[10]中：

> 实现Runnable接口相对于继承Thread类来说，有如下显著的好处： 适合多个相同程序代码的线程去处理同一资源的情况，把虚拟CPU（线程）同程序的代码，数据有效的分离，较好地体现了面向对象的设计思想。 可以避免由于Java的单继承特性带来的局限。

## 为什么不能直接使用Runnable？

因为Runnable只是一个接口，它没有start()方法。只有Thread类才有start()方法，用于启动线程。所以，我们**必须**通过Thread来启动线程，而Thread内部会将任务委托给Runnable对象执行。

## 举个简单例子

```java
// 实现Runnable接口定义任务
class MyTask implements Runnable {
    public void run() {
        System.out.println("任务执行中");
    }
}

// 创建任务
Runnable task = new MyTask();

// 通过Thread作为代理启动任务
Thread thread = new Thread(task);
thread.start();
```

在这个例子中：

- `MyTask` 是任务（Runnable）
- `Thread` 是代理，它负责启动线程并委托任务执行
- `thread.start()` 会调用Thread的run()方法
- Thread的run()方法会调用`task.run()`，即执行MyTask的run()方法

## 为什么这种设计更好？

1. **避免单继承限制**：一个类可以实现Runnable接口，同时继承其他类
2. **任务可复用**：同一个Runnable对象可以被多个Thread使用
3. **任务与线程解耦**：任务逻辑（Runnable）和线程管理（Thread）分离，更符合面向对象设计

## 总结

- `Thread(Runnable target)` 是一种**代理模式**，Thread作为代理对象，将任务执行委托给Runnable对象
- 不是"Runnable要用Thread"，而是"需要Thread来启动线程，而Thread会调用Runnable的run()方法"
- 这种设计使任务与线程分离，提高了代码的灵活性和可重用性
- 这也是为什么推荐使用Runnable接口而非继承Thread类的原因

希望这个解释能帮助你理解Java多线程中为什么使用`Thread(Runnable target)`以及为什么说这是一种代理模式。

# 2.解释：为什么Runnable更"适合多个线程共享一个资源"

这个问题的核心在于理解**如何让多个线程共同操作同一个数据**。我来用简单易懂的方式解释：

## 举个实际例子：火车票售票系统

假设我们有一个火车票售票系统，总共有10张票，有3个窗口（3个线程）同时售票：

### 方式1：使用Runnable接口（推荐）

```java
// 共享资源类：票数
class TicketSeller implements Runnable {
    private int tickets = 10; // 共享的票数
    
    @Override
    public void run() {
        while (tickets > 0) {
            System.out.println(Thread.currentThread().getName() + "卖出了第" + tickets-- + "张票");
            try {
                Thread.sleep(100); // 模拟售票时间
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

public class Main {
    public static void main(String[] args) {
        TicketSeller seller = new TicketSeller(); // 只创建一个共享对象
        
        // 三个窗口（线程）共享同一个售票对象
        new Thread(seller, "窗口1").start();
        new Thread(seller, "窗口2").start();
        new Thread(seller, "窗口3").start();
    }
}
```

**输出示例：**

```
窗口1卖出了第10张票
窗口2卖出了第9张票
窗口3卖出了第8张票
窗口1卖出了第7张票
...
```

**关键点：**

- 只创建了一个`TicketSeller`对象（`seller`）
- 三个线程（窗口）都使用这个**同一个对象**
- 所有线程共享`tickets`变量，所以它们共同操作同一个票数

### 方式2：继承Thread类（不推荐）

```java
class TicketSeller extends Thread {
    private int tickets = 10;
    
    @Override
    public void run() {
        while (tickets > 0) {
            System.out.println(Thread.currentThread().getName() + "卖出了第" + tickets-- + "张票");
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

public class Main {
    public static void main(String[] args) {
        // 创建三个独立的售票对象
        new TicketSeller("窗口1").start();
        new TicketSeller("窗口2").start();
        new TicketSeller("窗口3").start();
    }
}
```

**输出示例：**

```
窗口1卖出了第10张票
窗口1卖出了第9张票
...
窗口2卖出了第10张票
窗口2卖出了第9张票
...
```

**问题：**

- 每个窗口有自己的票数（每个线程有自己的`tickets`变量）
- 三个窗口各自有10张票，总共30张票，而不是共享的10张票

## 为什么"共享"很重要？

1. **资源有限**：真实场景中，资源（如票数、库存、数据库连接）是有限的，需要被多个线程共同管理
2. **数据一致性**：如果多个线程操作独立的数据，会导致数据不一致（如超卖）
3. **资源效率**：共享资源可以避免创建多个相同资源的副本，节省内存和系统资源

## 为什么Runnable能实现共享？

- **Runnable只是一个任务接口**，它不包含线程状态
- **Thread类负责线程管理**，它通过`target.run()`将任务委托给Runnable对象
- 当我们创建`new Thread(seller)`时，多个Thread对象都指向**同一个seller对象**，所以它们共享同一个资源

## 用生活中的例子类比

想象一个**共享的水杯**：

- Runnable就像水杯（资源）
- Thread就像喝水的人（线程）
- 多个人（线程）可以共用同一个水杯（Runnable实例），而不是每个人都要一个水杯

如果用继承Thread的方式，就像每个人都要自己的水杯，而不是共用一个，这样既浪费资源，又无法实现"共用一杯水"的场景。

## 总结

"适合多个线程共享一个资源"的意思是：

> 通过实现Runnable接口，我们可以创建一个对象（如票数、库存等），然后让多个线程（如多个窗口、多个用户）共享这个对象，这样它们就能共同操作同一个资源，而不是各自拥有独立的资源副本。

这种方式在实际应用中非常常见，如线程池、数据库连接池、缓存系统等，都需要多个线程共享同一个资源。

## 不同类数据共享问题

```java
//新增一个enemytanks用来保存敌方坦克群 也是为了运用MyPanel中的
    // Vector<Enemy> enemies = new Vector<>();
    Vector<Enemy> enemiesTank = new Vector<>();
    //这个set方法可以使Eemy类也能使用到MyPanel类中的enemies属性
    public void setEnemiesTank(Vector<Enemy> enemiesTank) {
        this.enemiesTank = enemiesTank;
    }

// 2. 【关键步骤】为每一个敌方坦克设置它们所能感知到的全体坦克集合
        for (Enemy enemy : enemies) {
            enemy.setEnemiesTank(enemies); // 将同一个 enemies 集合的引用传递给每一个坦克
        }
```

# Properties配置文件 动态解析

好的！我们用**完全小白的角度**，一步一步、手把手教你理解：

> **“把数据库信息写在 `.properties` 文件里，Java 程序去读它”**
> 这个过程就叫 **“动态解析配置文件”**。

------

###  为什么不用硬编码？先看问题

你原来的代码是这样的：

```java
url = "jdbc:mysql://localhost:3306/0915";
user = "root";
password = "1234";
```

这叫 **“硬编码”** —— 把数据直接写死在 Java 代码里。

 问题来了：

- 如果密码改了（比如改成 `123456`），你必须**改 Java 代码**，再重新编译、运行。
- 如果换到公司服务器，数据库地址变了，又要改代码！
- 不安全！密码暴露在代码里，别人一看就知道。

 所以更好的做法是：**把配置单独放一个文件里**，Java 程序启动时去读这个文件。

------

##  第一步：创建 `.properties` 文件

1. 在你的 IDEA 项目中，找到 `src` 文件夹（源代码根目录）。
2. 右键点击 `src` → **New → File**
3. 文件名输入：`jdbc.properties`（注意后缀是 `.properties`）

>  小知识：`.properties` 是 Java 专用的**配置文件格式**，内容是 `key=value` 形式。

1. 在文件里写入以下内容（按你自己的数据库改）：

```properties
# 数据库连接配置
url=jdbc:mysql://localhost:3306/0915
user=root
password=1234
```

> 注意：
>
> - 不要加引号！
> - 等号两边不要有空格（除非你想保留空格）
> - `#` 开头的是注释，程序会忽略

------

## 第二步：让 Java 读这个文件

现在我们要修改你的 `JDBCUTILS` 类，让它**从 `jdbc.properties` 读取配置**，而不是写死。

###  修改后的完整代码（带详细注释）：

```java
package utils;

import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class JDBCUTILS {
    private static String url;
    private static String user;
    private static String password;

    // 静态代码块：类加载时自动执行一次
    static {
            try {
            //动态解析 创建properties集合
            Properties properties = new Properties();
            //1读取配置文件
            InputStream in = JDBCUTILS.class.getClassLoader().getResourceAsStream("jdbc.properties");
            properties.load(in);
            //2.解析
            Class.forName((properties.getProperty("drivername")));
            url=properties.getProperty("url");
            user=properties.getProperty("user");
            password=properties.getProperty("password");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

```

------

##  第三步：怎么理解“动态解析”？

- **“动态”**：程序运行时才去读文件，不是写死在代码里。
- **“解析”**：Java 把 `jdbc.properties` 里的文本，变成 `url`、`user`、`password` 这些变量。

👉 举个生活例子：

- 硬编码 = 把家门钥匙焊死在手上（改不了）
- 配置文件 = 把钥匙放在门口鞋柜（随时可以换）

## 最终效果

现在你只需要：

- 改数据库密码？→ 打开 `jdbc.properties` 改一行，**不用动 Java 代码**！
- 换数据库地址？→ 同样只改配置文件！

这就是 **“解耦”** 和 **“可维护性”** 的体现 👍

# **到底为什么还能调用 `bb()`？**

### 正确答案：**在抛出 `StackOverflowError` 后，递归停止，栈帧被弹出，大量栈空间被释放，所以可以继续正常调用 `bb()`。**

# 为什么不是另外两种情况？

| 可能性              | 是否正确                                         | 解释                               |
| ------------------- | ------------------------------------------------ | ---------------------------------- |
| ✅ 栈被释放了        | ✅ 正确                                           | 抛出错误后，递归过程结束，栈帧回收 |
| 栈其实没满          | ❌ 错误                                           | 栈是真满了，所以才抛出错误         |
| 使用保底栈执行 bb() | ❌ 只用少量保底栈完成异常抛出，不用来执行大量逻辑 |                                    |

## ✅ 关键时间线

| 时间点                                              | 发生的事           |
| --------------------------------------------------- | ------------------ |
| ① 栈满了                                            | 递归无法再继续压栈 |
| ② JVM 创建 `StackOverflowError`（使用极少量保底栈） |                    |
| ③ 开始“栈展开” = 递归调用全部被弹出                 |                    |
| ④ 栈帧大量释放，栈恢复到正常容量                    |                    |
| ⑤ 找到 `catch (StackOverflowError e)`               |                    |
| ✅ 继续执行 catch 内的 `bb()`                        |                    |

**因此，执行 bb() 不是用“保底栈”，而是恢复后的正常栈。**

# 为什么 JUnit 不允许 `static` 测试方法？

#### 1. **JUnit 的设计原则**

JUnit（特别是 JUnit 4 和 JUnit 5）在运行测试时，**会为每个测试方法创建一个新的测试类实例**（即 `new YourTestClass()`），然后调用该实例上的非静态方法。

- 这样做是为了**保证测试之间的隔离性**（每个测试都有独立的状态，避免互相干扰）。
- 如果测试方法是 `static` 的，它就不属于某个具体对象实例，而是属于类本身，这就破坏了“每个测试独立运行”的机制。

#### 2. **反射调用限制**

JUnit 使用反射来调用测试方法。它默认只调用 **非静态的、无参的、public 的实例方法**。
 如果方法是 `static`，JUnit **不会执行它**（在 JUnit 4 中可能直接忽略；在某些 IDE 中甚至会报错或标红）。

# 什么是 XML？

**XML** 是一个英文缩写，全称是：

> **eXtensible Markup Language**
>  中文翻译就是：**可扩展标记语言**

听起来有点复杂？别急，我们拆开来看。

------

## 拆解“可扩展标记语言”

#### 1. “标记语言”是什么意思？

想象一下你写一封信，你想告诉别人：“这是我的名字”、“这是我的电话”、“这是我的地址”。

在普通文字里，这些信息混在一起，别人可能分不清哪个是哪个。

但如果你用**标签**（就像给每个信息贴个标签）来标注，就清楚多了。

比如：

```
<名字>张三</名字>
<电话>123456789</电话>
<地址>北京朝阳区</地址>
```

这里的 `<名字>`、`<电话>` 就是“标签”，它们的作用是**告诉别人这段文字代表什么**。

这就是“标记语言”的核心：**用标签来描述内容的含义**。

------

#### 2. “可扩展”是什么意思？

“可扩展”意思是：**你可以自己定义标签**！

比如你做网站，想记录用户信息，你可以自己创造标签：

```
<用户>
  <姓名>李四</姓名>
  <年龄>25</年龄>
  <爱好>打篮球</爱好>
</用户>
```

你不需要用别人规定的标签，**你自己想叫啥就叫啥**，这就是“可扩展”。

------

### 总结一下

所以这句话的意思是：

> XML 是一种“可扩展标记语言”——
>  它允许你**自己定义标签**（比如 `<姓名>`、`<电话>`），
>  并且整个文件的内容都以这种“标签包裹内容”的形式存在。

# **不要混淆“文件中的字节长度”和“Java 内存中的字符表示”**

你提出了一个非常好的问题！这涉及到 **Java 中字符编码、`char` 类型与字节（byte）的关系**，以及 `FileReader` 的底层工作原理。

------

## 简短回答：

> **虽然 UTF-8 编码下中文通常占 3 个字节，但 Java 的 `char` 是以 UTF-16 编码存储的，每个 `char` 固定占 2 字节，能直接表示大部分常用中文字符（包括“黑马程序员”）。所以 `FileReader` 读取时已经将字节自动解码为 `char`，你看到的是字符，不是原始字节。**

------

## 详细解释

### 1. `FileReader` 是**字符流**，不是字节流

- `FileReader` 继承自 `InputStreamReader`，它在内部会使用平台默认字符集（如 UTF-8、GBK 等）**自动将文件的字节解码成字符（`char`）**。
- 所以你调用 `fr.read(cbuf)` 时，**返回的是已经解码好的 Unicode 字符**，不是原始的字节！

> 💡 换句话说：`FileReader` 已经帮你把“3 字节的 UTF-8 中文”转换成了“2 字节的 Java `char`”。

------

### 2. Java 的 `char` 是 **UTF-16 编码**

- Java 中 `char` 是 **16 位无符号整数（2 字节）**，采用 **UTF-16** 编码。

- 基本多文种平面（BMP）

   中的字符（包括几乎全部常用汉字，Unicode 范围 U+4E00 ~ U+9FFF）都可以用 

  一个 `char` 表示

  。

  - 例如：“黑” = `\u9ED1`，“马” = `\u9A6C`，“程” = `\u7A0B`……都在 BMP 内。

- 只有极少数生僻字（如 emoji、古汉字）需要两个 `char`（即“代理对”），但“黑马程序员”完全不需要。

✅ 所以每个中文字符在 Java 中就是一个 `char`，占 2 字节内存，和文件中用 UTF-8 存储时占 3 字节 **不矛盾**！

------

### 3. 文件存储 vs 内存表示的区别

| 阶段                    | 编码方式 | “黑”字占用         |
| ----------------------- | -------- | ------------------ |
| **磁盘文件（UTF-8）**   | UTF-8    | 3 字节：`E9 BB 91` |
| **Java 内存（运行时）** | UTF-16   | 2 字节：`0x9ED1`   |

`FileReader` 在读取时做了转换：

```
磁盘字节 (UTF-8) → 解码 → Java char (UTF-16)
```

所以你的 `char[] cbuf = new char[2]` 每次可以装 **2 个中文字符**，比如：

- 第一次读：`'黑'`, `'马'` → 输出 `"黑马"`
- 第二次读：`'程'`, `'序'` → 输出 `"程序"`
- 第三次读：`'员'` → 输出 `"员"`

完全正常！

------

## 注意事项

如果你用的是 **字节流**（如 `FileInputStream`），那就必须手动处理编码，否则会乱码：

```java
// 错误示例：用字节流直接读中文（可能乱码）
FileInputStream fis = new FileInputStream("read.txt");
byte[] buf = new byte[2];
// 每次读2字节？但中文UTF-8是3字节 → 会截断，乱码！
```

但你用的是 `FileReader`（字符流），所以**自动处理了编码问题**，无需担心。

------

## 总结

- `FileReader` 是字符流，自动按字符编码（如 UTF-8）将字节转为 `char`。
- Java 的 `char` 是 UTF-16，2 字节，能直接表示常用中文。
- 文件中 UTF-8 的中文占 3 字节，但在内存中被转为 2 字节的 `char`。
- 所以 `char[2]` 能正确存放两个中文字符，输出 `"黑马"`、`"程序"`、`"员"` 完全合理。

> 🌟 关键点：**不要混淆“文件中的字节长度”和“Java 内存中的字符表示”**。

如有兴趣，你可以用 `Files.readAllBytes()` 看看文件实际字节数，再对比 `String.length()`，会有更直观的理解 😊

# 什么是回显？

> **回显（Echo / Data Re-display）是指：当用户提交表单后，如果出错（比如密码错误），页面重新加载时，自动把用户之前填写的内容再显示出来，而不是清空所有输入框。**

------

### 🌰 举个真实例子（登录页修改场景）

假设你正在做一个 **“修改用户信息”** 页面（比如改用户名、邮箱等）：

#### ❌ 没有回显的情况（用户体验极差）：

1. 用户打开页面，看到自己的信息：

   - 用户名：`张三`
   - 邮箱：`zhangsan@example.com`

2. 用户把邮箱改成 `newemail@xxx.com`，点击【保存】

3. 系统校验发现：**新邮箱格式不合法！**

4. 页面刷新 →

    

   所有输入框变空了！

   - 用户名变成空白
   - 邮箱也变成空白

5. 用户崩溃：“我刚填的呢？？又要重打一遍？”

#### ✅ 有回显的情况（专业做法）：

1. 用户修改邮箱为 `newemail@xxx.com`，点击【保存】

2. 系统提示：“邮箱格式错误！”

3. 页面刷新 →

    

   但输入框里还是显示 `newemail@xxx.com`！

   - 用户名依然显示 `张三`（或用户修改后的值）
   - 用户只需改邮箱，不用重填其他内容

> 💡 这就是 **“回显”** —— 把用户上次提交的数据“回”到页面上“显”示出来。
