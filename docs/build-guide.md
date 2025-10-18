# 🛠️ 构建指南

完整的 Xboard-Mihomo 构建和运行环境配置指南。

---

## 📋 目录

- [环境要求](#环境要求)
- [环境准备](#环境准备)
- [获取代码](#获取代码)
- [构建步骤](#构建步骤)
- [平台特定说明](#平台特定说明)
- [常见问题](#常见问题)

---

## 环境要求

### 基础环境

| 工具 | 版本要求 | 说明 |
|-----|---------|------|
| **Flutter SDK** | >= 3.0 | 必需 |
| **Dart SDK** | >= 2.19 | Flutter 自带 |
| **Golang** | >= 1.19 | 编译 Clash.Meta 核心 |
| **Git** | 最新版 | 管理代码和子模块 |

### 平台特定工具

根据你的目标平台，需要安装对应的开发工具：

#### 🤖 Android
- **Android SDK** - 最新稳定版
- **Android NDK** - r21 或更高版本
- **Java JDK** - 11 或更高版本

#### 🪟 Windows
- **GCC 编译器** - MinGW-w64 或 TDM-GCC
- **Inno Setup** - 用于打包 Windows 安装程序

#### 🍎 macOS
- **Xcode** - 最新版本
- **Xcode Command Line Tools**
- **CocoaPods** - Ruby 包管理器

#### 🐧 Linux
必需的系统依赖：
```bash
sudo apt-get install libayatana-appindicator3-dev
sudo apt-get install libkeybinder-3.0-dev
```

---

## 环境准备

### 1. 安装 Flutter SDK

访问 [Flutter 官网](https://flutter.dev/docs/get-started/install) 下载并安装 Flutter SDK。

**验证安装：**
```bash
flutter --version
flutter doctor
```

**运行 `flutter doctor` 检查环境：**
```bash
flutter doctor -v
```

确保所有必需的组件都已安装并配置正确。

### 2. 安装 Golang

访问 [Golang 官网](https://golang.org/dl/) 下载并安装 Go。

**验证安装：**
```bash
go version
```

**配置 Go 环境变量（如果需要）：**
```bash
# Linux/macOS
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Windows (PowerShell)
$env:GOPATH = "$HOME\go"
$env:Path += ";$env:GOPATH\bin"
```

### 3. 安装 Dart 依赖包

确保已安装构建脚本所需的 Dart 包：

```bash
# 安装全局依赖
dart pub global activate args
dart pub global activate path
dart pub global activate crypto
```

---

## 获取代码

### 1. 克隆仓库

```bash
git clone https://github.com/hakimi-x/Xboard-Mihomo.git
cd Xboard-Mihomo
```

### 2. 更新子模块 ⭐

**这是最重要的一步！** 项目依赖多个 Git 子模块：

```bash
git submodule update --init --recursive
```

这会下载以下子模块：
- `core/Clash.Meta` - Clash Meta 核心（基于 FlClash 分支）
- `plugins/flutter_distributor` - Flutter 打包分发工具
- `lib/sdk/flutter_xboard_sdk` - XBoard SDK

**验证子模块状态：**
```bash
git submodule status
```

### 3. 生成 SDK 代码 ⭐⭐⭐

**关键步骤：** 更新子模块后，必须进入 SDK 目录生成代码：

```bash
# 进入 SDK 目录
cd lib/sdk/flutter_xboard_sdk

# 安装依赖
flutter pub get

# 运行代码生成器
dart run build_runner build --delete-conflicting-outputs

# 返回项目根目录
cd ../../..
```

> 💡 **为什么需要这一步？**  
> XBoard SDK 使用 `build_runner` 生成序列化代码（如 JSON 序列化、依赖注入等）。不执行此步骤会导致编译失败。

### 4. 安装项目依赖

回到项目根目录，安装所有依赖：

```bash
flutter pub get
```

---

## 构建步骤

### 通用构建流程

所有平台的构建都通过 `setup.dart` 脚本完成：

```bash
dart setup.dart <platform> [options]
```

### 🤖 Android 构建

#### 前置要求

1. **安装 Android SDK 和 NDK**
   
   通过 Android Studio 安装，或使用命令行工具：
   ```bash
   # 使用 sdkmanager 安装
   sdkmanager "ndk;21.4.7075529"
   sdkmanager "platforms;android-33"
   sdkmanager "build-tools;33.0.0"
   ```

2. **设置 NDK 环境变量**
   
   ```bash
   # Linux/macOS
   export ANDROID_NDK=/path/to/android/ndk/21.4.7075529
   
   # Windows (PowerShell)
   $env:ANDROID_NDK = "C:\Users\YourName\AppData\Local\Android\Sdk\ndk\21.4.7075529"
   
   # Windows (CMD)
   set ANDROID_NDK=C:\Users\YourName\AppData\Local\Android\Sdk\ndk\21.4.7075529
   ```
   
   **验证环境变量：**
   ```bash
   echo $ANDROID_NDK    # Linux/macOS
   echo %ANDROID_NDK%   # Windows CMD
   echo $env:ANDROID_NDK # Windows PowerShell
   ```

#### 运行构建

```bash
dart setup.dart android
```

**构建输出位置：**
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- AAB: `build/app/outputs/bundle/release/app-release.aab`

#### 常见问题

**问题：找不到 NDK**
```
Error: ANDROID_NDK environment variable not set
```

**解决方案：**
```bash
# 查找 NDK 安装位置
ls ~/Android/Sdk/ndk/  # Linux/macOS
dir %LOCALAPPDATA%\Android\Sdk\ndk  # Windows

# 设置正确的路径
export ANDROID_NDK=<找到的NDK路径>
```

---

### 🪟 Windows 构建

#### 前置要求

1. **安装 GCC 编译器**
   
   下载并安装 [MinGW-w64](https://www.mingw-w64.org/) 或 [TDM-GCC](https://jmeubank.github.io/tdm-gcc/)。
   
   **验证安装：**
   ```bash
   gcc --version
   ```

2. **安装 Inno Setup**
   
   下载 [Inno Setup](https://jmeubank.github.io/innosetup/) 并安装。
   
   **添加到 PATH：**
   ```powershell
   # 默认安装路径
   $env:Path += ";C:\Program Files (x86)\Inno Setup 6"
   ```

#### 运行构建

```bash
# AMD64 架构（Intel/AMD 处理器）
dart setup.dart windows --arch amd64

# ARM64 架构（ARM 处理器）
dart setup.dart windows --arch arm64
```

**构建输出位置：**
- 安装程序: `build/windows/installer/Xboard-Mihomo-Setup.exe`
- 可执行文件: `build/windows/runner/Release/xboard_mihomo.exe`

> ⚠️ **注意**：Windows 构建只能在 Windows 系统上进行。

---

### 🍎 macOS 构建

#### 前置要求

1. **安装 Xcode**
   
   从 App Store 安装最新版 Xcode。

2. **安装命令行工具**
   
   ```bash
   xcode-select --install
   ```

3. **安装 CocoaPods**
   
   ```bash
   sudo gem install cocoapods
   pod --version
   ```

#### 运行构建

```bash
# Intel 芯片（x86_64）
dart setup.dart macos --arch amd64

# Apple Silicon（M1/M2/M3）
dart setup.dart macos --arch arm64
```

**构建输出位置：**
- App 包: `build/macos/Build/Products/Release/Xboard Mihomo.app`
- DMG 镜像: `build/macos/Xboard-Mihomo.dmg`

> ⚠️ **注意**：macOS 构建只能在 macOS 系统上进行。

---

### 🐧 Linux 构建

#### 前置要求

1. **安装系统依赖**
   
   ```bash
   # Ubuntu/Debian
   sudo apt-get update
   sudo apt-get install -y \
     clang \
     cmake \
     ninja-build \
     pkg-config \
     libgtk-3-dev \
     libayatana-appindicator3-dev \
     libkeybinder-3.0-dev
   
   # Fedora/RHEL
   sudo dnf install -y \
     clang \
     cmake \
     ninja-build \
     gtk3-devel \
     libappindicator-gtk3-devel \
     keybinder3-devel
   
   # Arch Linux
   sudo pacman -S --noconfirm \
     clang \
     cmake \
     ninja \
     gtk3 \
     libappindicator-gtk3 \
     keybinder3
   ```

#### 运行构建

```bash
# AMD64 架构（Intel/AMD 处理器）
dart setup.dart linux --arch amd64

# ARM64 架构（ARM 处理器）
dart setup.dart linux --arch arm64
```

**构建输出位置：**
- 可执行文件: `build/linux/<arch>/release/bundle/xboard_mihomo`
- DEB 包: `build/linux/xboard-mihomo.deb`
- RPM 包: `build/linux/xboard-mihomo.rpm`

---

## 平台特定说明

### 架构选择说明

| 架构 | 适用处理器 | 说明 |
|------|-----------|------|
| **amd64** | Intel、AMD | 传统 x86_64 架构 |
| **arm64** | ARM | Apple Silicon、树莓派等 |

**如何确定架构：**

```bash
# Linux/macOS
uname -m
# 输出 x86_64 → 使用 amd64
# 输出 arm64/aarch64 → 使用 arm64

# Windows (PowerShell)
$env:PROCESSOR_ARCHITECTURE
# 输出 AMD64 → 使用 amd64
# 输出 ARM64 → 使用 arm64
```

### 跨平台编译限制

| 构建平台 | 可以构建的目标平台 |
|---------|------------------|
| **Windows** | ✅ Windows<br>✅ Android<br>❌ macOS<br>❌ Linux |
| **macOS** | ✅ macOS<br>✅ Android<br>✅ iOS（开发中）<br>✅ Linux（部分） |
| **Linux** | ✅ Linux<br>✅ Android<br>❌ Windows<br>❌ macOS |

> 💡 **提示**：Android 可以在任何平台上构建，因为它不依赖宿主操作系统。

---

## 开发模式运行

构建完整应用需要较长时间，开发调试时可以使用以下命令：

### 连接设备运行

```bash
# 查看可用设备
flutter devices

# 在默认设备运行（Debug 模式）
flutter run

# 在指定设备运行
flutter run -d <device-id>

# Release 模式运行
flutter run --release
```

### 热重载

运行 Debug 模式时，修改代码后：
- 按 `r` - 热重载（Hot Reload）
- 按 `R` - 热重启（Hot Restart）
- 按 `q` - 退出

---

## 常见问题

### 1. 子模块更新失败

**问题：**
```
fatal: Needed a single revision
Unable to find current revision in submodule path 'core/Clash.Meta'
```

**解决方案：**
```bash
# 清理子模块
git submodule deinit -f --all

# 重新初始化
git submodule update --init --recursive

# 如果仍失败，尝试强制更新
git submodule foreach --recursive git reset --hard
git submodule update --force --recursive
```

### 2. SDK 代码生成失败

**问题：**
```
Error: Could not find package 'json_annotation'
```

**解决方案：**
```bash
cd lib/sdk/flutter_xboard_sdk
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
cd ../../..
```

### 3. NDK 环境变量未生效

**问题：**
```
Error: ANDROID_NDK is not set
```

**解决方案：**
```bash
# 临时设置（当前会话有效）
export ANDROID_NDK=/path/to/ndk

# 永久设置（添加到配置文件）
echo 'export ANDROID_NDK=/path/to/ndk' >> ~/.bashrc  # Linux
echo 'export ANDROID_NDK=/path/to/ndk' >> ~/.zshrc   # macOS
source ~/.bashrc  # 或 source ~/.zshrc

# Windows 永久设置
# 在系统环境变量中添加 ANDROID_NDK
```

### 4. Flutter 依赖冲突

**问题：**
```
Because project depends on package_a and package_b...
```

**解决方案：**
```bash
# 清理缓存
flutter clean
flutter pub cache repair

# 重新获取依赖
flutter pub get

# 如果还是失败，删除 pubspec.lock
rm pubspec.lock
flutter pub get
```

### 5. Golang 编译失败

**问题：**
```
go: command not found
```

**解决方案：**
```bash
# 检查 Golang 是否安装
go version

# 如果未安装，访问 https://golang.org/dl/ 下载安装

# 检查 PATH 环境变量
echo $PATH | grep go

# 添加 Go 到 PATH（如果需要）
export PATH=$PATH:/usr/local/go/bin
```

### 6. macOS 签名问题

**问题：**
```
Code signing is required for product type 'Application'
```

**解决方案：**
```bash
# 方法 1: 使用自动签名（开发测试）
# 在 Xcode 中打开项目，启用 "Automatically manage signing"

# 方法 2: 临时禁用签名（仅用于调试）
# 编辑 macos/Runner/DebugProfile.entitlements
# 添加临时签名配置
```

---

## 📚 更多资源

- [Flutter 官方文档](https://flutter.dev/docs)
- [Dart 语言指南](https://dart.dev/guides)
- [Golang 官方文档](https://golang.org/doc/)
- [FlClash 项目](https://github.com/chen08209/FlClash)
- [配置文档](./README.md)
- [快速开始](./quick-start.md)

---

## 🆘 获取帮助

如果遇到问题：
1. 查看 [常见问题](#常见问题)
2. 运行 `flutter doctor` 检查环境
3. 查看构建日志中的错误信息
4. 提交 [Issue](https://github.com/hakimi-x/Xboard-Mihomo/issues)

---

**祝构建顺利！** 🎉

