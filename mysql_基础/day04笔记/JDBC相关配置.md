# JDBC相关配置

# 前言

```java
所有的java代码操作数据都是在JDBC基础上演化过来的
所有的java代码操作数据库的技术都需要共同的jar包:
mysql-connector-java-8.0.25.jar
```

# 一.使用原生JDBC操作数据库

## 1.需要的jar包

```java
1.导jar包:
  mysql-connector-java-8.0.25.jar   -> url中不用加时区
```

## 2.需要的工具类

```java
public class JDBCUtils {
    private JDBCUtils() {

    }

    private static String url = null;
    private static String username = null;
    private static String password = null;

    static {
        url = "jdbc:mysql://localhost:3306/240819_database?rewriteBatchedStatements=true";
        username = "root";
        password = "root";
    }

    /**
     * 获取连接对象
     */
    public static Connection getConnection() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return connection;
    }

    /**
     * 关闭资源
     */
    public static void close(Connection conn, Statement st, ResultSet rs){
        if (rs!=null){
            try {
                rs.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if (st!=null){
            try {
                st.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if (conn!=null){
            try {
                conn.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

    }

}

```

## 3.原生jdbc读取配置文件方式

### 3.1配置文件内容

```java
1.在resources资源包下创建properties文件

2.具体配置:
url=jdbc:mysql://localhost:3306/220212_java3?rewriteBatchedStatements=true
username=root
password=root
```

### 3.2读取配置文件工具类

```java
public class JDBCUtils {
    private JDBCUtils() {

    }

    private static String url = null;
    private static String username = null;
    private static String password = null;

    static {
        InputStream in = null;
        try {
            //创建Properties属性集
            Properties properties = new Properties();
            //读取配置文件
            in = JDBCUtils.class.getClassLoader().getResourceAsStream("jdbc.properties");
            properties.load(in);

            url = properties.getProperty("url");
            username = properties.getProperty("username");
            password = properties.getProperty("password");

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if (in != null){
                try {
                    in.close();
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        }
    }

    public static Connection getConn() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return connection;
    }

    public static void close(Connection connection, Statement statement, ResultSet resultSet) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}

```

# 二.使用C3P0连接池操作数据库

## 1.需要的jar包

```java
c3p0-0.9.1.2.jar
```

## 2.需要的配置文件

```java
1.在resources资源包下创建xml文件,文件名字固定:c3p0-config.xml
2.详细配置:
  <?xml version="1.0" encoding="UTF-8"?>
<c3p0-config>
    <!-- 使用默认的配置读取连接池对象 -->
    <default-config>
        <!--  连接参数 -->
        <property name="driverClass">com.mysql.cj.jdbc.Driver</property>
        <property name="jdbcUrl">jdbc:mysql://localhost:3306/220212_java3&rewriteBatchedStatements=true</property>
        <property name="user">root</property>
        <property name="password">root</property>

        <!-- 连接池参数 -->
        <property name="initialPoolSize">5</property>
        <property name="maxPoolSize">10</property>
        <property name="checkoutTimeout">2000</property>
        <property name="maxIdleTime">1000</property>
    </default-config>
</c3p0-config>
```

## 3.需要的工具类

```java
public class JDBCUtils_C3P0 {
    private JDBCUtils_C3P0() {

    }

    //声明一个连接池对象
    private static DataSource dataSource = null;

    static {
        dataSource = new ComboPooledDataSource();
    }

    /**
     * 获取连接对象
     */
    public static Connection getConnection() {
        Connection connection = null;
        try {
            connection = dataSource.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return connection;
    }

    /**
     * 关闭资源
     */
    public static void close(Connection conn, Statement st, ResultSet rs){
        if (rs!=null){
            try {
                rs.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if (st!=null){
            try {
                st.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if (conn!=null){
            try {
                //将对象归还连接池
                conn.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

    }
}

```

# 三.使用Druid连接池操作数据库

## 1.需要的jar包

```java
druid-1.1.6.jar
```

## 2.需要的配置文件

```java
1.在resources资源包下创建druid.properties文件

2.详细配置
driverClassName=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://localhost:3306/220212_java3?&rewriteBatchedStatements=true
username=root
password=root
initialSize=5
maxActive=10
maxWait=1000    
```

## 3.需要的工具类

```java
public class DruidUtils {
    private DruidUtils() {

    }

    //声明一个DataSource对象
    private static DataSource dataSource = null;

    static {
        InputStream in = null;
        try {
            Properties properties = new Properties();
            in = DruidUtils.class.getClassLoader().getResourceAsStream("druid.properties");
            properties.load(in);

            dataSource = DruidDataSourceFactory.createDataSource(properties);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally {
            if (in != null){
                try {
                    in.close();
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        }
    }

    /**
     * 获取连接对象
     * 连接对象从连接池中获取
     */
    public static Connection getConnection() {
        Connection connection = null;
        try {
            connection = dataSource.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return connection;
    }

    /**
     * 关闭资源
     */
    public static void close(Connection conn, Statement st, ResultSet rs){
        if (rs!=null){
            try {
                rs.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if (st!=null){
            try {
                st.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if (conn!=null){
            try {
                conn.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

    }
}


```

# 四.使用DBUtils工具包操作数据库

## 1.需要的jar包

```java
commons-dbutils-1.4.jar
```

## 2.需要的配置文件

```java
直接用Druid的配置文件
```

## 3.需要的工具类

```java
工具类中新添加了一个直接获取DataSource的方法
```

```java
public class DruidUtils {
    private DruidUtils() {

    }

    //声明一个DataSource对象
    private static DataSource dataSource = null;

    static {
        InputStream in = null;
        try {
            Properties properties = new Properties();
            in = DruidUtils.class.getClassLoader().getResourceAsStream("druid.properties");
            properties.load(in);

            dataSource = DruidDataSourceFactory.createDataSource(properties);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally {
            if (in != null){
                try {
                    in.close();
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        }
    }

    /**
     * 新添加的
     * 获取DataSource对象,并返回
     */
    public static DataSource getDataSource(){
        return dataSource;
    }

    /**
     * 获取连接对象
     * 连接对象从连接池中获取
     */
    public static Connection getConnection() {
        Connection connection = null;
        try {
            connection = dataSource.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return connection;
    }

    /**
     * 关闭资源
     */
    public static void close(Connection conn, Statement st, ResultSet rs){
        if (rs!=null){
            try {
                rs.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if (st!=null){
            try {
                st.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if (conn!=null){
            try {
                conn.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

    }
}
```

