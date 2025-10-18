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

请确保已安装以下工具：

- **Flutter SDK** - [下载安装](https://flutter.dev/docs/get-started/install)
- **Golang** - [下载安装](https://golang.org/dl/)

安装完成后验证：
```bash
flutter doctor
go version
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
- Android SDK 和 NDK（通过 Android Studio 安装）
- 设置环境变量 `ANDROID_NDK` 指向 NDK 路径

#### 运行构建

```bash
dart setup.dart android
```

**构建输出：** `build/app/outputs/flutter-apk/app-release.apk`

---

### 🪟 Windows 构建

#### 前置要求
- GCC 编译器（[MinGW-w64](https://www.mingw-w64.org/) 或 [TDM-GCC](https://jmeubank.github.io/tdm-gcc/)）
- Inno Setup（用于打包安装程序）

#### 运行构建

```bash
dart setup.dart windows --arch amd64   # AMD64 架构
dart setup.dart windows --arch arm64   # ARM64 架构
```

**构建输出：** `build/windows/runner/Release/xboard_mihomo.exe`

---

### 🍎 macOS 构建

#### 前置要求
- Xcode（从 App Store 安装）
- Xcode Command Line Tools：`xcode-select --install`
- CocoaPods：`sudo gem install cocoapods`

#### 运行构建

```bash
dart setup.dart macos --arch amd64   # Intel 芯片
dart setup.dart macos --arch arm64   # Apple Silicon
```

**构建输出：** `build/macos/Build/Products/Release/Xboard Mihomo.app`

---

### 🐧 Linux 构建

#### 前置要求

安装系统依赖（Ubuntu/Debian）：
```bash
sudo apt-get install -y \
  clang cmake ninja-build pkg-config \
  libgtk-3-dev libayatana-appindicator3-dev libkeybinder-3.0-dev
```

#### 运行构建

```bash
dart setup.dart linux --arch amd64   # AMD64 架构
dart setup.dart linux --arch arm64   # ARM64 架构
```

**构建输出：** `build/linux/<arch>/release/bundle/xboard_mihomo`

---

## 平台特定说明

### 架构选择

```bash
# 查看系统架构
uname -m          # Linux/macOS
# x86_64 → 使用 amd64
# arm64 → 使用 arm64
```

### 跨平台编译

- Windows/macOS/Linux 只能在对应系统上构建
- Android 可以在任何平台上构建

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

### 子模块更新失败
```bash
git submodule deinit -f --all
git submodule update --init --recursive
```

### SDK 代码生成失败
```bash
cd lib/sdk/flutter_xboard_sdk
flutter clean && flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### NDK 未找到
设置环境变量：
```bash
export ANDROID_NDK=/path/to/ndk  # Linux/macOS
```

### Flutter 依赖冲突
```bash
flutter clean
flutter pub get
```

---

## 📚 相关文档

- [配置文档](./README.md)
- [快速开始](./quick-start.md)
- [FlClash 项目](https://github.com/chen08209/FlClash)

---

**遇到问题？** 提交 [Issue](https://github.com/hakimi-x/Xboard-Mihomo/issues)

