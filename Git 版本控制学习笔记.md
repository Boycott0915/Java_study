# Git 版本控制学习笔记

> **简介**：本文档基于“狂神说Git”系列教程整理，涵盖了版本控制的核心概念、Git的安装与配置、基本命令操作以及远程仓库（Gitee/GitHub）的配置与使用。

## 1. 版本控制（Version Control）

### 1.1 什么是版本控制

版本控制是一种在开发过程中用于管理我们对文件、目录或工程等内容的修改历史，方便查看更改历史记录，备份以便恢复以前的版本的软件工程技术。

<img src="C:\Users\Easson\AppData\Roaming\Typora\typora-user-images\image-20251121091415660.png" alt="image-20251121091415660" style="zoom:67%;" />

**主要作用：**

- **多人协同开发**：实现跨区域多人协同。
- **版本追踪**：记载文件修改历史，方便回溯。
- **源代码保护**：组织和保护源代码和文档。
- **并行开发**：提高开发效率。

### 1.2 常见的版本控制工具

- **Git**：目前最流行的**分布式**版本控制系统。
- **SVN**：集中式版本控制系统（代表）。
- **CVS / VSS / TFS**：较老或特定的版本控制工具。

### 1.3 分布式 vs 集中式

- **集中式 (SVN)**：版本库集中存放在中央服务器，工作时需联网，单点故障风险高。
- **分布式 (Git)**：每个人的电脑都是一个完整的版本库，每个人都拥有全部代码工作无需联网，安全性高，功能强大。Git可以直接看到更新了哪些代码和文件。

<img src="C:\Users\Easson\AppData\Roaming\Typora\typora-user-images\image-20251121092019327.png" alt="image-20251121092019327" style="zoom:67%;" />

## 2. Git 安装与环境配置

### 2.1 软件下载

- 前往 [Git官网](https://git-scm.com/) 下载对应系统的安装包。
- 安装通常一路 "Next" 即可。
- 安装完成后，在任意文件夹右键，若出现 `Git Bash Here` 和 `Git GUI Here` 即代表安装成功。

2.2 Git配置

>所有的配置文件，其实都保存在本地！
>
>查看配置 git config -l

<img src="C:\Users\Easson\AppData\Roaming\Typora\typora-user-images\image-20251121095505748.png" alt="image-20251121095505748" style="zoom:67%;" />

查看不同级别的配置文件：

```
#查看系统config-->在这里面Git\etc\gitconfig
git config --system --list 
#查看当前用户（global）配置-->C:\Users\Administrator\ .gitconfig在这里面
git config --global  --list
```

**Git相关的配置文件：**

1）Git\etc\gitconfig  ：Git 安装目录下的 gitconfig   --system 系统级

2）C:\Users\Administrator\ .gitconfig   只适用于当前登录用户的配置  --global 全局

![image-20251121095611111](C:\Users\Easson\AppData\Roaming\Typora\typora-user-images\image-20251121095611111.png)

这里可以直接编辑配置文件，通过命令设置后会响应到这里。

**设置用户名与邮箱（用户标识，必要）**

当你安装Git后首先要做的事情是设置你的用户名称和e-mail地址。这是非常重要的，因为每次Git提交都会使用该信息。它被永远的嵌入到了你的提交中：

```
git config --global user.name "kuangshen"  #名称
git config --global user.email 24736743@qq.com   #邮箱
```

只需要做一次这个设置，如果你传递了--global 选项，因为Git将总是会使用该信息来处理你在系统中所做的一切操作。如果你希望在一个特定的项目中使用不同的名称或e-mail地址，你可以在该项目中运行该命令而不要--global选项。总之--global为全局配置，不加为某个项目的特定配置。

![image-20251121095716615](C:\Users\Easson\AppData\Roaming\Typora\typora-user-images\image-20251121095716615.png)

## 3. 常用的 Linux 命令

>Git Bash 模拟了 Linux 的命令行环境，因此掌握基础的 Linux 命令对于使用 Git 非常有帮助。

- **`cd`**：切换目录 (Change Directory)。

- **`cd ..`**：返回上一级目录。

- **`pwd`**：显示当前所在的目录路径 (Print Working Directory)。

- **`ls`**：列出当前目录下的所有文件 (`ll` 可以查看详细信息)。

- **`touch`**：新建一个文件（如 `touch index.js`）。

- **`rm`**：删除一个文件（如 `rm index.js`）。

- > rm -rf / 切勿在Linux中尝试！删除电脑中全部文件！

- **`mkdir`**：新建一个目录/文件夹 (Make Directory)。

- **`rm -r`**：递归删除目录（如 `rm -r src`，**慎用**）。

- **`mv`**：移动文件或重命名（如 `mv index.html ./test/`）。

- **`reset`**：重新初始化终端/清屏。

- **`clear`**：清屏（只清除当前屏幕内容）。

- **`history`**：查看命令历史。

- **`exit`**：退出终端。

## 4. Git 核心理论与工作流程

### 4.1 四个工作区域

Git 本地有三个工作区域，加上远程仓库共四个：

1. **工作目录 (Working Directory)**：工作区，平时存放项目代码的地方。
2. **暂存区 (Stage/Index)**：用于临时存放你的改动，事实上它只是一个文件，保存即将提交到文件列表信息。
3. **资源库 (Repository/HEAD)**：安全存放数据的位置，这里面有你提交到所有版本的数据。
4. **远程仓库 (Remote)**：托管代码的服务器（如 GitHub, Gitee）。

<img src="C:\Users\Easson\AppData\Roaming\Typora\typora-user-images\image-20251121100926114.png" alt="image-20251121100926114" style="zoom:67%;" />

### 4.2 工作流程

1. 在工作目录中添加、修改文件。
2. 将需要进行版本管理的文件放入暂存区 (`git add`)。
3. 将暂存区的文件提交到本地仓库 (`git commit`)。
4. 将本地仓库推送到远程仓库 (`git push`)。

## 5. 常用 Git 命令

### 5.1 项目搭建

```
# 方式一：本地初始化
git init

# 方式二：克隆远程项目（最常用）
git clone [url]
```

### 5.2 文件操作

```
# 查看文件状态
git status

# 添加所有文件到暂存区
git add .

# 提交暂存区内容到本地仓库
# -m 后面跟提交信息
git commit -m "这是备注信息"
```

### 5.3 忽略文件 (.gitignore)

在项目根目录创建 `.gitignore` 文件，配置不需要纳入版本控制的文件（如临时文件、日志、编译产物）。 **常见规则：**

```
*.txt        # 忽略所有 .txt 结尾的文件
!lib.txt     # lib.txt 除外
/temp        # 仅忽略项目根目录下的 temp 文件夹 （前面的 / 代表“根目录”）
build/       # 忽略项目内任何位置名为 build 的文件夹
doc/*.txt    # 会忽略 doc/notes.txt 但不包括 doc/server/arch.txt “只管 doc 这一层房间里的 .txt，里面的小隔间（子文件夹）我不管。”
```

## 6. 远程仓库配置 (Gitee/GitHub)

鉴于 GitHub 国内访问较慢，常使用 Gitee (码云) 作为替代。

### 6.1 设置 SSH 公钥 (实现免密登录)

1. 进入 C 盘用户目录下的 `.ssh` 目录（如果没有则新建）。

2. 生成公钥：

   ```
   ssh-keygen -t rsa
   ```

   （一路回车即可）

3. 在 `.ssh` 目录下会生成 `id_rsa` (私钥) 和 `id_rsa.pub` (公钥)。

4. 打开 `id_rsa.pub`，复制里面的内容。

5. 登录 Gitee/GitHub -> 设置 -> SSH 公钥 -> 粘贴并添加。

### 6.2 关联与推送

1. 在 Gitee 上新建一个仓库。

2. 复制仓库地址。

3. 本地克隆或关联：

   ```
   git clone git@gitee.com:username/repo.git
   ```

## 7. IDEA 集成 Git

1. **配置**：File -> Settings -> Version Control -> Git，指定 `git.exe` 的路径。
2. **操作**：
   - IDEA 右上角通常会有 Git 操作栏。
   - 蓝色文件：修改过。
   - 绿色文件：新添加（已加入暂存区）。
   - 红色文件：未加入版本控制。
3. **流程**：可以直接在 IDEA 的 Terminal 中输入命令，也可以使用图形化界面点击 Commit 和 Push。

## 8. 分支管理 (Branch)

分支是 Git 的杀手锏，允许并行开发。

```
# 列出所有本地分支
git branch

# 列出所有远程分支
git branch -r

# 新建一个分支，但依然停留在当前分支
git branch [branch-name]

# 新建一个分支，并切换到该分支
git checkout -b [branch-name]

# 合并指定分支到当前分支
git merge [branch-name]

# 删除分支
git branch -d [branch-name]
```

> **总结**：Git 是现代开发者的必备技能。初学者应重点掌握 `clone`, `add`, `commit`, `push`, `pull` 这几个高频命令，并理解工作区与暂存区的区别。

# 9.快捷键

鼠标中键 将复制的内容黏贴到bash上

# 10.遇到的问题

# 什么是“本地分支未关联到远程分支”？

## 🌐 通俗理解

想象你有两个仓库：

- **本地仓库**：你电脑上的代码（比如 `delivery_system` 文件夹）
- **远程仓库**：GitHub 上的代码

每个仓库都有**分支（branch）**，比如 `master` 分支。

------

## 🔗 什么是“关联”？

> **关联 = 告诉 Git：“我本地的 `master` 分支，对应 GitHub 上的哪个分支”**

------

## ❌ 没有关联的情况

- 你执行：

  ```bash
  git push
  ```

- Git 不知道要推送到哪里  

- 报错：

  ```
  fatal: No configured push destination.
  ```

> 就像你说“寄快递”，但**没写收件地址**，快递员不知道寄到哪 📦❓

------

## ✅ 关联后的情况

- 你执行：

  ```bash
  git push
  ```

- Git 自动知道：

  > 本地 `master` → 远程 `origin/master`

- 于是自动推送，**不用每次都指定远程和分支名**

> 就像你设置了**默认收货地址**，以后说“寄快递”，系统自动寄到那个地址 ✅

------

## 🔧 如何建立关联？

只需执行一次这个命令：

```bash
git push -u origin master
```

- `-u` 的作用：**建立上游（upstream）关联**
- 意思是：“把本地 `master` 分支，关联到远程 `origin` 的 `master` 分支”

✅ 设置一次，终身受益！以后直接用：

```bash
git push      # 自动推送到 origin/master
git pull      # 自动从 origin/master 拉取
```

------

## 💡 总结

| 状态       | 行为                | 类比                 |
| ---------- | ------------------- | -------------------- |
| **未关联** | `git push` 报错     | 寄快递没写地址       |
| **已关联** | `git push` 自动推送 | 有默认地址，一键寄出 |

> ✅ 记住：第一次推送时加 `-u`，以后就省心啦！

# 一次性添加所有修改并提交
```
git add . && git commit -m "提交说明" && git push
```

# IntelliJ IDEA Git 版本控制指南

## 一、在 IDEA 中查看历史版本

### 方法 1：查看整个项目的提交历史 (Git Log 面板)

1. **打开 Git Log 面板：**
   - 点击底部的 `Git` 标签（或按 `Alt + 9`）。
   - 点击 `Log` 标签。
2. **查看提交记录：**
   - 在时间线中，您将看到所有提交记录。
   - 每次提交会显示：作者、时间、提交信息。
   - **查看某次提交的详细修改：**
     - 点击某个提交记录。
     - 右侧会显示修改的文件列表。
     - 双击文件，可以看到具体的修改内容（红色表示删除，绿色表示新增）。

### 方法 2：查看某个文件的历史

1. **操作步骤：**
   - 右键点击目标文件（例如 `public.css`）。
   - 选择 `Git` → `Show History`。
2. **结果：**
   - 会显示这个文件的所有修改记录。
   - 点击某次提交，可以查看那次对该文件具体改了什么。

## 二、回退版本的方法

### 情况 1：撤销最近的提交（还未 Push）

**场景：** 刚提交了代码，发现有问题，想撤销提交。

| Git 命令                   | IDEA 操作      | 描述                                                        |
| -------------------------- | -------------- | ----------------------------------------------------------- |
| `git reset --soft HEAD~1`  | **Soft 模式**  | 撤销提交记录，但**保留**所有代码修改（代码仍在工作区）。    |
| `git reset --hard HEAD~1`  | **Hard 模式**  | 撤销提交记录，并**删除**所有代码修改（**危险！**）。        |
| `git reset --mixed HEAD~1` | **Mixed 模式** | 撤销提交和 `add` 操作，保留代码修改，但文件回到未暂存状态。 |

**IDEA 操作步骤：**

1. 打开 Git Log 面板。
2. 右键点击**要回退到的**提交记录（即目标版本的前一个）。
3. 选择 `Reset Current Branch to Here...`。
4. 选择所需的模式（Soft, Mixed, Hard）。

### 情况 2：回退已经 Push 的版本（已推送到远程仓库）

**场景：** 代码已推送到 GitHub/GitLab，需要回退。

#### 方法 A：创建新提交来撤销 (推荐，安全)

这是最安全的团队协作方式，不会破坏历史记录。

1. **Git 命令：**

   ```
   # 撤销某次提交，创建一个新的"反向提交"
   git revert <提交ID>
   # 例如：
   git revert bb8981a
   ```

2. **IDEA 操作：**

   - 打开 Git Log。
   - 右键点击**要撤销的**那次提交。
   - 选择 `Revert Commit`。
   - 提交这个新创建的反向提交，并推送到远程仓库。

#### 方法 B：强制回退 (危险，慎用)

这会删除历史记录，可能导致团队成员的代码冲突。

1. **Git 命令：**

   ```
   # 1. 本地回退到某个版本
   git reset --hard <提交ID>
   # 2. 强制推送到 GitHub
   git push -f origin <分支名>
   ```

2. **IDEA 操作：**

   - 打开 Git Log。
   - 右键点击**要回退到的**提交。
   - 选择 `Reset Current Branch to Here...`，选择 **Hard** 模式。
   - 执行 `git push -f` 进行强制推送。

### 情况 3：只想看看以前的代码，不回退

**场景：** 只是想临时查看某个历史版本的项目状态。

1. 打开 Git Log。
2. 右键点击某个历史提交。
3. 选择 `Checkout Revision`。
4. **注意：** 此时您进入了“分离头指针”状态。
5. **看完后切换回主分支：**
   - 点击右下角的分支名。
   - 选择 `master`（或您当前的分支）→ `Checkout`。

## 三、实际操作演示

**练习：查看你修复 CSS 的那次提交**

1. 按 `Alt + 9` 打开 Git 面板，点击 `Log` 标签。
2. 找到提交信息：“这是我的快递管理系统项目,修改了public.css的错误”。
3. 点击该提交记录。
4. 右侧会显示 `web/css/public.css` 文件。
5. 双击文件，可以看到你修复的 5 处错误。

## 四、常用快捷键总结

| 快捷键             | 功能                            |
| ------------------ | ------------------------------- |
| `Alt + 9`          | 打开 Git 面板（或直接打开 Log） |
| `Ctrl + K`         | 提交代码（Commit）              |
| `Ctrl + Shift + K` | 推送代码（Push）                |
| `Ctrl + T`         | 拉取代码（Pull）                |

# 创建符号连接 使得A修改时 另一个位置的B同时修改

```
mklink /H "C:\Users\Easson\Desktop\Git 版本控制学习笔记.md" "D:\git\Git 版本控制学习笔记.md"
```

check
