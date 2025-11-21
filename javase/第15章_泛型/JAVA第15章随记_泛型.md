# JAVA第15章随记_泛型

## **1. 为什么需要泛型？—— 从需求说起**

**需求：** 我们需要一个类，可以用来存放不同类别的奖品。奖品可能是`Integer`类型的现金，也可能是`String`类型的实物名称。

**传统方法的问题：**

如果不使用泛型，我们可能需要为每种数据类型都写一个几乎一模一样的类，代码冗余，难以维护。

```java
// 为整数奖品写一个类
class PrizeInteger {
    private Integer content; // 奖品内容
    // ... getter, setter, 构造方法
}

// 为字符串奖品再写一个类
class PrizeString {
    private String content; // 奖品内容
    // ... 同样的getter, setter, 构造方法再来一遍
}

public class Main {
    public static void main(String[] args) {
        PrizeInteger cashPrize = new PrizeInteger(1000);
        PrizeString goodsPrize = new PrizeString("iPhone");
        // 问题：如果想存Double类型的奖品，又得新建一个PrizeDouble类！
    }
}
```

**问题分析：**

- **代码冗余**：逻辑完全相同的类，仅仅因为字段类型不同，就要重复编写。
- **类型不安全**：如果我们用一个通用的`Object`类型来存储，取出时需要强制转换，很容易出错。

```java
class Prize {
    private Object content; // 用Object可以存任何东西

    public Object getContent() {
        return content;
    }
    public void setContent(Object content) {
        this.content = content;
    }
}

public class Main {
    public static void main(String[] args) {
        Prize prize = new Prize();
        prize.setContent("iPhone"); // 放入一个String

        // 程序员不小心以为里面是Integer，进行强制转换
        Integer money = (Integer) prize.getContent(); // 编译通过，但运行时会抛出ClassCastException!
    }
}
```

**结论：** 我们需要一种机制，既能让我们写一个通用的类，又能保证放入和取出类型的绝对安全。这就是泛型要解决的问题。

## **2. 泛型快速入门——用泛型解决问题**

泛型就像是一个**模板**或者**标签**。在定义类的时候，我们先不指定具体的类型，而是用一个占位符（比如`T`）来代替。等到真正创建这个类的对象时，再告诉编译器这个占位符`T`具体是什么类型。

```java
// 定义一个泛型类 Prize<T>
// T 就是类型参数，像个占位符
class Prize<T> { 
    private T content; // 奖品内容，类型由T决定

    public T getContent() {
        return content;
    }
    public void setContent(T content) {
        this.content = content;
    }
}

public class Main {
    public static void main(String[] args) {
        // 创建用于存放String的Prize对象
        Prize<String> goodsPrize = new Prize<>();
        goodsPrize.setContent("iPhone");
        String goods = goodsPrize.getContent(); // 直接得到String，无需强制转换！

        // 创建用于存放Integer的Prize对象
        Prize<Integer> cashPrize = new Prize<>();
        cashPrize.setContent(1000);
        int money = cashPrize.getContent(); // 直接得到Integer

        // 尝试错误操作：编译器直接报错，保证了类型安全！
        // goodsPrize.setContent(1000); // 错误！String类型的Prize不能放入Integer
    }
}
```

**泛型的好处：**

1. **代码复用**：一套代码，多种类型。`Prize<T>`一个类就解决了`PrizeInteger`, `PrizeString`, `PrizeDouble`等多个类的问题。
2. **类型安全**：编译器在编译阶段就能检查类型是否正确，将运行时错误`ClassCastException`提前到了编译期，大大提高了程序的健壮性。

## **3. 泛型的语法详解**

### **3.1 泛型的声明**

- **泛型类**：在类名后加`<类型参数>`

  ```java
  class ClassName<T> { ... } // T是Type的缩写，常用
  class ClassName<K, V> { ... } // K-Key, V-Value, 常用于键值对
  ```

- **泛型接口**：在接口名后加`<类型参数>`

  ```java
  interface InterfaceName<T> { ... }
  ```

- **泛型方法**：在方法返回值前加`<类型参数>`

  ```java
  public <E> void methodName(E e) { ... }
  ```

### **3.2 泛型的实例化**

在创建对象或调用方法时，用具体的类型（如`String`, `Integer`）替换掉类型参数。

```java
// 实例化泛型类
ArrayList<String> list = new ArrayList<String>();
// Java 7以后，后边的泛型可以省略，称为"钻石语法"
ArrayList<String> list = new ArrayList<>(); //老韩也是推荐这种写法

// 调用泛型方法（通常类型可自动推断，无需显式指定）
String middle = getMiddle("A", "B", "C"); // 编译器知道T是String
```

### **3.4 泛型使用的注意事项和细节**

1. **类型参数只能是引用类型**，不能是基本数据类型（如`int`, `double`）。

   ```java
   // 错误！
   // ArrayList<int> list = new ArrayList<>();
   // 正确！使用基本类型的包装类
   ArrayList<Integer> list = new ArrayList<>();
   ```

2. ==**泛型类型在逻辑上可看作是多个不同的类型**，但实际上**是相同类型**。这是由于Java泛型的**类型擦除**机制==。

   ```java
   ArrayList<String> list1 = new ArrayList<>();
   ArrayList<Integer> list2 = new ArrayList<>();
   // 编译后，两者都会被擦除成原始的ArrayList类型
   System.out.println(list1.getClass() == list2.getClass()); // 输出 true
   ```

3. **类型擦除（Type Erasure）**：这是Java泛型的实现方式。**泛型信息只存在于代码编译阶段**，在编译生成的字节码(.class文件)中，不包含泛型的类型信息。所有类型参数都会被替换为它们的**原始类型**（通常是`Object`），并在必要时插入强制类型转换。

   ```java
   // 你写的代码
   Prize<String> prize = new Prize<>();
   String content = prize.getContent();
   
   // 编译后（概念上等价于）
   Prize<T> prize = new Prize(); // T被擦除为Object
   Object contentObj = prize.getContent();
   String content = (String) contentObj; // 编译器自动插入的强制转换
   ```

   **类型擦除带来的限制：**

   - 不能实例化类型参数：`new T()`是错误的。//因为在new的时候不能确定T的类型-》就无法在内存开辟空间
   - 不能对泛型类型使用`instanceof`：`if (obj instanceof ArrayList<String>)`是错误的。

4. static方法和static属性不能使用泛型 

   ​	static是在类加载时同时加载的（这时候对象还没创建），而泛型是在对象创建时定义的，就是你在静态方法中使用一个没有定义的类型那jvm就懵逼了。

## 4.泛型的练习题

![image-20251009103255771](JAVA第15章随记_泛型.assets/image-20251009103255771.png)

```java
//main
package com.Generic_;

import java.util.ArrayList;
import java.util.Comparator;

public class Exercise {
    public static void main(String[] args) {
        ArrayList<Employee> employees = new ArrayList<>();
        employees.add(new Employee("tom", 5000, new MyDate(2002, 12, 10)));
        employees.add(new Employee("tom", 1000, new MyDate(2002, 12, 13)));
        employees.add(new Employee("tom", 50000, new MyDate(2002, 12, 14)));
        System.out.println(employees);
        System.out.println("========");
        //先判断name
        employees.sort(new Comparator<Employee>() {
            @Override
            public int compare(Employee o1, Employee o2) {
                int i = o1.getName().compareTo(o2.getName());
                if(i!=0){
                    return i;
                }
                return o1.getBirthday().compareTo(o2.getBirthday());
            }
        });
        //遍历结果
        System.out.println(employees);
    }
}
```

```java
package com.Generic_;

public class MyDate implements Comparable<MyDate>{
    private int year;
    private int month;
    private int day;

    public MyDate(int year, int month, int day) {
        this.year = year;
        this.month = month;
        this.day = day;
    }

    @Override
    public int compareTo(MyDate o) {
        //判断年-月-日
        return year-o.getYear()==0?(month-o.getMonth()==0?(day-o.getDay()):month-o.getMonth()):year-o.getYear();
    }

    @Override
    public String toString() {
        return "MyDate{" +
                "year=" + year +
                ", month=" + month +
                ", day=" + day +
                '}';
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getDay() {
        return day;
    }

    public void setDay(int day) {
        this.day = day;
    }
}

```

```java
package com.Generic_;

public class Employee {
    private String name;
    private int sal;
    private MyDate birthday;

    public Employee(String name, int sal, MyDate birthday) {
        this.name = name;
        this.sal = sal;
        this.birthday = birthday;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSal() {
        return sal;
    }

    public void setSal(int sal) {
        this.sal = sal;
    }

    public MyDate getBirthday() {
        return birthday;
    }

    public void setBirthday(MyDate birthday) {
        this.birthday = birthday;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "name='" + name + '\'' +
                ", sal=" + sal +
                ", birthday=" + birthday +
                '}';
    }
}

```

## **5. 自定义泛型**

### **5.1 自定义泛型类**

```java
// T 是类型参数，在实例化时确定
public class MyGenericClass<T> {
    private T field;

    public void setField(T value) {
        this.field = value;
    }
    public T getField() {
        return field;
    }

    // 普通方法，使用类定义的泛型T
    public void showType() {
        System.out.println("T的实际类型是: " + field.getClass().getName());
    }
}

// 使用
MyGenericClass<Integer> intObj = new MyGenericClass<>();
intObj.setField(123);
intObj.showType(); // 输出: T的实际类型是: java.lang.Integer
```

### **5.2 自定义泛型接口**

```java
// 泛型接口
public interface MyGenerator<T> {
    T generate();
}

// 实现方式1：实现类也声明为泛型类
public class FruitGenerator<T> implements MyGenerator<T> {
    @Override
    public T generate() {
        // ... 实现逻辑
        return null;
    }
}
// 实现方式2：实现类时直接指定具体类型
public class StringGenerator implements MyGenerator<String> {
    @Override
    public String generate() {
        return "Generated String";
    }
}
```

### **5.3 自定义泛型方法**

泛型方法可以独立于类而存在。即使所在的类不是泛型类，方法也可以是泛型的。

```java
public class Utility {
    // 这是一个泛型方法。<E>是类型参数声明，E可用于参数和返回值类型
    public static <E> void printArray(E[] inputArray) {
        for (E element : inputArray) {
            System.out.print(element + " ");
        }
        System.out.println();
    }

    public static void main(String[] args) {
        Integer[] intArray = {1, 2, 3};
        String[] strArray = {"A", "B", "C"};
        printArray(intArray); // 编译器推断E为Integer
        printArray(strArray); // 编译器推断E为String
    }
}
```

------

### 6**. 泛型的继承和通配符**

当我们处理未知类型的泛型对象时，通配符 `?`就非常有用了。

1. **无界通配符 `<?>`**：表示可以接受任何类型的泛型对象。主要用于读取数据。

   ```java
   public static void printBoxContent(Prize<?> box) {
       Object obj = box.getContent(); // 只能以Object类型读取
       System.out.println(obj);
   }
   ```

2. **上界通配符 `<? extends T>`**：表示通配符 `?`代表的是 `T`类型或其**子类**。这使得你能够更安全地**读取**数据（生产者，Producer）。

   ```java
   // 假设有继承关系：Animal <- Cat, Animal <- Dog
   public static void processAnimals(Prize<? extends Animal> animalBox) {
       Animal animal = animalBox.getContent(); // 可以安全地读取为Animal
       // animalBox.setContent(new Cat()); // 错误！编译不通过（除了null）
   }
   ```

3. **下界通配符 `<? super T>`**：表示通配符 `?`代表的是 `T`类型或其**父类**。这使得你能够更安全地**写入**数据（消费者，Consumer）。

   ```java
   public static void addDogToBox(Prize<? super Dog> dogBox) {
       dogBox.setContent(new Dog()); // 可以安全地写入Dog及其子类
       // Dog dog = dogBox.getContent(); // 错误！读取出来的类型只能是Object
   }
   ```

**PECS 原则 (Producer-Extends, Consumer-Super)：**

- **Producer（生产者）**：如果你主要从泛型对象中**获取**数据，使用 `<? extends T>`。
- **Consumer（消费者）**：如果你主要向泛型对象中**放入**数据，使用 `<? super T>`。

------

## **6. 本章总结与作业**

**核心思想：** 泛型通过**参数化类型**，实现了代码的复用和类型安全。

**关键概念：**

- **泛型类/接口/方法**：如何声明和使用。
- **类型擦除**：理解泛型的底层机制和由此带来的限制。
- **通配符**：`?`, `? extends T`, `? super T`的区别和应用场景（PECS原则）。

**实践建议：**

- 多看Java集合框架（如`ArrayList<String>`）的源码，它是泛型的最佳实践。
- 尝试用泛型重构你之前写过的一些重复代码。

**举一反三：**

你可以用泛型的思想去设计一个`DataBase<T>`类，它可以连接并操作不同类型的数据库（`MySQL`, `Oracle`等），而核心的业务逻辑代码只需要写一份。

![image-20251009205857466](JAVA第15章随记_泛型.assets/image-20251009205857466.png)

```java
package com.Generic_;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Homework {
    public static void main(String[] args) {
        DAO<User> objectDAO = new DAO<>();
        objectDAO.save("10",new User(10,5,"jack"));
        objectDAO.save("11",new User(11,6,"tom"));
        objectDAO.save("12",new User(12,7,"butter"));
        System.out.println(objectDAO);
        System.out.println(objectDAO.get("10"));
        objectDAO.update("10",new User(10,10,"king"));
        System.out.println(objectDAO);
        System.out.println(objectDAO.list());
        objectDAO.delete("10");
        System.out.println(objectDAO);
    }
}
class DAO<T>{
    private Map<String,T> map=new HashMap<>();
    public void save(String id,T entity){
        map.put(id,entity);
    }
    public T get(String id){
        return map.get(id);
    }
    public void update(String id,T entity){
        map.put(id,entity);
    }
    //任务 返回map中存放的所有T对象
    public List<T> list(){
        //遍历出map即可
        return new ArrayList<>(map.values());
    }
    //任务 删除指定id对象
    public void delete(String id){
        map.remove(id);
    }

    @Override
    public String toString() {
        return "DAO{" +
                "map=" + map +
                '}';
    }
}
class User{
    private int id;
    private int age;
    private String name;

    public User(int id, int age, String name) {
        this.id = id;
        this.age = age;
        this.name = name;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", age=" + age +
                ", name='" + name + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
```



## 7.JUnit

![image-20251009205823667](JAVA第15章随记_泛型.assets/image-20251009205823667.png)

![image-20251009205827772](JAVA第15章随记_泛型.assets/image-20251009205827772.png)
