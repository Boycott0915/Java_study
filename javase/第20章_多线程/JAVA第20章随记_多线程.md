# JAVA第20章随记_多线程

## 1.实现多线程

### 1.1简单了解多线程【理解】

是指从软件或者硬件上实现多个线程并发执行的技术。
具有多线程能力的计算机因有硬件支持而能够在同一时间执行多个线程，提升性能。

![image-20251015200700471](JAVA第20章随记_多线程.assets/image-20251015200700471.png)

### 1.2并发和并行【理解】

+ 并行：在同一时刻，有多个指令在多个CPU上同时执行。

  ![02_并行](JAVA第20章随记_多线程.assets/02_并行.png)

+ 并发：在同一时刻，有多个指令在单个CPU上交替执行。

  ![03_并发](JAVA第20章随记_多线程.assets/03_并发.png)

![image-20251015200834215](JAVA第20章随记_多线程.assets/image-20251015200834215.png)

### 1.3进程和线程【理解】

- 进程：是正在运行的程序

  独立性：进程是一个能独立运行的基本单位，同时也是系统分配资源和调度的独立单位
  动态性：进程的实质是程序的一次执行过程，进程是动态产生，动态消亡的
  并发性：任何进程都可以同其他进程一起并发执行

- 线程：是进程中的单个顺序控制流，是一条执行路径

  ​	单线程：一个进程如果只有一条执行路径，则称为单线程程序

  ​	多线程：一个进程如果有多条执行路径，则称为多线程程序

### 1.4实现多线程方式一：继承Thread类【应用】

- 方法介绍

  | 方法名       | 说明                                        |
  | ------------ | ------------------------------------------- |
  | void run()   | 在线程开启后，此方法将被调用执行            |
  | void start() | 使此线程开始执行，Java虚拟机会调用run方法() |

- 实现步骤

  - 定义一个类MyThread继承Thread类
  - 在MyThread类中重写run()方法
  - 创建MyThread类的对象
  - 启动线程

- 代码演示

  ```java
  public class MyThread extends Thread {
      @Override
      public void run() {
          for(int i=0; i<100; i++) {
              System.out.println(i);
          }
      }
  }
  public class MyThreadDemo {
      public static void main(String[] args) {
          MyThread my1 = new MyThread();
          MyThread my2 = new MyThread();
  
  //        my1.run();
  //        my2.run();
  
          //void start() 导致此线程开始执行; Java虚拟机调用此线程的run方法
          my1.start();
          my2.start();
      }
  }
  ```

  两个小问题

  - 为什么要重写run()方法？

    ==因为run()是用来封装被线程执行的代码，run方法是实现了Runnable接口的run方法==

  - run()方法和start()方法的区别？

    run()：封装线程执行的代码，直接调用，相当于普通方法的调用，这时候相当于占用main线程来执行，会影响程序继续向下执行操作。

    start()：启动线程；==start0()是本地方法由JVM调用，底层实现c/c++，是真正实现多线程效果的核心==，然后由JVM调用此线程的run()方法

### 1.5实现多线程方式二：实现Runnable接口【应用】

- Thread构造方法

  | 方法名                               | 说明                   |
  | ------------------------------------ | ---------------------- |
  | Thread(Runnable target)              | 分配一个新的Thread对象 |
  | Thread(Runnable target, String name) | 分配一个新的Thread对象 |

- 实现步骤

  - 定义一个类MyRunnable实现Runnable接口(implements)
  - 在MyRunnable类中重写run()方法
  - 创建MyRunnable类的对象
  - ==创建Thread类的对象，把MyRunnable对象作为构造方法的参数==
  - 启动线程

- 代码演示

  ```java
  public class MyRunnable implements Runnable {
      @Override
      public void run() {
          for(int i=0; i<100; i++) {
              System.out.println(Thread.currentThread().getName()+":"+i);
          }
      }
  }
  public class MyRunnableDemo {
      public static void main(String[] args) {
          //创建MyRunnable类的对象
          MyRunnable my = new MyRunnable();
  
          //创建Thread类的对象，把MyRunnable对象作为构造方法的参数
          //Thread(Runnable target)
  //        Thread t1 = new Thread(my);
  //        Thread t2 = new Thread(my);
          //Thread(Runnable target, String name)
          Thread t1 = new Thread(my,"坦克");
          Thread t2 = new Thread(my,"飞机");
  
          //启动线程
          t1.start();
          t2.start();
      }
  }
  ```

### 1.6实现多线程方式三: 实现Callable接口【应用】

+ 方法介绍

  | 方法名                           | 说明                                               |
  | -------------------------------- | -------------------------------------------------- |
  | V call()                         | 计算结果，如果无法计算结果，则抛出一个异常         |
  | FutureTask(Callable<V> callable) | 创建一个 FutureTask，一旦运行就执行给定的 Callable |
  | V get()                          | 如有必要，等待计算完成，然后获取其结果             |

+ 实现步骤

  + 定义一个类MyCallable实现Callable接口
  + 在MyCallable类中重写call()方法
  + 创建MyCallable类的对象
  + ==创建Future的实现类FutureTask对象，把MyCallable对象作为构造方法的参数==
  + 创建Thread类的对象，把FutureTask对象作为构造方法的参数
  + 启动线程
  + 再调用get方法，就可以获取线程结束之后的结果。

+ 代码演示

  ```java
  public class MyCallable implements Callable<String> {
      @Override
      public String call() throws Exception {
          for (int i = 0; i < 100; i++) {
              System.out.println("跟女孩表白" + i);
          }
          //返回值就表示线程运行完毕之后的结果
          return "答应";
      }
  }
  public class Demo {
      public static void main(String[] args) throws ExecutionException, InterruptedException {
          //线程开启之后需要执行里面的call方法
          MyCallable mc = new MyCallable();
  
          //Thread t1 = new Thread(mc);
  
          //可以获取线程执行完毕之后的结果.也可以作为参数传递给Thread对象
          FutureTask<String> ft = new FutureTask<>(mc);
  
          //创建线程对象
          Thread t1 = new Thread(ft);
  
          String s = ft.get();
          //开启线程
          t1.start();
  
          //String s = ft.get();
          System.out.println(s);
      }
  }
  ```

+ 三种实现方式的对比

  + 实现Runnable、Callable接口
    + 好处: 扩展性强，实现该接口的同时还可以继承其他的类
    + 缺点: 编程相对复杂，不能直接使用Thread类中的方法
  + 继承Thread类
    + 好处: 编程比较简单，可以直接使用Thread类中的方法
    + 缺点: 可以扩展性较差，不能再继承其他的类
  + 需要返回结果的话就用Callable接口

![image-20251016093354375](JAVA第20章随记_多线程.assets/image-20251016093354375.png)

### 1.7设置和获取线程名称【应用】

- 方法介绍

  | 方法名                     | 说明                               |
  | -------------------------- | ---------------------------------- |
  | void  setName(String name) | 将此线程的名称更改为等于参数name   |
  | String  getName()          | 返回此线程的名称                   |
  | Thread  currentThread()    | 返回对当前正在执行的线程对象的引用 |

- 代码演示

  ```java
  public class MyThread extends Thread {
      public MyThread() {}
      public MyThread(String name) {
          super(name);
      }
  
      @Override
      public void run() {
          for (int i = 0; i < 100; i++) {
              System.out.println(getName()+":"+i);
          }
      }
  }
  public class MyThreadDemo {
      public static void main(String[] args) {
          MyThread my1 = new MyThread();
          MyThread my2 = new MyThread();
  		
          //给线程取名字
          //方法一void setName(String name)：将此线程的名称更改为等于参数 name
          my1.setName("高铁");
          my2.setName("飞机");
  			
          //方法二 使用构造方法Thread(String name)
          MyThread my1 = new MyThread("高铁");
          MyThread my2 = new MyThread("飞机");
  
          my1.start();
          my2.start();
  
          //static Thread currentThread() 返回对当前正在执行的线程对象的引用
          //当JVM虚拟机启动之后，会自动的启动多条线程，其中有条线程就叫做main线程，
          //他的作用就是去调用main方法，并执行里面的代码
          //在以前，我们写的所有的代码，其实都是运行在main线程当中的
          System.out.println(Thread.currentThread().getName());
      }
  }
  ```

### 1.8线程休眠【应用】

+ 相关方法

  | 方法名                         | 说明                                             |
  | ------------------------------ | ------------------------------------------------ |
  | static void sleep(long millis) | 使当前正在执行的线程停留（暂停执行）指定的毫秒数 |

+ 代码演示

  ```java
  public class MyRunnable implements Runnable {
      @Override
      public void run() {
          for (int i = 0; i < 100; i++) {
              try {
                  Thread.sleep(100);
              } catch (InterruptedException e) {
                  e.printStackTrace();
              }
  
              System.out.println(Thread.currentThread().getName() + "---" + i);
          }
      }
  }
  public class Demo {
      public static void main(String[] args) throws InterruptedException {
          /*System.out.println("睡觉前");
          Thread.sleep(3000);
          System.out.println("睡醒了");*/
  
          MyRunnable mr = new MyRunnable();
  
          Thread t1 = new Thread(mr);
          Thread t2 = new Thread(mr);
  
          t1.start();
          t2.start();
      }
  }
  ```

### 1.9线程优先级【应用】

- 线程调度

  - 两种调度方式

    - 分时调度模型：所有线程轮流使用 CPU 的使用权，平均分配每个线程占用 CPU 的时间片
    - 抢占式调度模型：优先让优先级高的线程使用 CPU，如果线程的优先级相同，那么会随机选择一个，优先级高的线程获取的 CPU 时间片相对多一些

  - Java使用的是抢占式调度模型

  - 随机性

    假如计算机只有一个 CPU，那么 CPU 在某一个时刻只能执行一条指令，线程只有得到CPU时间片，也就是使用权，才可以执行指令。所以说多线程程序的执行是有随机性，因为谁抢到CPU的使用权是不一定的

    ![05_多线程示例图](JAVA第20章随记_多线程.assets/05_多线程示例图.png)

- 优先级相关方法

  | 方法名                                  | 说明                                                         |
  | --------------------------------------- | ------------------------------------------------------------ |
  | final int getPriority()                 | 返回此线程的优先级                                           |
  | final void setPriority(int newPriority) | 更改此线程的优先级线程默认优先级是5；线程优先级的范围是：1-10 |

- 代码演示

  ```java
  public class MyCallable implements Callable<String> {
      @Override
      public String call() throws Exception {
          for (int i = 0; i < 100; i++) {
              System.out.println(Thread.currentThread().getName() + "---" + i);
          }
          return "线程执行完毕了";
      }
  }
  public class Demo {
      public static void main(String[] args) {
          //优先级: 1 - 10 默认值:5
          MyCallable mc = new MyCallable();
  
          FutureTask<String> ft = new FutureTask<>(mc);
  
          Thread t1 = new Thread(ft);
          t1.setName("飞机");
          t1.setPriority(10);
          //System.out.println(t1.getPriority());//5
          t1.start();
  
          MyCallable mc2 = new MyCallable();
  
          FutureTask<String> ft2 = new FutureTask<>(mc2);
  
          Thread t2 = new Thread(ft2);
          t2.setName("坦克");
          t2.setPriority(1);
          //System.out.println(t2.getPriority());//5
          t2.start();
      }
  }
  ```

### 1.10守护线程【应用】（备胎）

- 相关方法

- 理解：当其他非守护线程执行完毕后，守护线程会陆续结束

- 通俗理解：当女神线程结束了，那么备胎也没有存在的必要了 （不是立马结束，是陆续结束）

  | 方法名                     | 说明                                                         |
  | -------------------------- | ------------------------------------------------------------ |
  | void setDaemon(boolean on) | 将此线程标记为守护线程，当运行的线程都是守护线程时，Java虚拟机将退出 |

- 代码演示

  ```java
  public class MyThread1 extends Thread {
      @Override
      public void run() {
          for (int i = 0; i < 10; i++) {
              System.out.println(getName() + "---" + i);
          }
      }
  }
  public class MyThread2 extends Thread {
      @Override
      public void run() {
          for (int i = 0; i < 100; i++) {
              System.out.println(getName() + "---" + i);
          }
      }
  }
  public class Demo {
      public static void main(String[] args) {
          MyThread1 t1 = new MyThread1();
          MyThread2 t2 = new MyThread2();
  
          t1.setName("女神");
          t2.setName("备胎");
  
          //把第二个线程设置为守护线程
          //当普通线程执行完之后,那么守护线程也没有继续运行下去的必要了.
          t2.setDaemon(true);
  
          t1.start();
          t2.start();
      }
  }
  ```

![image-20251016095420956](JAVA第20章随记_多线程.assets/image-20251016095420956.png)

### 1.11 线程的生命周期

 ![image-20251016100741034](JAVA第20章随记_多线程.assets/image-20251016100741034.png)

### 1.12 线程的安全问题

![image-20251016101316407](JAVA第20章随记_多线程.assets/image-20251016101316407.png)

会出现窗口1 窗口2 窗口3 同时贩卖一张票的情况出现

## 2.线程同步

### 2.1卖票【应用】

- 案例需求

  某电影院目前正在上映国产大片，共有100张票，而它有3个窗口卖票，请设计一个程序模拟该电影院卖票

- 实现步骤

  - 定义一个类SellTicket实现Runnable接口，里面定义一个成员变量：private int tickets = 100;

  - 在SellTicket类中重写run()方法实现卖票，代码步骤如下

  - 判断票数大于0，就卖票，并告知是哪个窗口卖的
  - 卖了票之后，总票数要减1
  - 票卖没了，线程停止
  - 定义一个测试类SellTicketDemo，里面有main方法，代码步骤如下
  - 创建SellTicket类的对象
  - 创建三个Thread类的对象，把SellTicket对象作为构造方法的参数，并给出对应的窗口名称
  - 启动线程

- 代码实现

  ```java
  public class SellTicket implements Runnable {
      private int tickets = 100;
      //在SellTicket类中重写run()方法实现卖票，代码步骤如下
      @Override
      public void run() {
          while (true) {
              if(ticket <= 0){
                      //卖完了
                      break;
                  }else{
                      try {
                          Thread.sleep(100);
                      } catch (InterruptedException e) {
                          e.printStackTrace();
                      }
                      ticket--;
                      System.out.println(Thread.currentThread().getName() + "在卖票,还剩下" + ticket + "张票");
                  }
          }
      }
  }
  public class SellTicketDemo {
      public static void main(String[] args) {
          //创建SellTicket类的对象
          SellTicket st = new SellTicket();
  
          //创建三个Thread类的对象，把SellTicket对象作为构造方法的参数，并给出对应的窗口名称
          Thread t1 = new Thread(st,"窗口1");
          Thread t2 = new Thread(st,"窗口2");
          Thread t3 = new Thread(st,"窗口3");
  
          //启动线程
          t1.start();
          t2.start();
          t3.start();
      }
  }
  ```


### 2.2卖票案例的问题【理解】

- 卖票出现了问题

  - 相同的票出现了多次

  - 出现了负数的票

- 问题产生原因

  线程执行的随机性导致的,可能在卖票过程中丢失cpu的执行权,导致出现问题


### 2.3同步代码块解决数据安全问题【应用】

- 安全问题出现的条件

  - 是多线程环境

  - 有共享数据

  - 有多条语句操作共享数据

- 如何解决多线程安全问题呢?

  - 基本思想：让程序处于没有安全问题的环境

- 怎么实现呢?

  - 把多条语句操作共享数据的代码给锁起来，让任意时刻只能有一个线程执行即可

  - Java提供了同步代码块的方式来解决

- 同步代码块格式：

  ```java
  synchronized(任意对象) { 
  	多条语句操作共享数据的代码 
  }
  ```

  synchronized(任意对象)：就相当于给代码加锁了，任意对象就可以看成是一把锁

- 同步的好处和弊端  

  - 好处：解决了多线程的数据安全问题

  - 弊端：当线程很多时，因为每个线程都会去判断同步上的锁，这是很耗费资源的，无形中会降低程序的运行效率

- 代码演示

  ```java
  public class SellTicket implements Runnable {
      private int tickets = 100;
      private Object obj = new Object();
  
      @Override
      public void run() {
          while (true) {
              synchronized (obj) { // 对可能有安全问题的代码加锁,多个线程必须使用同一把锁
                  //t1进来后，就会把这段代码给锁起来
                  if (tickets > 0) {
                      try {
                          Thread.sleep(100);
                          //t1休息100毫秒
                      } catch (InterruptedException e) {
                          e.printStackTrace();
                      }
                      //窗口1正在出售第100张票
                      System.out.println(Thread.currentThread().getName() + "正在出售第" + tickets + "张票");
                      tickets--; //tickets = 99;
                  }
              }
              //t1出来了，这段代码的锁就被释放了
          }
      }
  }
  
  public class SellTicketDemo {
      public static void main(String[] args) {
          SellTicket st = new SellTicket();
  
          Thread t1 = new Thread(st, "窗口1");
          Thread t2 = new Thread(st, "窗口2");
          Thread t3 = new Thread(st, "窗口3");
  
          t1.start();
          t2.start();
          t3.start();
      }
  }
  ```

### 2.4同步方法解决数据安全问题【应用】

- 同步方法的格式

  同步方法：就是把synchronized关键字加到方法上

  ```java
  修饰符 synchronized 返回值类型 方法名(方法参数) { 
  	方法体；
  }
  ```

  同步方法的锁对象是什么呢?

  ​	this

- 静态同步方法

  同步静态方法：就是把synchronized关键字加到静态方法上

  ```java
  修饰符 static synchronized 返回值类型 方法名(方法参数) { 
  	方法体；
  }
  ```

  同步静态方法的锁对象是什么呢?

  ​	类名.class

- 代码演示

  ```java
  public class MyRunnable implements Runnable {
      private static int ticketCount = 100;
  
      @Override
      public void run() {
          while(true){
              if("窗口一".equals(Thread.currentThread().getName())){
                  //同步方法
                  boolean result = synchronizedMthod();
                  if(result){
                      break;
                  }
              }
  
              if("窗口二".equals(Thread.currentThread().getName())){
                  //同步代码块
                  synchronized (MyRunnable.class){
                      if(ticketCount == 0){
                         break;
                      }else{
                          try {
                              Thread.sleep(10);
                          } catch (InterruptedException e) {
                              e.printStackTrace();
                          }
                          ticketCount--;
                          System.out.println(Thread.currentThread().getName() + "在卖票,还剩下" + ticketCount + "张票");
                      }
                  }
              }
  
          }
      }
  
      private static synchronized boolean synchronizedMthod() {
          if(ticketCount == 0){
              return true;
          }else{
              try {
                  Thread.sleep(10);
              } catch (InterruptedException e) {
                  e.printStackTrace();
              }
              ticketCount--;
              System.out.println(Thread.currentThread().getName() + "在卖票,还剩下" + ticketCount + "张票");
              return false;
          }
      }
  }
   public class Demo {
        public static void main(String[] args) {
            MyRunnable mr = new MyRunnable();
  
            Thread t1 = new Thread(mr);
            Thread t2 = new Thread(mr);
      
            t1.setName("窗口一");
            t2.setName("窗口二");
      
            t1.start();
            t2.start();
        }
    }
  ```

| 特性       | 同步方法                                         | 同步代码块                                               |
| :--------- | :----------------------------------------------- | :------------------------------------------------------- |
| **锁对象** | 静态方法默认是`类名.class`，普通实例方法是`this` | **可灵活指定**任意对象（本例中指定为`MyRunnable.class`） |
| **锁粒度** | **粗**，锁住整个方法                             | **细**，只锁住需要同步的关键代码                         |
| **性能**   | 相对较低，锁范围大，线程等待时间长               | 相对较高，锁范围小，线程并发度更高                       |
| **灵活性** | 低                                               | 高                                                       |

### ➕ 举一反三

你可以尝试修改代码来加深理解：

- **实验1**：将`ticketCount`的`static`关键字去掉，再运行程序，观察会发生什么现象？（结果可能是两个窗口各卖了100张票，总共卖了200张票，因为票源不共享了）。
- **实验2**：将同步代码块的锁对象从`MyRunnable.class`改为`this`，再运行程序，还能保证线程安全吗？为什么？（不能，因为对于静态变量`ticketCount`，锁应该是类级别的锁（`MyRunnable.class`），而`this`是对象级别的锁，两个线程获取的是不同的锁，无法实现互斥）。
- **了解更多**：除了`synchronized`，Java的`java.util.concurrent.locks`包里的`Lock`接口（如`ReentrantLock`）也能实现同步，功能更强大灵活。

让我用一个更详细的比喻和代码示例来解释为什么“另一个对象会导致`this`锁失效”。

#### 核心问题：锁与资源的管辖范围不匹配

想象一下公司的储物柜区域：

- **静态变量** `ticketCount`（票数）就像公司里的**公共储物柜** - 所有员工都可以使用
- **对象锁** `this`就像每个员工的**工牌** - 每人一张，只能开自己的抽屉

#### 详细场景分析

###### 场景一：只有一个对象（当前代码的情况）

```Java
MyRunnable mr = new MyRunnable(); // 只创建一个对象
Thread t1 = new Thread(mr);  // 窗口一，使用mr对象
Thread t2 = new Thread(mr);  // 窗口二，使用同一个mr对象
```

在这种情况下，两个线程共享**同一个** `mr`对象，因此它们的 `this`指向的是**同一个锁**。这时候看起来好像是"安全"的，但实际上这只是巧合！

###### 场景二：新增另一个对象（问题所在！）

```java
MyRunnable mr1 = new MyRunnable(); // 第一个对象
MyRunnable mr2 = new MyRunnable(); // 第二个对象！！！

Thread t1 = new Thread(mr1);  // 窗口一，使用mr1对象
Thread t2 = new Thread(mr2);  // 窗口二，使用mr2对象
Thread t3 = new Thread(new MyRunnable());  // 窗口三，使用第三个对象！
```

现在问题来了：

- `t1`线程：使用 `mr1`对象的锁（`this`指向 `mr1`）
- `t2`线程：使用 `mr2`对象的锁（`this`指向 `mr2`）
- `t3`线程：使用另一个新对象的锁（另一个 `this`）

**关键点**：虽然这三个线程操作的是同一个静态变量 `ticketCount`（公司公共储物柜），但它们使用的是**不同的对象锁**（各自不同的工牌）！

###### 这为什么会导致线程不安全？

因为`synchronized(this)`只对**同一个对象**的多个线程有效。不同对象的`synchronized`方法或代码块之间**不会互相阻塞**。

具体来说：

- 线程t1进入 `mr1`的同步代码块，获取 `mr1`的锁
- 线程t2同时进入 `mr2`的同步代码块，获取 `mr2`的锁
- 线程t3同时进入第三个对象的同步代码块，获取第三个对象的锁
- **三个线程同时修改同一个静态变量 `ticketCount`** → 数据混乱！

用表格直观对比：

| 情况                                   | 锁对象         | 保护效果   | 说明                         |
| :------------------------------------- | :------------- | :--------- | :--------------------------- |
| 正确：`synchronized(MyRunnable.class)` | 类对象（唯一） | ✅ 安全     | 所有线程竞争**同一把锁**     |
| 错误：`synchronized(this)`（单对象）   | 特定实例       | ⚠️ 看似安全 | 只有同一对象的线程间安全     |
| 错误：`synchronized(this)`（多对象）   | 不同实例       | ❌ 不安全   | 每个对象有各自的锁，互不干扰 |

#### 代码演示问题

如果这样写：

```java
public void run() {
    synchronized(this) {  // 错误：使用对象锁保护静态变量
        if(ticketCount > 0) {
            ticketCount--;  // 多个不同对象的线程可能同时执行到这里！
        }
    }
}
```

当有多个`MyRunnable`实例时，这个同步块根本起不到保护作用，因为每个实例都有自己的`this`锁。

#### 为什么要用类锁？

```java
public void run() {
    synchronized(MyRunnable.class) {  // 正确：使用类锁
        if(ticketCount > 0) {
            ticketCount--;  // 确保同一时间只有一个线程执行
        }
    }
}
```

因为 `MyRunnable.class`在JVM中是**唯一的**，无论创建多少个对象，所有线程竞争的都是**同一把锁**，这样才能真正保护静态变量。

#### 总结

你的困惑很准确！`this`锁在"只有一个对象"时看似有效，但在"多个对象"场景下就完全失效了，因为它无法管辖其他对象的线程。而静态变量是**类级别**的资源，必须用**类级别**的锁来保护。

希望这个解释能帮你彻底理解这个重要的概念！

### 2.5Lock锁【应用】

虽然我们可以理解同步代码块和同步方法的锁对象问题，但是我们并没有直接看到在哪里加上了锁，在哪里释放了锁，为了更清晰的表达如何加锁和释放锁，JDK5以后提供了一个新的锁对象Lock

Lock是接口不能直接实例化，这里采用它的实现类ReentrantLock来实例化

- ReentrantLock构造方法

  | 方法名          | 说明                        |
  | --------------- | --------------------------- |
  | ReentrantLock() | 创建一个ReentrantLock的实例 |

- 加锁解锁方法

  | 方法名        | 说明   |
  | ------------- | ------ |
  | void lock()   | 获得锁 |
  | void unlock() | 释放锁 |

  ```java
  public class Ticket implements Runnable {
      //票的数量
      private int ticket = 100;
      private Object obj = new Object();
      private ReentrantLock lock = new ReentrantLock();
  
      @Override
      public void run() {
          while (true) {
              //synchronized (obj){//多个线程必须使用同一把锁.
              try {
                  lock.lock();
                  if (ticket <= 0) {
                      //卖完了
                      break;
                  } else {
                      Thread.sleep(100);
                      ticket--;
                      System.out.println(Thread.currentThread().getName() + "在卖票,还剩下" + ticket + "张票");
                  }
              } catch (InterruptedException e) {
                  e.printStackTrace();
              } finally {
                  lock.unlock();
              }
              // }
          }
      }
  }
  
  public class Demo {
      public static void main(String[] args) {
          Ticket ticket = new Ticket();
  
          Thread t1 = new Thread(ticket);
          Thread t2 = new Thread(ticket);
          Thread t3 = new Thread(ticket);
  
          t1.setName("窗口一");
          t2.setName("窗口二");
          t3.setName("窗口三");
  
          t1.start();
          t2.start();
          t3.start();
      }
  }
  ```

### 2.6死锁【理解】

+ 概述

  线程死锁是指由于两个或者多个线程互相持有对方所需要的资源，导致这些线程处于等待状态，无法前往执行。

+ 什么情况下会产生死锁

  1. 资源有限
  2. 同步嵌套

+ 代码演示

  ```java
  public class Demo {
      public static void main(String[] args) {
          //定义了两把锁
          Object objA = new Object();
          Object objB = new Object();
  
          new Thread(()->{
              while(true){
                  //抢占了一把锁 然后等待另外一把锁
                  synchronized (objA){
                      //线程一
                      synchronized (objB){
                          System.out.println("小康同学正在走路");
                      }
                  }
              }
          }).start();
  
          new Thread(()->{
              while(true){
                  synchronized (objB){
                      //线程二
                      synchronized (objA){
                          System.out.println("小薇同学正在走路");
                      }
                  }
              }
          }).start();
      }
  }
  ```

## 3.生产者消费者

### 3.1生产者和消费者模式概述【应用】

- 概述

  生产者消费者模式是一个十分经典的多线程协作的模式，弄懂生产者消费者问题能够让我们对多线程编程的理解更加深刻。

  所谓生产者消费者问题，实际上主要是包含了两类线程：

  ​	一类是生产者线程用于生产数据

  ​	一类是消费者线程用于消费数据

  为了解耦生产者和消费者的关系，通常会采用共享的数据区域，就像是一个仓库

  生产者生产数据之后直接放置在共享数据区中，并不需要关心消费者的行为

  消费者只需要从共享数据区中去获取数据，并不需要关心生产者的行为

- Object类的等待和唤醒方法

  | 方法名           | 说明                                                         |
  | ---------------- | ------------------------------------------------------------ |
  | void wait()      | 导致当前线程等待，直到另一个线程调用该对象的 notify()方法或 notifyAll()方法 |
  | void notify()    | 唤醒正在等待对象监视器的单个线程                             |
  | void notifyAll() | 唤醒正在等待对象监视器的所有线程                             |

### 3.2生产者和消费者案例【应用】

- 案例需求

  + 桌子类(Desk)：定义表示包子数量的变量,定义锁对象变量,定义标记桌子上有无包子的变量

  + 生产者类(Cooker)：实现Runnable接口，重写run()方法，设置线程任务

    1.判断是否有包子,决定当前线程是否执行

    2.如果有包子,就进入等待状态,如果没有包子,继续执行,生产包子

    3.生产包子之后,更新桌子上包子状态,唤醒消费者消费包子

  + 消费者类(Foodie)：实现Runnable接口，重写run()方法，设置线程任务

    1.判断是否有包子,决定当前线程是否执行

    2.如果没有包子,就进入等待状态,如果有包子,就消费包子

    3.消费包子后,更新桌子上包子状态,唤醒生产者生产包子

  + 测试类(Demo)：里面有main方法，main方法中的代码步骤如下

    创建生产者线程和消费者线程对象

    分别开启两个线程

- 代码实现

  ```java
  public class Desk {
  
      //定义一个标记
      //true 就表示桌子上有汉堡包的,此时允许吃货执行
      //false 就表示桌子上没有汉堡包的,此时允许厨师执行
      public static boolean flag = false;
  
      //汉堡包的总数量
      //决定整个程序何时结束。总共只生产10个汉堡，卖完就关门
      public static int count = 10;
  
      //锁对象
      public static final Object lock = new Object();
  }
  
  public class Cooker extends Thread {
  //    生产者步骤：
  //            1，判断桌子上是否有汉堡包?如果有就等待，如果没有才生产。
  //            2，把汉堡包放在桌子上。
  //            3，叫醒等待的消费者开吃。
      @Override
      public void run() {
          while(true){
              synchronized (Desk.lock){
                  if(Desk.count == 0){
                      break;
                  }else{
                      if(!Desk.flag){
                          //生产
                          System.out.println("厨师正在生产汉堡包");
                          Desk.flag = true;
                          Desk.lock.notifyAll();
                      }else{
                          try {
                              Desk.lock.wait();
                          } catch (InterruptedException e) {
                              e.printStackTrace();
                          }
                      }
                  }
              }
          }
      }
  }
  
  public class Foodie extends Thread {
      @Override
      public void run() {
      //消费者步骤:
  //        1，判断桌子上是否有汉堡包。
  //        2，如果没有就等待。
  //        3，如果有就开吃。
  //        4，吃完之后，桌子上的汉堡包就没有了叫醒等待的生产者继续生产汉堡包的总数量减一。
  
          //套路:
              //1. while(true)死循环
              //2. synchronized 锁,锁对象要唯一
              //3. 判断,共享数据是否结束?->结束
              //4. 判断,共享数据是否结束?->没有结束
          while(true){
              synchronized (Desk.lock){
                  if(Desk.count == 0){
                      break;
                  }else{
                      if(Desk.flag){
                          //有
                          System.out.println("吃货在吃汉堡包");
                          Desk.flag = false;
                          Desk.lock.notifyAll();
                          Desk.count--;
                      }else{
                          //没有就等待
                          //使用什么对象当做锁,那么就必须用这个对象去调用等待和唤醒的方法.
                          try {
                              Desk.lock.wait();
                          } catch (InterruptedException e) {
                              e.printStackTrace();
                          }
                      }
                  }
              }
          }
  
      }
  }
  
  public class Demo {
      public static void main(String[] args) {
          /*消费者步骤：
          1，判断桌子上是否有汉堡包。
          2，如果没有就等待。
          3，如果有就开吃
          4，吃完之后，桌子上的汉堡包就没有了
                  叫醒等待的生产者继续生产
          汉堡包的总数量减一*/
  
          /*生产者步骤：
          1，判断桌子上是否有汉堡包
          如果有就等待，如果没有才生产。
          2，把汉堡包放在桌子上。
          3，叫醒等待的消费者开吃。*/
  
          Foodie f = new Foodie();
          Cooker c = new Cooker();
  
          f.start();
          c.start();
  
      }
  }
  ```

我完全理解这段生产者-消费者模式的代码可能会让人困惑。这是一个经典的多线程协作案例，我用一个清晰的思路来帮你逐步理解。

#### 🧩 核心概念：生产者-消费者模式

想象一个餐馆的厨房：

- **厨师 (Cooker)**：就像**生产者**，负责制作汉堡包。
- **吃货 (Foodie)**：就像**消费者**，负责吃掉汉堡包。
- **桌子 (Desk)**：就像**共享缓冲区**，厨师把做好的汉堡放桌上，吃货从桌上拿汉堡吃。

他们需要协作：桌子上有汉堡时，吃货才能吃；桌子上没位置（有汉堡）时，厨师就不能再放。这个代码就是用多线程来模拟这个过程。

#### 🔑 核心控制中心：Desk 类

`Desk`类是整个系统的“指挥中心”，它通过三个静态变量来协调厨师和吃货的行为：

```
public class Desk {
    public static boolean flag = false; // 桌子上现在有没有汉堡？
    public static int count = 10;       // 总共要生产多少个汉堡？
    public static final Object lock = new Object(); // 唯一的“令牌”
}
```

- **`flag`**：这是一个信号灯。`true`表示“桌上有汉堡，吃货请吃，厨师等待”；`false`表示“桌上没汉堡，厨师请做，吃货等待”。
- **`count`**：决定整个程序何时结束。总共只生产10个汉堡，卖完就关门。
- **`lock`**：这是关键的**锁对象**（同步监视器）。想象成一个“厕所钥匙”，谁拿到这把钥匙，谁才能进入“厕所”（同步代码块）执行操作。**厨师和吃货必须用同一把钥匙**，这样才能保证不会出现混乱。

#### 👨‍🍳 生产者：Cooker 类（厨师）

厨师的行动逻辑封装在 `run`方法里，这是一个无限循环，直到汉堡做完（`count == 0`）。

1. **先抢“钥匙”**：`synchronized (Desk.lock)`确保厨师和吃货不会同时检查和使用桌子。
2. **看要不要下班**：如果总汉堡数 `count`为0，说明活干完了，用 `break`结束循环。
3. **看桌上情况干活**：
   - **如果桌上没汉堡 (`!Desk.flag`)**：这是厨师的工作信号！厨师就生产一个汉堡（打印消息），然后把标志 `Desk.flag`设为 `true`，表示“汉堡已上桌”。最后，**非常关键**：`Desk.lock.notifyAll()`大喊一声：“吃货快来吃！”，唤醒可能在等待的吃货线程。
   - **如果桌上有汉堡 (`Desk.flag`为 `true`)**：厨师没事干，就调用 `Desk.lock.wait()`，**放下钥匙去休息室睡觉**，直到被吃货唤醒。

#### 😋 消费者：Foodie 类（吃货）

吃货的逻辑和厨师对称：

1. **先抢“钥匙”**：同样是 `synchronized (Desk.lock)`。
2. **看餐厅还营不营业**：同样是检查 `Desk.count`是否为0。
3. **看桌上情况开吃**：
   - **如果桌上有汉堡 (`Desk.flag`)**：吃货就开吃（打印消息）。吃完后：
     - 把标志 `Desk.flag`设为 `false`，表示“汉堡没了”。
     - 用 `Desk.lock.notifyAll()`大喊：“厨师，别睡了，起来做汉堡！”。
     - 将总汉堡数 `Desk.count`减1。
   - **如果桌上没汉堡**：吃货就调用 `wait()`去休息室等着。

#### 🎬 程序启动：Demo 类

`main`方法很简单，就是创建一位厨师和一个吃货，然后让他们开始工作：

```
Foodie f = new Foodie();
Cooker c = new Cooker();
f.start(); // 吃货线程开始运行（run方法）
c.start(); // 厨师线程开始运行（run方法）
```

#### ⚠️ 深入理解关键机制

1. **`wait()`和 `notifyAll()`的默契**

   - 当线程调用 `wait()`时，它会**释放已经持有的锁**（交出钥匙），然后进入等待状态，这样另一个线程才能拿到锁执行任务。
   - `notifyAll()`会唤醒**所有**正在等待这个锁的线程，让它们重新竞争锁。这里使用 `notifyAll()`而不是 `notify()`是为了更可靠，避免只唤醒一个同类线程而导致程序卡住的风险。

2. **为什么用 `while`循环而不是 `if`？**

   代码中检查 `flag`的条件是写在 `if`语句里，但更严谨的做法是使用 `while`循环进行条件判断，这是为了防御**虚假唤醒**——即线程可能在没有被其他线程调用 `notify()`的情况下被唤醒。用 `while`可以保证即使被虚假唤醒，也会再次检查条件是否真正满足。

3. **线程生命周期**

   程序运行时，厨师和吃货线程会根据 `flag`的状态和 `wait()`/`notifyAll()`的调用，在 **运行（Running）**、**等待（Waiting）** 等状态间切换，直到 `count`减到0，各自 `break`跳出循环，线程任务结束。

#### 💡 一个可能的执行场景

1. 程序开始，桌子是空的 (`flag = false`)。
2. 吃货线程先抢到钥匙，发现没汉堡 (`flag=false`)，于是调用 `wait()`释放钥匙去睡觉。
3. 厨师抢到钥匙，发现没汉堡，开始生产。生产完后设置 `flag=true`，并叫醒吃货。
4. 吃货被唤醒，和厨师重新抢钥匙。假设吃货抢到了，看到有汉堡，开始吃。吃完后设置 `flag=false`，`count`减1，并叫醒厨师。
5. 如此循环，直到 `count`从10减到0，两人都结束工作。

希望这个分步解释能帮助你理解这个经典的多线程程序！多线程编程需要仔细理解各个线程的协作和竞争关系，多思考几种执行流程会对理解有很大帮助。

### 3.4阻塞队列基本使用【理解】

+ 阻塞队列继承结构

  ![06_阻塞队列继承结构](JAVA第20章随记_多线程.assets/06_阻塞队列继承结构.png)


+ 常见BlockingQueue:

  ArrayBlockingQueue: 底层是数组,有界

  LinkedBlockingQueue: 底层是链表,无界.但不是真正的无界,最大为int的最大值

+ BlockingQueue的核心方法:

  put(anObject): 将参数放入队列,如果放不进去会阻塞

  take(): 取出第一个数据,取不到会阻塞

+ 代码示例

  ```java
  public class Demo02 {
      public static void main(String[] args) throws Exception {
          // 创建阻塞队列的对象,容量为 1
          ArrayBlockingQueue<String> arrayBlockingQueue = new ArrayBlockingQueue<>(1);
  
          // 存储元素
          arrayBlockingQueue.put("汉堡包");
  
          // 取元素
          System.out.println(arrayBlockingQueue.take());
          System.out.println(arrayBlockingQueue.take()); // 取不到会阻塞
  
          System.out.println("程序结束了");
      }
  }
  ```

### 3.5阻塞队列实现等待唤醒机制【理解】

+ 案例需求

  + 生产者类(Cooker)：实现Runnable接口，重写run()方法，设置线程任务

    1.构造方法中接收一个阻塞队列对象

    2.在run方法中循环向阻塞队列中添加包子

    3.打印添加结果

  + 消费者类(Foodie)：实现Runnable接口，重写run()方法，设置线程任务

    1.构造方法中接收一个阻塞队列对象

    2.在run方法中循环获取阻塞队列中的包子

    3.打印获取结果

  + 测试类(Demo)：里面有main方法，main方法中的代码步骤如下

    创建阻塞队列对象

    创建生产者线程和消费者线程对象,构造方法中传入阻塞队列对象

    分别开启两个线程

+ 代码实现

  ```java
  public class Cooker extends Thread {
  
      private ArrayBlockingQueue<String> bd;
  
      public Cooker(ArrayBlockingQueue<String> bd) {
          this.bd = bd;
      }
  //    生产者步骤：
  //            1，判断桌子上是否有汉堡包
  //    如果有就等待，如果没有才生产。
  //            2，把汉堡包放在桌子上。
  //            3，叫醒等待的消费者开吃。
  
      @Override
      public void run() {
          while (true) {
              try {
                  bd.put("汉堡包");
                  System.out.println("厨师放入一个汉堡包");
              } catch (InterruptedException e) {
                  e.printStackTrace();
              }
          }
      }
  }
  
  public class Foodie extends Thread {
      private ArrayBlockingQueue<String> bd;
  
      public Foodie(ArrayBlockingQueue<String> bd) {
          this.bd = bd;
      }
  
      @Override
      public void run() {
  //        1，判断桌子上是否有汉堡包。
  //        2，如果没有就等待。
  //        3，如果有就开吃
  //        4，吃完之后，桌子上的汉堡包就没有了
  //                叫醒等待的生产者继续生产
  //        汉堡包的总数量减一
  
          //套路:
          //1. while(true)死循环
          //2. synchronized 锁,锁对象要唯一
          //3. 判断,共享数据是否结束. 结束
          //4. 判断,共享数据是否结束. 没有结束
          while (true) {
              try {
                  String take = bd.take();
                  System.out.println("吃货将" + take + "拿出来吃了");
              } catch (InterruptedException e) {
                  e.printStackTrace();
              }
          }
  
      }
  }
  
  public class Demo {
      public static void main(String[] args) {
          ArrayBlockingQueue<String> bd = new ArrayBlockingQueue<>(1);
  
          Foodie f = new Foodie(bd);
          Cooker c = new Cooker(bd);
  
          f.start();
          c.start();
      }
  }
  ```

### 	3.6 线程的6种状态

![image-20251017115013438](JAVA第20章随记_多线程.assets/image-20251017115013438.png)

![image-20251017115123925](JAVA第20章随记_多线程.assets/image-20251017115123925.png)

## 4. 线程池

### 4.1 线程状态介绍

当线程被创建并启动以后，它既不是一启动就进入了执行状态，也不是一直处于执行状态。线程对象在不同的时期有不同的状态。那么Java中的线程存在哪几种状态呢？Java中的线程

状态被定义在了java.lang.Thread.State枚举类中，State枚举类的源码如下：

```java
public class Thread {
    
    public enum State {
    
        /* 新建 */
        NEW , 

        /* 可运行状态 */
        RUNNABLE , 

        /* 阻塞状态 */
        BLOCKED , 

        /* 无限等待状态 */
        WAITING , 

        /* 计时等待 */
        TIMED_WAITING , 

        /* 终止 */
        TERMINATED;
    
	}
    
    // 获取当前线程的状态
    public State getState() {
        return jdk.internal.misc.VM.toThreadState(threadStatus);
    }
    
}
```

通过源码我们可以看到Java中的线程存在6种状态，每种线程状态的含义如下

| 线程状态      | 具体含义                                                     |
| ------------- | ------------------------------------------------------------ |
| NEW           | 一个尚未启动的线程的状态。也称之为初始状态、开始状态。线程刚被创建，但是并未启动。还没调用start方法。MyThread t = new MyThread()只有线程象，没有线程特征。 |
| RUNNABLE      | 当我们调用线程对象的start方法，那么此时线程对象进入了RUNNABLE状态。那么此时才是真正的在JVM进程中创建了一个线程，线程一经启动并不是立即得到执行，线程的运行与否要听令与CPU的调度，那么我们把这个中间状态称之为可执行状态(RUNNABLE)也就是说它具备执行的资格，但是并没有真正的执行起来而是在等待CPU的度。 |
| BLOCKED       | 当一个线程试图获取一个对象锁，而该对象锁被其他的线程持有，则该线程进入Blocked状态；当该线程持有锁时，该线程将变成Runnable状态。 |
| WAITING       | 一个正在等待的线程的状态。也称之为等待状态。造成线程等待的原因有两种，分别是调用Object.wait()、join()方法。处于等待状态的线程，正在等待其他线程去执行一个特定的操作。例如：因为wait()而等待的线程正在等待另一个线程去调用notify()或notifyAll()；一个因为join()而等待的线程正在等待另一个线程结束。 |
| TIMED_WAITING | 一个在限定时间内等待的线程的状态。也称之为限时等待状态。造成线程限时等待状态的原因有三种，分别是：Thread.sleep(long)，Object.wait(long)、join(long)。 |
| TERMINATED    | 一个完全运行完成的线程的状态。也称之为终止状态、结束状态     |

各个状态的转换，如下图所示：

![1591163781941](JAVA第20章随记_多线程.assets/1591163781941.png)

### 4.2 线程池-基本原理

**概述 :** 

​	提到池，大家应该能想到的就是水池。水池就是一个容器，在该容器中存储了很多的水。那么什么是线程池呢？线程池也是可以看做成一个池子，在该池子中存储很多个线程。

线程池存在的意义：

​	系统创建一个线程的成本是比较高的，因为它涉及到与操作系统交互，当程序中需要创建大量生存期很短暂的线程时，频繁的创建和销毁线程对系统的资源消耗有可能大于业务处理是对系

​	统资源的消耗，这样就有点"舍本逐末"了。针对这一种情况，为了提高性能，我们就可以采用线程池。线程池在启动的时，会创建大量空闲线程，当我们向线程池提交任务的时，线程池就

​	会启动一个线程来执行该任务。等待任务执行完毕以后，线程并不会死亡，而是再次返回到线程池中称为空闲状态。等待下一次任务的执行。

**线程池的设计思路 :**

1. 准备一个任务容器
2. 一次性启动多个(2个)消费者线程
3. 刚开始任务容器是空的，所以线程都在wait
4. 直到一个外部线程向这个任务容器中扔了一个"任务"，就会有一个消费者线程被唤醒
5. 这个消费者线程取出"任务"，并且执行这个任务，执行完毕后，继续等待下一次任务的到来

### 4.3 线程池-Executors默认线程池

概述 : JDK对线程池也进行了相关的实现，在真实企业开发中我们也很少去自定义线程池，而是使用JDK中自带的线程池。

我们可以使用Executors中所提供的**静态**方法来创建线程池

​	static ExecutorService newCachedThreadPool()   创建一个默认的线程池
​	static newFixedThreadPool(int nThreads)	    创建一个指定最多线程数量的线程池

**代码实现 :** 

```java
package com.itheima.mythreadpool;


//static ExecutorService newCachedThreadPool()   创建一个默认的线程池
//static newFixedThreadPool(int nThreads)	    创建一个指定最多线程数量的线程池

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class MyThreadPoolDemo {
    public static void main(String[] args) throws InterruptedException {

        //1,创建一个默认的线程池对象.池子中默认是空的.默认最多可以容纳int类型的最大值.
        ExecutorService executorService = Executors.newCachedThreadPool();
        //Executors --- 可以帮助我们创建线程池对象
        //ExecutorService --- 可以帮助我们控制线程池

        executorService.submit(()->{
            System.out.println(Thread.currentThread().getName() + "在执行了");
        });

        //Thread.sleep(2000);

        executorService.submit(()->{
            System.out.println(Thread.currentThread().getName() + "在执行了");
        });

        executorService.shutdown();
    }
}

```



### 4.4 线程池-Executors创建指定上限的线程池

**使用Executors中所提供的静态方法来创建线程池**

​	static ExecutorService newFixedThreadPool(int nThreads) : 创建一个指定最多线程数量的线程池

**代码实现 :** 

```java
package com.itheima.mythreadpool;

//static ExecutorService newFixedThreadPool(int nThreads)
//创建一个指定最多线程数量的线程池

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;

public class MyThreadPoolDemo2 {
    public static void main(String[] args) {
        //参数不是初始值而是最大值
        ExecutorService executorService = Executors.newFixedThreadPool(10);

        ThreadPoolExecutor pool = (ThreadPoolExecutor) executorService;
        System.out.println(pool.getPoolSize());//0

        executorService.submit(()->{
            System.out.println(Thread.currentThread().getName() + "在执行了");
        });

        executorService.submit(()->{
            System.out.println(Thread.currentThread().getName() + "在执行了");
        });

        System.out.println(pool.getPoolSize());//2
//        executorService.shutdown();
    }
}

```



### 4.5 线程池-ThreadPoolExecutor

**创建线程池对象 :** 

ThreadPoolExecutor threadPoolExecutor = new ThreadPoolExecutor(核心线程数量,

​																															最大线程数量,
​																															空闲线程最大存活时间,

​																															任务队列,

​																															创建线程工厂,

​																															任务的拒绝策略);

**代码实现 :** 

```java
package com.itheima.mythreadpool;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class MyThreadPoolDemo3 {
//    参数一：核心线程数量
//    参数二：最大线程数
//    参数三：空闲线程最大存活时间
//    参数四：时间单位
//    参数五：任务队列
//    参数六：创建线程工厂
//    参数七：任务的拒绝策略
    public static void main(String[] args) {
        ThreadPoolExecutor pool = new ThreadPoolExecutor(2,5,2,TimeUnit.SECONDS,new ArrayBlockingQueue<>(10), Executors.defaultThreadFactory(),new ThreadPoolExecutor.AbortPolicy());
        pool.submit(new MyRunnable());
        pool.submit(new MyRunnable());

        pool.shutdown();
    }
}
```

### 4.6 自定义线程池-参数详解

![1591165506516](JAVA第20章随记_多线程.assets/1591165506516.png)

```java
public ThreadPoolExecutor(int corePoolSize,
                              int maximumPoolSize,
                              long keepAliveTime,
                              TimeUnit unit,
                              BlockingQueue<Runnable> workQueue,
                              ThreadFactory threadFactory,
                              RejectedExecutionHandler handler)
    
corePoolSize：   核心线程的最大值，不能小于0
maximumPoolSize：最大线程数，不能小于等于0，maximumPoolSize >= corePoolSize
keepAliveTime：  空闲线程最大存活时间,不能小于0
unit：           时间单位
workQueue：      任务队列，不能为null
threadFactory：  创建线程工厂,不能为null      
handler：        任务的拒绝策略,不能为null  
```



### 4.7 线程池-非默认任务拒绝策略

!![image-20251020093343322](JAVA第20章随记_多线程.assets/image-20251020093343322.png)

RejectedExecutionHandler是jdk提供的一个任务拒绝策略接口，它下面存在4个子类。

```java
ThreadPoolExecutor.AbortPolicy: 		    丢弃任务并抛出RejectedExecutionException异常。是默认的策略。
ThreadPoolExecutor.DiscardPolicy： 		   丢弃任务，但是不抛出异常 这是不推荐的做法。
ThreadPoolExecutor.DiscardOldestPolicy：    抛弃队列中等待最久的任务 然后把当前任务加入队列中。
ThreadPoolExecutor.CallerRunsPolicy:        调用任务的run()方法绕过线程池直接执行。
```

注：明确线程池对多可执行的任务数 = 队列容量 + 最大线程数

**案例演示1**：演示ThreadPoolExecutor.AbortPolicy任务处理策略

```java
public class ThreadPoolExecutorDemo01 {

    public static void main(String[] args) {

        /**
         * 核心线程数量为1 ， 最大线程池数量为3, 任务容器的容量为1 ,空闲线程的最大存在时间为20s
         */
        ThreadPoolExecutor threadPoolExecutor = new ThreadPoolExecutor(1 , 3 , 20 , TimeUnit.SECONDS ,
                new ArrayBlockingQueue<>(1) , Executors.defaultThreadFactory() , new ThreadPoolExecutor.AbortPolicy()) ;

        // 提交5个任务，而该线程池最多可以处理4个任务，当我们使用AbortPolicy这个任务处理策略的时候，就会抛出异常
        for(int x = 0 ; x < 5 ; x++) {
            threadPoolExecutor.submit(() -> {
                System.out.println(Thread.currentThread().getName() + "---->> 执行了任务");
            });
        }
    }
}
```

**控制台输出结果**

```java
pool-1-thread-1---->> 执行了任务
pool-1-thread-3---->> 执行了任务
pool-1-thread-2---->> 执行了任务
pool-1-thread-3---->> 执行了任务
```

控制台报错，仅仅执行了4个任务，有一个任务被丢弃了



**案例演示2**：演示ThreadPoolExecutor.DiscardPolicy任务处理策略

```java
public class ThreadPoolExecutorDemo02 {
    public static void main(String[] args) {
        /**
         * 核心线程数量为1 ， 最大线程池数量为3, 任务容器的容量为1 ,空闲线程的最大存在时间为20s
         */
        ThreadPoolExecutor threadPoolExecutor = new ThreadPoolExecutor(1 , 3 , 20 , TimeUnit.SECONDS ,
                new ArrayBlockingQueue<>(1) , Executors.defaultThreadFactory() , new ThreadPoolExecutor.DiscardPolicy()) ;

        // 提交5个任务，而该线程池最多可以处理4个任务，当我们使用DiscardPolicy这个任务处理策略的时候，控制台不会报错
        for(int x = 0 ; x < 5 ; x++) {
            threadPoolExecutor.submit(() -> {
                System.out.println(Thread.currentThread().getName() + "---->> 执行了任务");
            });
        }
    }
}
```

**控制台输出结果**

```java
pool-1-thread-1---->> 执行了任务
pool-1-thread-1---->> 执行了任务
pool-1-thread-3---->> 执行了任务
pool-1-thread-2---->> 执行了任务
```

控制台没有报错，仅仅执行了4个任务，有一个任务被丢弃了



**案例演示3**：演示ThreadPoolExecutor.DiscardOldestPolicy任务处理策略

```java
public class ThreadPoolExecutorDemo02 {
    public static void main(String[] args) {
        /**
         * 核心线程数量为1 ， 最大线程池数量为3, 任务容器的容量为1 ,空闲线程的最大存在时间为20s
         */
        ThreadPoolExecutor threadPoolExecutor;
        threadPoolExecutor = new ThreadPoolExecutor(1 , 3 , 20 , TimeUnit.SECONDS ,
                new ArrayBlockingQueue<>(1) , Executors.defaultThreadFactory() , new ThreadPoolExecutor.DiscardOldestPolicy());
        // 提交5个任务
        for(int x = 0 ; x < 5 ; x++) {
            // 定义一个变量，来指定指定当前执行的任务;这个变量需要被final修饰
            final int y = x ;
            threadPoolExecutor.submit(() -> {
                System.out.println(Thread.currentThread().getName() + "---->> 执行了任务" + y);
            });     
        }
    }
}
```

**控制台输出结果**

```java
pool-1-thread-2---->> 执行了任务2
pool-1-thread-1---->> 执行了任务0
pool-1-thread-3---->> 执行了任务3
pool-1-thread-1---->> 执行了任务4
```

由于任务1在线程池中等待时间最长，因此任务1被丢弃。



**案例演示4**：演示ThreadPoolExecutor.CallerRunsPolicy任务处理策略

```java
public class ThreadPoolExecutorDemo04 {
    public static void main(String[] args) {

        /**
         * 核心线程数量为1 ， 最大线程池数量为3, 任务容器的容量为1 ,空闲线程的最大存在时间为20s
         */
        ThreadPoolExecutor threadPoolExecutor;
        threadPoolExecutor = new ThreadPoolExecutor(1 , 3 , 20 , TimeUnit.SECONDS ,
                new ArrayBlockingQueue<>(1) , Executors.defaultThreadFactory() , new ThreadPoolExecutor.CallerRunsPolicy());

        // 提交5个任务
        for(int x = 0 ; x < 5 ; x++) {
            threadPoolExecutor.submit(() -> {
                System.out.println(Thread.currentThread().getName() + "---->> 执行了任务");
            });
        }
    }
}
```

**控制台输出结果**

```java
pool-1-thread-1---->> 执行了任务
pool-1-thread-3---->> 执行了任务
pool-1-thread-2---->> 执行了任务
pool-1-thread-1---->> 执行了任务
main---->> 执行了任务
```

通过控制台的输出，我们可以看到次策略没有通过线程池中的线程执行任务，而是直接调用任务的run()方法绕过线程池直接执行。

![image-20251020093950171](JAVA第20章随记_多线程.assets/image-20251020093950171.png)

### 4.8 线程池多大合适

![image-20251020094742568](JAVA第20章随记_多线程.assets/image-20251020094742568.png)

## 5.综合练习

![image-20251017115234003](JAVA第20章随记_多线程.assets/image-20251017115234003.png)

```java
package com.Thread_test;

public class test01 {
    public static void main(String[] args) {
        Ticket ticket = new Ticket();
        Thread s1 = new Thread(ticket, "一号口");
        Thread s2 = new Thread(ticket, "二号口");
        s1.start();
        s2.start();
    }
}

class Ticket implements Runnable {

    private int ticket = 1000;

    @Override
    public void run() {
        while (true) {
            synchronized (Ticket.class){
                if (ticket == 0) {
                    break;
                } else {
                    ticket--;
                    try {
                        Thread.sleep(3000);
                    } catch (InterruptedException e) {
                        throw new RuntimeException(e);
                    }
                    System.out.println(Thread.currentThread().getName() + "正在售卖，还剩下" + ticket + "张票");
                }
            }
        }
    }
}

```

![image-20251017120313970](JAVA第20章随记_多线程.assets/image-20251017120313970.png)

```java
public class GiftSender implements Runnable {
    private int gifts = 100; // 共享变量：总礼品数，初始100份

    @Override
    public void run() {
        while (true) {
            // 使用同步块确保线程安全，锁对象是当前实例(this)
            synchronized (this) {
                // 检查剩余礼品是否小于10份
                if (gifts < 10) {
                    System.out.println(Thread.currentThread().getName() + "停止发送，礼品不足10份");
                    break; // 退出循环
                } else {
                    // 发送一份礼品
                    gifts--; // 礼品数减1
                    System.out.println(Thread.currentThread().getName() + "发送一份礼品，剩余：" + gifts + "份");
                }
            }

            // 添加短暂延迟，模拟发送过程中的耗时
            try {
                Thread.sleep(50);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

public class Demo {
    public static void main(String[] args) {
        // 创建一个GiftSender任务实例（两个线程共享这一个实例）
        GiftSender sender = new GiftSender();

        // 创建两个线程，模拟两个人同时发送
        Thread t1 = new Thread(sender, "张三");
        Thread t2 = new Thread(sender, "李四");

        // 启动线程
        t1.start();
        t2.start();
    }
}
```

![image-20251017120550350](JAVA第20章随记_多线程.assets/image-20251017120550350.png)

```java
class Count implements Runnable {
    private int i = 0;

    @Override
    public void run() {
        while (true) {
            synchronized (Count.class) {
                if (i <= 1000) {
                    if (i % 2 != 0) {
                        System.out.println(Thread.currentThread().getName() +"正在计数"+ i);
                    }
                    i++;
                } else {
                    break;
                }
            }
        }
    }
}
```

![image-20251017123641596](JAVA第20章随记_多线程.assets/image-20251017123641596.png)

```java
package com.Thread_test;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Random;

public class test04 {
    public static void main(String[] args) {
        PrizePocket prizePocket = new PrizePocket();
        new Thread(prizePocket,"t1").start();
        new Thread(prizePocket,"t2").start();
        new Thread(prizePocket,"t3").start();
        new Thread(prizePocket,"t4").start();
        new Thread(prizePocket,"t5").start();

    }
}

class PrizePocket implements Runnable{
    BigDecimal money=new BigDecimal("100.00");
    private double MIN=0.01;
    private int count=3;
    @Override
    public void run() {
        synchronized (PrizePocket.class){
            if(count==0){
                System.out.println(Thread.currentThread().getName()+"没抢到红包");
            }else{//准备抢红包
                double prize=0;
                if(count==1){
                    prize=money.doubleValue();//最后一个红包就是所有钱
                    System.out.println("这是最后一个红包噢"+Thread.currentThread().getName()+"抢到了"+prize+"元");
                    count--;
                }else{
                    //开始随机
                    /**
                     * 当前总金额，减去(剩余的红包个数 * 0.01)。为什么要这么做？这是为了确保在分了当前这个红包之后，
                     * 剩下的钱还足够让后面每个没抢的红包至少都有1分钱。
                     * 比如100元分5个，分给第一个人时，要确保后面4个人每人至少有1分钱，
                     * 所以第一个人最多能抢 100 - 4 * 0.01 = 99.96元。
                     */
                    Random random = new Random();
                    //允许分配的最大金额=money-(剩余红包数)*每个红包最小值0.01
                    BigDecimal maxMoney = money.subtract(new BigDecimal(count - 1).multiply(new BigDecimal("0.01")));
                    //生成当前红包的随机金额
                    BigDecimal RandomMoney = new BigDecimal("0.01")
                            .add(new BigDecimal(random.nextDouble()).multiply(maxMoney))
                            .setScale(2, RoundingMode.HALF_UP);
                    money=money.subtract(RandomMoney);
                    prize=RandomMoney.doubleValue();
                    count--;
                    System.out.println(Thread.currentThread().getName()+"抢到了"+prize+"元");
                }
            }
        }
    }
}

```

![image-20251017152558501](JAVA第20章随记_多线程.assets/image-20251017152558501.png)

```java
package com.Thread_test;

import java.util.ArrayList;
import java.util.Collections;

public class test05 {
    public static void main(String[] args) {
        ArrayList<Integer> list = new ArrayList<>();
        Collections.addAll(list,10,5,20,700,100,30,40,0,0,0,10,10,10,10,20,20,20,20,20,1000);
        PrizeBocket prizeBocket = new PrizeBocket(list);
        new Thread(prizeBocket,"抽奖箱1").start();
        new Thread(prizeBocket,"抽奖箱2").start();

    }
}
class PrizeBocket implements Runnable{

    ArrayList<Integer> list;
    public PrizeBocket(ArrayList<Integer> list) {
        this.list = list;
    }
    @Override
    public void run() {
     while (true){
         synchronized (PrizeBocket.class){
             if(list.isEmpty()){
                 break;
             }else {
                 Collections.shuffle(list);
                 Integer prize = list.remove(0);
                 System.out.println(Thread.currentThread().getName()+"产生了一个"+prize+"奖励");
             }
         }
         try {
             Thread.sleep(200);
         } catch (InterruptedException e) {
             throw new RuntimeException(e);
         }
     }
    }
}

```

![image-20251017154545660](JAVA第20章随记_多线程.assets/image-20251017154545660.png)

```java
package com.Thread_test;

import java.util.ArrayList;
import java.util.Collections;

public class test05 {
    public static void main(String[] args) {
        ArrayList<Integer> list = new ArrayList<>();
        Collections.addAll(list,10,20,30,40,50,60,70,80,90,100);
        PrizeBocket prizeBocket = new PrizeBocket(list);
        new Thread(prizeBocket,"抽奖箱1").start();
        new Thread(prizeBocket,"抽奖箱2").start();

    }
}
class PrizeBocket implements Runnable{

    ArrayList<Integer> list;
    //缺点：每多一个抽奖箱就要多创建一个arr 麻烦
    //新建抽奖箱1的集合储存器
    ArrayList<Integer> arr1=new ArrayList<>();
    //新建抽奖箱2的集合储存器
    ArrayList<Integer> arr2=new ArrayList<>();
    public PrizeBocket(ArrayList<Integer> list) {
        this.list = list;
    }
    @Override
    public void run() {
     while (true){
         synchronized (PrizeBocket.class){
             if(list.isEmpty()){
                 if("抽奖箱1".equals(Thread.currentThread().getName())){
                     System.out.println(arr1);
                 }else {
                     System.out.println(arr2);
                 }
                 break;
             }else {
                 Collections.shuffle(list);
                 Integer prize = list.remove(0);
                 if("抽奖箱1".equals(Thread.currentThread().getName())){
                     arr1.add(prize);
                 }else {
                     arr2.add(prize);
                 }
                 //System.out.println(Thread.currentThread().getName()+"产生了一个"+prize+"奖励");
             }
         }
         try {
             Thread.sleep(200);
         } catch (InterruptedException e) {
             throw new RuntimeException(e);
         }
     }
    }
}

```

缺点：每多一个抽奖箱就要多创建一个arr 麻烦

```java
package com.Thread_test;

import java.util.ArrayList;
import java.util.Collections;

public class test05 {
    public static void main(String[] args) {
        ArrayList<Integer> list = new ArrayList<>();
        Collections.addAll(list,10,20,30,40,50,60,70,80,90,100);
        PrizeBocket prizeBocket = new PrizeBocket(list);
        new Thread(prizeBocket,"抽奖箱1").start();
        new Thread(prizeBocket,"抽奖箱2").start();

    }
}
class PrizeBocket implements Runnable{

    ArrayList<Integer> list;
    //新建抽奖箱1的集合储存器
    //ArrayList<Integer> arr1=new ArrayList<>();
    //新建抽奖箱2的集合储存器
    //ArrayList<Integer> arr2=new ArrayList<>();
    public PrizeBocket(ArrayList<Integer> list) {
        this.list = list;
    }
    @Override
    public void run() {
        ArrayList<Integer> arr=new ArrayList<>();
     while (true){
         synchronized (PrizeBocket.class){
             if(list.isEmpty()){
                 System.out.println(Thread.currentThread().getName()+arr);
                 break;
             }else {
                 Collections.shuffle(list);
                 Integer prize = list.remove(0);
                 arr.add(prize);
                 //System.out.println(Thread.currentThread().getName()+"产生了一个"+prize+"奖励");
             }
         }
         try {
             Thread.sleep(200);
         } catch (InterruptedException e) {
             throw new RuntimeException(e);
         }
     }
    }
}
```

| 特性对比     | `ArrayList<Integer> arr = new ArrayList<>();`**放在 run 方法内（正确做法）** | `ArrayList<Integer> arr = new ArrayList<>();`**作为成员变量（错误做法）** |
| :----------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| **变量类型** | **局部变量**                                                 | **成员变量（实例变量）**                                     |
| **作用域**   | 仅限于其所在的 `run`方法内部 。                              | 在整个 `PrizeBocket`**类实例**内部可见。                     |
| **内存位置** | 存储于**线程栈**内存中。每个线程都有自己独立的栈空间 。      | 存储于**堆**内存中，与所属的对象实例在一起。                 |
| **共享性**   | **线程私有**。每个线程执行 `run`方法时，都会在各自的栈上创建**一个全新的、独立的** `arr`列表。它们互不相干 。 | **线程共享**。因为两个线程使用的是**同一个** `prizeBocket`实例，所以它们操作的是**堆中同一个** `arr`列表对象。 |
| **线程安全** | **天然线程安全**。因为数据不共享，不存在竞争条件，无需同步 。 | **非线程安全**。多个线程并发修改同一个集合，会导致数据错乱（如数据覆盖、丢失）或抛出异常 。 |
| **图示理解** | 每个线程有一个独立的抽奖袋。                                 | 所有线程共用一个公共的抽奖袋                                 |

![image-20251017165453109](JAVA第20章随记_多线程.assets/image-20251017165453109.png)

```java
package com.Thread_test;

import java.util.ArrayList;
import java.util.Collections;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;

public class test07 {
    public static void main(String[] args) throws ExecutionException, InterruptedException {
        ArrayList<Integer> list = new ArrayList<>();
        Collections.addAll(list,10,20,30,40,50,60,70,80,90);
        MyCallable mc1 = new MyCallable(list);
        MyCallable mc2 = new MyCallable(list);
        FutureTask ft1 = new FutureTask(mc1);
        FutureTask ft2 = new FutureTask(mc2);
        Thread t1 = new Thread(ft1, "一");
        Thread t2 = new Thread(ft2, "二");
        t1.start();
        t2.start();
        int max1= (int) ft1.get();
        int max2= (int) ft2.get();
        System.out.println(max1);
        System.out.println(max2);
        System.out.println();
    }
}
class MyCallable implements Callable<Integer>{
    ArrayList<Integer> list;

    public MyCallable(ArrayList<Integer> list) {
        this.list = list;
    }

    @Override
    public Integer call() throws Exception {
        ArrayList<Integer> arr = new ArrayList<>();
        while (true){
            synchronized (MyCallable.class){
                if(list.isEmpty()){
                    break;
                }else{
                    Collections.shuffle(list);
                    Integer prize = list.remove(0);
                    arr.add(prize);
                }
            }
        }
        System.out.println(Thread.currentThread().getName()+arr);
        return Collections.max(arr);
    }
}

```

## 6. 原子性(面试再看)

### 6.1 volatile-问题

**代码分析 :** 

```java
package com.itheima.myvolatile;

public class Demo {
    public static void main(String[] args) {
        MyThread1 t1 = new MyThread1();
        t1.setName("小路同学");
        t1.start();

        MyThread2 t2 = new MyThread2();
        t2.setName("小皮同学");
        t2.start();
    }
}
```

```java
package com.itheima.myvolatile;

public class Money {
    public static int money = 100000;
}
```

```java
package com.itheima.myvolatile;

public class MyThread1 extends  Thread {
    @Override
    public void run() {
        while(Money.money == 100000){

        }

        System.out.println("结婚基金已经不是十万了");
    }
}

```

```java
package com.itheima.myvolatile;

public class MyThread2 extends Thread {
    @Override
    public void run() {
        try {
            Thread.sleep(10);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        Money.money = 90000;
    }
}

```

**程序问题 :**  女孩虽然知道结婚基金是十万，但是当基金的余额发生变化的时候，女孩无法知道最新的余额。



### 6.2 volatile解决

**以上案例出现的问题 :**

​	当A线程修改了共享数据时，B线程没有及时获取到最新的值，如果还在使用原先的值，就会出现问题 

​	1，堆内存是唯一的，每一个线程都有自己的线程栈。

​	2 ，每一个线程在使用堆里面变量的时候，都会先拷贝一份到变量的副本中。

​	3 ，在线程中，每一次使用是从变量的副本中获取的。

**Volatile关键字 :** 强制线程每次在使用的时候，都会看一下共享区域最新的值

**代码实现 :** **使用volatile关键字解决**

```java
package com.itheima.myvolatile;

public class Demo {
    public static void main(String[] args) {
        MyThread1 t1 = new MyThread1();
        t1.setName("小路同学");
        t1.start();

        MyThread2 t2 = new MyThread2();
        t2.setName("小皮同学");
        t2.start();
    }
}
```

```java
package com.itheima.myvolatile;

public class Money {
    public static volatile int money = 100000;
}
```

```java
package com.itheima.myvolatile;

public class MyThread1 extends  Thread {
    @Override
    public void run() {
        while(Money.money == 100000){

        }

        System.out.println("结婚基金已经不是十万了");
    }
}

```

```java
package com.itheima.myvolatile;

public class MyThread2 extends Thread {
    @Override
    public void run() {
        try {
            Thread.sleep(10);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        Money.money = 90000;
    }
}

```



### 6.3 synchronized解决

**synchronized解决 :** 

​	1 ，线程获得锁

​	2 ，清空变量副本

​	3 ，拷贝共享变量最新的值到变量副本中

​	4 ，执行代码

​	5 ，将修改后变量副本中的值赋值给共享数据

​	6 ，释放锁

**代码实现 :** 

```java
package com.itheima.myvolatile2;

public class Demo {
    public static void main(String[] args) {
        MyThread1 t1 = new MyThread1();
        t1.setName("小路同学");
        t1.start();

        MyThread2 t2 = new MyThread2();
        t2.setName("小皮同学");
        t2.start();
    }
}
```

```java
package com.itheima.myvolatile2;

public class Money {
    public static Object lock = new Object();
    public static volatile int money = 100000;
}
```

```java
package com.itheima.myvolatile2;

public class MyThread1 extends  Thread {
    @Override
    public void run() {
        while(true){
            synchronized (Money.lock){
                if(Money.money != 100000){
                    System.out.println("结婚基金已经不是十万了");
                    break;
                }
            }
        }
    }
}
```

```java
package com.itheima.myvolatile2;

public class MyThread2 extends Thread {
    @Override
    public void run() {
        synchronized (Money.lock) {
            try {
                Thread.sleep(10);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            Money.money = 90000;
        }
    }
}
```



### 6.4 原子性

**概述 :** 所谓的原子性是指在一次操作或者多次操作中，要么所有的操作全部都得到了执行并且不会受到任何因素的干扰而中断，要么所有的操作都不执行，多个操作是一个不可以分割的整体。

**代码实现 :** 

```java
package com.itheima.threadatom;

public class AtomDemo {
    public static void main(String[] args) {
        MyAtomThread atom = new MyAtomThread();

        for (int i = 0; i < 100; i++) {
            new Thread(atom).start();
        }
    }
}
class MyAtomThread implements Runnable {
    private volatile int count = 0; //送冰淇淋的数量

    @Override
    public void run() {
        for (int i = 0; i < 100; i++) {
            //1,从共享数据中读取数据到本线程栈中.
            //2,修改本线程栈中变量副本的值
            //3,会把本线程栈中变量副本的值赋值给共享数据.
            count++;
            System.out.println("已经送了" + count + "个冰淇淋");
        }
    }
}
```

**代码总结 :** count++ 不是一个原子性操作, 他在执行的过程中,有可能被其他线程打断



### 6.5 volatile关键字不能保证原子性

解决方案 : 我们可以给count++操作添加锁，那么count++操作就是临界区中的代码，临界区中的代码一次只能被一个线程去执行，所以count++就变成了原子操作。

```java
package com.itheima.threadatom2;

public class AtomDemo {
    public static void main(String[] args) {
        MyAtomThread atom = new MyAtomThread();

        for (int i = 0; i < 100; i++) {
            new Thread(atom).start();
        }
    }
}
class MyAtomThread implements Runnable {
    private volatile int count = 0; //送冰淇淋的数量
    private Object lock = new Object();

    @Override
    public void run() {
        for (int i = 0; i < 100; i++) {
            //1,从共享数据中读取数据到本线程栈中.
            //2,修改本线程栈中变量副本的值
            //3,会把本线程栈中变量副本的值赋值给共享数据.
            synchronized (lock) {
                count++;
                System.out.println("已经送了" + count + "个冰淇淋");
            }
        }
    }
}
```



### 6.6 原子性_AtomicInteger

概述：java从JDK1.5开始提供了java.util.concurrent.atomic包(简称Atomic包)，这个包中的原子操作类提供了一种用法简单，性能高效，线程安全地更新一个变量的方式。因为变

量的类型有很多种，所以在Atomic包里一共提供了13个类，属于4种类型的原子更新方式，分别是原子更新基本类型、原子更新数组、原子更新引用和原子更新属性(字段)。本次我们只讲解

使用原子的方式更新基本类型，使用原子的方式更新基本类型Atomic包提供了以下3个类：

AtomicBoolean： 原子更新布尔类型

AtomicInteger：   原子更新整型

AtomicLong：	原子更新长整型

以上3个类提供的方法几乎一模一样，所以本节仅以AtomicInteger为例进行讲解，AtomicInteger的常用方法如下：

```java
public AtomicInteger()：	   			    初始化一个默认值为0的原子型Integer
public AtomicInteger(int initialValue)：  初始化一个指定值的原子型Integer

int get():   			 				获取值
int getAndIncrement():      			 以原子方式将当前值加1，注意，这里返回的是自增前的值。
int incrementAndGet():     				 以原子方式将当前值加1，注意，这里返回的是自增后的值。
int addAndGet(int data):				 以原子方式将输入的数值与实例中的值（AtomicInteger里的value）相加，并返回结果。
int getAndSet(int value):   			 以原子方式设置为newValue的值，并返回旧值。
```

**代码实现 :**

```java
package com.itheima.threadatom3;

import java.util.concurrent.atomic.AtomicInteger;

public class MyAtomIntergerDemo1 {
//    public AtomicInteger()：	               初始化一个默认值为0的原子型Integer
//    public AtomicInteger(int initialValue)： 初始化一个指定值的原子型Integer
    public static void main(String[] args) {
        AtomicInteger ac = new AtomicInteger();
        System.out.println(ac);

        AtomicInteger ac2 = new AtomicInteger(10);
        System.out.println(ac2);
    }

}
```

```java
package com.itheima.threadatom3;

import java.lang.reflect.Field;
import java.util.concurrent.atomic.AtomicInteger;

public class MyAtomIntergerDemo2 {
//    int get():   		 		获取值
//    int getAndIncrement():     以原子方式将当前值加1，注意，这里返回的是自增前的值。
//    int incrementAndGet():     以原子方式将当前值加1，注意，这里返回的是自增后的值。
//    int addAndGet(int data):	 以原子方式将参数与对象中的值相加，并返回结果。
//    int getAndSet(int value):  以原子方式设置为newValue的值，并返回旧值。
    public static void main(String[] args) {
//        AtomicInteger ac1 = new AtomicInteger(10);
//        System.out.println(ac1.get());

//        AtomicInteger ac2 = new AtomicInteger(10);
//        int andIncrement = ac2.getAndIncrement();
//        System.out.println(andIncrement);
//        System.out.println(ac2.get());

//        AtomicInteger ac3 = new AtomicInteger(10);
//        int i = ac3.incrementAndGet();
//        System.out.println(i);//自增后的值
//        System.out.println(ac3.get());

//        AtomicInteger ac4 = new AtomicInteger(10);
//        int i = ac4.addAndGet(20);
//        System.out.println(i);
//        System.out.println(ac4.get());

        AtomicInteger ac5 = new AtomicInteger(100);
        int andSet = ac5.getAndSet(20);
        System.out.println(andSet);
        System.out.println(ac5.get());
    }
}
```



### 6.7 AtomicInteger-内存解析

**AtomicInteger原理 :** 自旋锁  + CAS 算法

**CAS算法：**

​	有3个操作数（内存值V， 旧的预期值A，要修改的值B）

​	当旧的预期值A == 内存值   此时修改成功，将V改为B                 

​	当旧的预期值A！=内存值   此时修改失败，不做任何操作                 

​	并重新获取现在的最新值（这个重新获取的动作就是自旋）

### 6.8 AtomicInteger-源码解析

**代码实现 :**

```java
package com.itheima.threadatom4;

public class AtomDemo {
    public static void main(String[] args) {
        MyAtomThread atom = new MyAtomThread();

        for (int i = 0; i < 100; i++) {
            new Thread(atom).start();
        }
    }
}
```

```java
package com.itheima.threadatom4;

import java.util.concurrent.atomic.AtomicInteger;

public class MyAtomThread implements Runnable {
    //private volatile int count = 0; //送冰淇淋的数量
    //private Object lock = new Object();
    AtomicInteger ac = new AtomicInteger(0);

    @Override
    public void run() {
        for (int i = 0; i < 100; i++) {
            //1,从共享数据中读取数据到本线程栈中.
            //2,修改本线程栈中变量副本的值
            //3,会把本线程栈中变量副本的值赋值给共享数据.
            //synchronized (lock) {
//                count++;
//                ac++;
            int count = ac.incrementAndGet();
            System.out.println("已经送了" + count + "个冰淇淋");
           // }
        }
    }
}

```

**源码解析 :** 

```java
//先自增，然后获取自增后的结果
public final int incrementAndGet() {
        //+ 1 自增后的结果
        //this 就表示当前的atomicInteger（值）
        //1    自增一次
        return U.getAndAddInt(this, VALUE, 1) + 1;
}

public final int getAndAddInt(Object o, long offset, int delta) {
        //v 旧值
        int v;
        //自旋的过程
        do {
            //不断的获取旧值
            v = getIntVolatile(o, offset);
            //如果这个方法的返回值为false，那么继续自旋
            //如果这个方法的返回值为true，那么自旋结束
            //o 表示的就是内存值
            //v 旧值
            //v + delta 修改后的值
        } while (!weakCompareAndSetInt(o, offset, v, v + delta));
            //作用：比较内存中的值，旧值是否相等，如果相等就把修改后的值写到内存中，返回true。表示修改成功。
            //                                 如果不相等，无法把修改后的值写到内存中，返回false。表示修改失败。
            //如果修改失败，那么继续自旋。
        return v;
}
```



### 6.9 悲观锁和乐观锁

**synchronized和CAS的区别 :** 

**相同点：**在多线程情况下，都可以保证共享数据的安全性。

**不同点：**synchronized总是从最坏的角度出发，认为每次获取数据的时候，别人都有可能修改。所以在每                       次操作共享数据之前，都会上锁。（悲观锁）

​	cas是从乐观的角度出发，假设每次获取数据别人都不会修改，所以不会上锁。只不过在修改共享数据的时候，会检查一下，别人有没有修改过这个数据。

​	如果别人修改过，那么我再次获取现在最新的值。            

​	 如果别人没有修改过，那么我现在直接修改共享数据的值.(乐观锁）



## 7. 并发工具类(面试再看)

### 7.1 并发工具类-Hashtable

​	**Hashtable出现的原因 :** 在集合类中HashMap是比较常用的集合对象，但是HashMap是线程不安全的(多线程环境下可能会存在问题)。为了保证数据的安全性我们可以使用Hashtable，但是Hashtable的效率低下。

**代码实现 :** 

```java
package com.itheima.mymap;

import java.util.HashMap;
import java.util.Hashtable;

public class MyHashtableDemo {
    public static void main(String[] args) throws InterruptedException {
        Hashtable<String, String> hm = new Hashtable<>();

        Thread t1 = new Thread(() -> {
            for (int i = 0; i < 25; i++) {
                hm.put(i + "", i + "");
            }
        });


        Thread t2 = new Thread(() -> {
            for (int i = 25; i < 51; i++) {
                hm.put(i + "", i + "");
            }
        });

        t1.start();
        t2.start();

        System.out.println("----------------------------");
        //为了t1和t2能把数据全部添加完毕
        Thread.sleep(1000);

        //0-0 1-1 ..... 50- 50

        for (int i = 0; i < 51; i++) {
            System.out.println(hm.get(i + ""));
        }//0 1 2 3 .... 50


    }
}
```



### 7.2 并发工具类-ConcurrentHashMap基本使用

​	**ConcurrentHashMap出现的原因 :** 在集合类中HashMap是比较常用的集合对象，但是HashMap是线程不安全的(多线程环境下可能会存在问题)。为了保证数据的安全性我们可以使用Hashtable，但是Hashtable的效率低下。

基于以上两个原因我们可以使用JDK1.5以后所提供的ConcurrentHashMap。

**体系结构 :** 

![1591168965857](JAVA第20章随记_多线程.assets/1591168965857.png)

**总结 :** 

​	1 ，HashMap是线程不安全的。多线程环境下会有数据安全问题

​	2 ，Hashtable是线程安全的，但是会将整张表锁起来，效率低下

​	3，ConcurrentHashMap也是线程安全的，效率较高。     在JDK7和JDK8中，底层原理不一样。

**代码实现 :** 

```java
package com.itheima.mymap;

import java.util.Hashtable;
import java.util.concurrent.ConcurrentHashMap;

public class MyConcurrentHashMapDemo {
    public static void main(String[] args) throws InterruptedException {
        ConcurrentHashMap<String, String> hm = new ConcurrentHashMap<>(100);

        Thread t1 = new Thread(() -> {
            for (int i = 0; i < 25; i++) {
                hm.put(i + "", i + "");
            }
        });


        Thread t2 = new Thread(() -> {
            for (int i = 25; i < 51; i++) {
                hm.put(i + "", i + "");
            }
        });

        t1.start();
        t2.start();

        System.out.println("----------------------------");
        //为了t1和t2能把数据全部添加完毕
        Thread.sleep(1000);

        //0-0 1-1 ..... 50- 50

        for (int i = 0; i < 51; i++) {
            System.out.println(hm.get(i + ""));
        }//0 1 2 3 .... 50
    }
}
```



### 7.3 并发工具类-ConcurrentHashMap1.7原理

![1591169254280](JAVA第20章随记_多线程.assets/1591169254280.png)

### 7.4 并发工具类-ConcurrentHashMap1.8原理

![1591169338256](JAVA第20章随记_多线程.assets/1591169338256.png)

**总结 :** 

​	1，如果使用空参构造创建ConcurrentHashMap对象，则什么事情都不做。     在第一次添加元素的时候创建哈希表

​	2，计算当前元素应存入的索引。

​	3，如果该索引位置为null，则利用cas算法，将本结点添加到数组中。

​	4，如果该索引位置不为null，则利用volatile关键字获得当前位置最新的结点地址，挂在他下面，变成链表。		

​	5，当链表的长度大于等于8时，自动转换成红黑树6，以链表或者红黑树头结点为锁对象，配合悲观锁保证多线程操作集合时数据的安全性

### 7.5 并发工具类-CountDownLatch

**CountDownLatch类 :** 		

| 方法                             | 解释                             |
| -------------------------------- | -------------------------------- |
| public CountDownLatch(int count) | 参数传递线程数，表示等待线程数量 |
| public void await()              | 让线程等待                       |
| public void countDown()          | 当前线程执行完毕                 |

**使用场景：** 让某一条线程等待其他线程执行完毕之后再执行

**代码实现 :** 

```java
package com.itheima.mycountdownlatch;

import java.util.concurrent.CountDownLatch;

public class ChileThread1 extends Thread {

    private CountDownLatch countDownLatch;
    public ChileThread1(CountDownLatch countDownLatch) {
        this.countDownLatch = countDownLatch;
    }

    @Override
    public void run() {
        //1.吃饺子
        for (int i = 1; i <= 10; i++) {
            System.out.println(getName() + "在吃第" + i + "个饺子");
        }
        //2.吃完说一声
        //每一次countDown方法的时候，就让计数器-1
        countDownLatch.countDown();
    }
}

```

```java
package com.itheima.mycountdownlatch;

import java.util.concurrent.CountDownLatch;

public class ChileThread2 extends Thread {

    private CountDownLatch countDownLatch;
    public ChileThread2(CountDownLatch countDownLatch) {
        this.countDownLatch = countDownLatch;
    }
    @Override
    public void run() {
        //1.吃饺子
        for (int i = 1; i <= 15; i++) {
            System.out.println(getName() + "在吃第" + i + "个饺子");
        }
        //2.吃完说一声
        //每一次countDown方法的时候，就让计数器-1
        countDownLatch.countDown();
    }
}

```

```java
package com.itheima.mycountdownlatch;

import java.util.concurrent.CountDownLatch;

public class ChileThread3 extends Thread {

    private CountDownLatch countDownLatch;
    public ChileThread3(CountDownLatch countDownLatch) {
        this.countDownLatch = countDownLatch;
    }
    @Override
    public void run() {
        //1.吃饺子
        for (int i = 1; i <= 20; i++) {
            System.out.println(getName() + "在吃第" + i + "个饺子");
        }
        //2.吃完说一声
        //每一次countDown方法的时候，就让计数器-1
        countDownLatch.countDown();
    }
}

```

```java
package com.itheima.mycountdownlatch;

import java.util.concurrent.CountDownLatch;

public class MotherThread extends Thread {
    private CountDownLatch countDownLatch;
    public MotherThread(CountDownLatch countDownLatch) {
        this.countDownLatch = countDownLatch;
    }

    @Override
    public void run() {
        //1.等待
        try {
            //当计数器变成0的时候，会自动唤醒这里等待的线程。
            countDownLatch.await();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        //2.收拾碗筷
        System.out.println("妈妈在收拾碗筷");
    }
}

```

```java
package com.itheima.mycountdownlatch;

import java.util.concurrent.CountDownLatch;

public class MyCountDownLatchDemo {
    public static void main(String[] args) {
        //1.创建CountDownLatch的对象，需要传递给四个线程。
        //在底层就定义了一个计数器，此时计数器的值就是3
        CountDownLatch countDownLatch = new CountDownLatch(3);
        //2.创建四个线程对象并开启他们。
        MotherThread motherThread = new MotherThread(countDownLatch);
        motherThread.start();

        ChileThread1 t1 = new ChileThread1(countDownLatch);
        t1.setName("小明");

        ChileThread2 t2 = new ChileThread2(countDownLatch);
        t2.setName("小红");

        ChileThread3 t3 = new ChileThread3(countDownLatch);
        t3.setName("小刚");

        t1.start();
        t2.start();
        t3.start();
    }
}
```

**总结 :** 

​	1. CountDownLatch(int count)：参数写等待线程的数量。并定义了一个计数器。

​	2. await()：让线程等待，当计数器为0时，会唤醒等待的线程

​	3. countDown()： 线程执行完毕时调用，会将计数器-1。

### 3.6 并发工具类-Semaphore

**使用场景 :** 

​	可以控制访问特定资源的线程数量。

**实现步骤 :** 

​	1，需要有人管理这个通道

​	2，当有车进来了，发通行许可证

​	3，当车出去了，收回通行许可证

​	4，如果通行许可证发完了，那么其他车辆只能等着

**代码实现 :** 

```java
package com.itheima.mysemaphore;

import java.util.concurrent.Semaphore;

public class MyRunnable implements Runnable {
    //1.获得管理员对象，
    private Semaphore semaphore = new Semaphore(2);
    @Override
    public void run() {
        //2.获得通行证
        try {
            semaphore.acquire();
            //3.开始行驶
            System.out.println("获得了通行证开始行驶");
            Thread.sleep(2000);
            System.out.println("归还通行证");
            //4.归还通行证
            semaphore.release();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}

```

```java
package com.itheima.mysemaphore;

public class MySemaphoreDemo {
    public static void main(String[] args) {
        MyRunnable mr = new MyRunnable();

        for (int i = 0; i < 100; i++) {
            new Thread(mr).start();
        }
    }
}
```



