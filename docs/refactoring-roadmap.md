# UI 分离重构路线图

## 📋 项目概述

**目标**：将现有项目重构为 UI/业务完全分离的架构  
**方案**：方案 B - 全面重构  
**周期**：3-5 周  
**开始日期**：2025-10-19

---

## 🎯 总体目标

- ✅ 实现业务逻辑和 UI 的完全分离
- ✅ 创建 DefaultUI 包（基于现有 UI）
- ✅ 创建 ModernUI 包（全新设计）
- ✅ 建立 UI 注册和动态加载机制
- ✅ 保持所有现有功能正常工作
- ✅ 性能不下降

---

## 📅 五个阶段

### 第一阶段：核心架构搭建（1周）

**目标**：建立基础框架和核心机制

#### 任务清单

- [x] 创建目录结构
  - [x] `lib/core/` - 业务层
  - [x] `lib/ui/` - UI 抽象层
  - [x] `packages/ui_themes/` - UI 主题包

- [ ] 实现核心类
  - [ ] `UIRegistry` - UI 注册中心
  - [ ] `ContractBase` - 契约基类
  - [ ] `UIThemeBase` - 主题包基类
  - [ ] `UIManager` - UI 管理器

- [ ] 建立契约系统
  - [ ] 定义契约规范
  - [ ] 创建数据模型模板
  - [ ] 创建回调模型模板

- [ ] 设置开发工具
  - [ ] 代码生成工具（可选）
  - [ ] 脚手架脚本

**产出**：
- 完整的基础架构
- 可运行的 Demo（1-2 个页面）
- 开发文档

**时间**：5-7 天

---

### 第二阶段：业务层抽象（1-2周）

**目标**：重构所有页面，分离业务逻辑和 UI

#### 2.1 主要页面重构（10-14天）

##### 1. 首页 (HomePage) - 2天
- [ ] 定义 `HomePageContract`
- [ ] 定义 `HomePageData` 和 `HomePageCallbacks`
- [ ] 重构 `HomePage` 控制器
- [ ] 提取业务逻辑到 Provider

##### 2. 配置页面 (ProfilesPage) - 2天
- [ ] 定义 `ProfilesPageContract`
- [ ] 定义数据和回调模型
- [ ] 重构控制器
- [ ] 提取订阅管理逻辑

##### 3. 代理页面 (ProxiesPage) - 2天
- [ ] 定义 `ProxiesPageContract`
- [ ] 定义数据和回调模型
- [ ] 重构控制器
- [ ] 提取代理切换逻辑

##### 4. 连接页面 (ConnectionPage) - 1天
- [ ] 定义 `ConnectionPageContract`
- [ ] 定义数据和回调模型
- [ ] 重构控制器

##### 5. 设置页面 (SettingsPage) - 2天
- [ ] 定义 `SettingsPageContract`
- [ ] 定义数据和回调模型
- [ ] 重构控制器
- [ ] 提取设置逻辑

##### 6. 其他页面 - 2-3天
- [ ] Dashboard
- [ ] Logs
- [ ] Tools
- [ ] About
- [ ] XBoard 相关页面

#### 2.2 组件契约定义（2-3天）

- [ ] 卡片组件 (`CardContract`)
- [ ] 列表组件 (`ListContract`)
- [ ] 对话框组件 (`DialogContract`)
- [ ] 按钮组件 (`ButtonContract`)
- [ ] 图表组件 (`ChartContract`)
- [ ] 输入组件 (`InputContract`)

**产出**：
- 所有页面的契约定义
- 重构后的业务控制器
- 独立的业务逻辑层

**时间**：10-14 天

---

### 第三阶段：DefaultUI 实现（1周）

**目标**：基于现有 UI 创建 DefaultUI 包

#### 任务清单

- [ ] 创建 DefaultUI 包结构
  - [ ] `packages/ui_themes/default_ui/`
  - [ ] `pubspec.yaml`
  - [ ] README.md

- [ ] 实现页面组件（5-7天）
  - [ ] `DefaultHomePage`
  - [ ] `DefaultProfilesPage`
  - [ ] `DefaultProxiesPage`
  - [ ] `DefaultConnectionPage`
  - [ ] `DefaultSettingsPage`
  - [ ] 其他页面

- [ ] 实现通用组件（2-3天）
  - [ ] `DefaultCard`
  - [ ] `DefaultList`
  - [ ] `DefaultDialog`
  - [ ] `DefaultButton`
  - [ ] `DefaultChart`

- [ ] 注册和测试
  - [ ] 实现 `DefaultUITheme.register()`
  - [ ] 集成测试
  - [ ] 功能验证

**产出**：
- 完整的 DefaultUI 包
- 与原有 UI 一致的视觉效果
- 所有功能正常工作

**时间**：7 天

---

### 第四阶段：ModernUI 实现（1周）

**目标**：创建全新设计风格的 ModernUI 包

#### 任务清单

- [ ] 设计规范制定（1天）
  - [ ] 颜色方案
  - [ ] 布局风格
  - [ ] 动画效果
  - [ ] 交互模式

- [ ] 创建 ModernUI 包结构
  - [ ] `packages/ui_themes/modern_ui/`
  - [ ] pubspec.yaml
  - [ ] README.md

- [ ] 实现页面组件（4-5天）
  - [ ] `ModernHomePage` - 全新布局
  - [ ] `ModernProfilesPage` - 卡片网格
  - [ ] `ModernProxiesPage` - 动态列表
  - [ ] `ModernConnectionPage` - 可视化图表
  - [ ] `ModernSettingsPage` - 分组卡片
  - [ ] 其他页面

- [ ] 实现通用组件（2天）
  - [ ] `ModernCard` - 毛玻璃效果
  - [ ] `ModernList` - 动画列表
  - [ ] `ModernDialog` - 底部弹窗
  - [ ] `ModernButton` - 浮动按钮
  - [ ] `ModernChart` - 交互图表

- [ ] 动画和特效（1天）
  - [ ] 页面转场动画
  - [ ] 组件进入动画
  - [ ] 微交互效果

- [ ] 注册和测试
  - [ ] 实现 `ModernUITheme.register()`
  - [ ] 集成测试
  - [ ] 性能优化

**产出**：
- 完整的 ModernUI 包
- 全新的视觉体验
- 流畅的动画效果

**时间**：7 天

---

### 第五阶段：测试和优化（3-5天）

**目标**：全面测试、修复 bug、性能优化

#### 任务清单

##### 功能测试（2天）
- [ ] DefaultUI 功能测试
  - [ ] 所有页面功能验证
  - [ ] 交互逻辑测试
  - [ ] 数据流测试

- [ ] ModernUI 功能测试
  - [ ] 所有页面功能验证
  - [ ] 动画效果测试
  - [ ] 性能测试

- [ ] 主题切换测试
  - [ ] 热切换测试
  - [ ] 重启切换测试
  - [ ] 配置持久化测试

##### Bug 修复（1-2天）
- [ ] 收集 bug 清单
- [ ] 优先级排序
- [ ] 逐个修复
- [ ] 回归测试

##### 性能优化（1天）
- [ ] 启动性能
- [ ] 页面渲染性能
- [ ] 内存占用
- [ ] 动画流畅度

##### 文档完善（1天）
- [ ] 开发文档
- [ ] API 文档
- [ ] 使用指南
- [ ] 最佳实践

**产出**：
- 稳定可用的系统
- 完整的文档
- 性能报告

**时间**：3-5 天

---

## 📊 进度跟踪

### 总体进度

| 阶段 | 状态 | 开始日期 | 结束日期 | 实际用时 |
|------|------|----------|----------|----------|
| 第一阶段：核心架构 | 🟡 进行中 | 2025-10-19 | - | - |
| 第二阶段：业务层抽象 | ⚪ 未开始 | - | - | - |
| 第三阶段：DefaultUI | ⚪ 未开始 | - | - | - |
| 第四阶段：ModernUI | ⚪ 未开始 | - | - | - |
| 第五阶段：测试优化 | ⚪ 未开始 | - | - | - |

### 详细进度

#### 第一阶段：核心架构（0%）

- [ ] 0/4 - 创建目录结构
- [ ] 0/4 - 实现核心类
- [ ] 0/3 - 建立契约系统
- [ ] 0/2 - 设置开发工具

#### 第二阶段：业务层抽象（0%）

- [ ] 0/6 - 主要页面重构
- [ ] 0/6 - 组件契约定义

#### 第三阶段：DefaultUI（0%）

- [ ] 0/3 - 包结构创建
- [ ] 0/6 - 页面组件实现
- [ ] 0/5 - 通用组件实现
- [ ] 0/3 - 注册和测试

#### 第四阶段：ModernUI（0%）

- [ ] 0/1 - 设计规范
- [ ] 0/3 - 包结构创建
- [ ] 0/6 - 页面组件实现
- [ ] 0/5 - 通用组件实现
- [ ] 0/3 - 动画和特效
- [ ] 0/3 - 注册和测试

#### 第五阶段：测试优化（0%）

- [ ] 0/3 - 功能测试
- [ ] 0/4 - Bug 修复
- [ ] 0/4 - 性能优化
- [ ] 0/4 - 文档完善

---

## 🎯 关键里程碑

| 里程碑 | 目标日期 | 标准 |
|--------|----------|------|
| M1: 核心架构完成 | Day 7 | 基础框架可运行，Demo 可用 |
| M2: 业务层重构完成 | Day 21 | 所有页面契约化，业务逻辑独立 |
| M3: DefaultUI 完成 | Day 28 | DefaultUI 包功能完整，与原 UI 一致 |
| M4: ModernUI 完成 | Day 35 | ModernUI 包功能完整，视觉效果优秀 |
| M5: 项目交付 | Day 40 | 测试通过，文档完善，可正式使用 |

---

## ⚠️ 风险管理

### 高风险项

| 风险 | 等级 | 缓解措施 | 负责人 |
|------|------|----------|--------|
| 业务逻辑提取复杂 | 🔴 高 | 从简单页面开始，逐步推进 | 开发者 |
| 性能下降 | 🟡 中 | 及时性能测试，优化关键路径 | 开发者 |
| 兼容性问题 | 🟡 中 | 保留降级方案，充分测试 | 开发者 |
| 工期延误 | 🟡 中 | 合理安排任务，及时调整计划 | 开发者 |

### 应对策略

1. **每日进度回顾**：检查完成情况，调整计划
2. **每周里程碑检查**：确保按计划推进
3. **问题及时记录**：遇到问题立即记录，寻求解决方案
4. **代码审查**：关键代码及时审查，保证质量

---

## 📝 工作规范

### 代码规范

1. **命名规范**
   - Contract: `[PageName]PageContract`
   - Data: `[PageName]PageData`
   - Callbacks: `[PageName]PageCallbacks`
   - UI 实现: `[Theme][PageName]Page`

2. **文件组织**
   ```
   lib/
   ├── core/
   │   ├── models/
   │   ├── services/
   │   ├── providers/
   │   └── controllers/
   │       └── [page_name]_controller.dart
   │
   ├── ui/
   │   ├── contracts/
   │   │   ├── pages/
   │   │   │   └── [page_name]_page_contract.dart
   │   │   └── components/
   │   │       └── [component_name]_contract.dart
   │   └── registry/
   │       └── ui_registry.dart
   │
   └── packages/ui_themes/
       ├── default_ui/
       │   └── lib/
       │       ├── pages/
       │       │   └── default_[page_name]_page.dart
       │       └── components/
       │           └── default_[component_name].dart
       └── modern_ui/
           └── lib/
               ├── pages/
               └── components/
   ```

3. **注释规范**
   - 所有 Contract 必须有详细注释
   - 所有公开 API 必须有文档注释
   - 复杂逻辑必须有实现说明

### 提交规范

- `feat: 功能描述` - 新功能
- `refactor: 重构描述` - 代码重构
- `fix: 修复描述` - Bug 修复
- `docs: 文档描述` - 文档更新
- `test: 测试描述` - 测试相关
- `perf: 优化描述` - 性能优化

### 分支策略

- `main` - 主分支（稳定版本）
- `develop` - 开发分支
- `feature/ui-separation` - 当前重构分支
- `feature/[feature-name]` - 功能分支

---

## 📚 参考资源

### 内部文档

- [UI 分离架构方案](./ui-separation-architecture.md)
- [UI 分离实现逻辑](./ui-separation-logic.md)
- [主题系统方案](./ui-theme-system.md)

### 外部资源

- [Flutter 架构指南](https://docs.flutter.dev/development/data-and-backend/state-mgmt/intro)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Material Design 3](https://m3.material.io/)

---

## 📞 沟通机制

### 日常沟通

- **每日站会**（可选）：同步进度，讨论问题
- **文档更新**：及时更新进度和问题
- **代码审查**：关键代码提交后及时审查

### 问题升级

1. **技术问题**：记录到文档，讨论解决方案
2. **工期问题**：及时调整计划
3. **方案问题**：组织讨论，达成共识

---

## ✅ 验收标准

### 功能验收

- [ ] 所有现有功能正常工作
- [ ] DefaultUI 与原 UI 视觉效果一致
- [ ] ModernUI 设计优秀，体验流畅
- [ ] 主题切换功能正常
- [ ] 无严重 Bug

### 代码质量

- [ ] 代码结构清晰，符合架构设计
- [ ] 契约定义完整，文档齐全
- [ ] 测试覆盖充分
- [ ] 性能达标（启动时间、渲染性能）

### 文档验收

- [ ] 架构文档完整
- [ ] API 文档齐全
- [ ] 使用指南清晰
- [ ] 开发指南详细

---

## 🎉 项目交付

### 交付物清单

1. **代码**
   - 重构后的源代码
   - DefaultUI 包
   - ModernUI 包
   - 测试代码

2. **文档**
   - 架构设计文档
   - API 文档
   - 使用指南
   - 开发指南
   - 最佳实践

3. **其他**
   - 性能测试报告
   - 问题记录和解决方案
   - 经验总结

---

**最后更新**: 2025-10-19  
**版本**: 1.0  
**状态**: 🟡 进行中

