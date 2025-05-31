# 📱 Flutter Job - 企业招聘应用

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.32.1-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.8.1-blue?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey)

**🚀 现代化企业招聘移动应用 | 跨平台解决方案 | Flutter驱动 | 响应式设计 | 模块化架构**

[在线演示](#-功能展示) • [技术栈](#️-技术栈) • [快速开始](#-快速开始) • [项目结构](#-项目结构)

</div>

---

## 📋 项目简介

Flutter Job是一款基于Flutter框架开发的现代化企业招聘应用，为企业和求职者提供高效的招聘解决方案。应用采用Material Design设计语言，提供流畅的用户体验和丰富的功能模块。

### 🎯 核心价值
- **📱 跨平台兼容** - 一套代码，支持Android、iOS、Web三端
- **🎨 现代化设计** - Material 3设计规范，优雅的用户界面
- **⚡ 高性能体验** - 60fps流畅动画，快速响应
- **🔧 模块化架构** - 清晰的代码结构，易于维护和扩展

---

## ✨ 核心特色 | Features

### 🏢 功能模块

#### 📖 企业介绍页面
- **公司展示** - 轮播图展示企业环境和文化
- **详细信息** - 企业简介、发展历程、企业文化
- **地址导航** - 集成地图功能，便于求职者了解位置
- **联系方式** - 多种联系方式，便于沟通

#### 💼 招聘职位页面
- **职位展示** - 丰富的职位信息展示
- **智能筛选** - 按岗位类型、薪资范围、工作地点筛选
- **搜索功能** - 关键词搜索，快速定位目标职位
- **职位详情** - 详细的岗位描述和任职要求

#### ❓问答互动页面
- **常见问题** - FAQ模块，解答求职者疑问
- **分类展示** - 按问题类型分类整理
- **搜索定位** - 快速找到相关问题答案
- **互动设计** - 友好的问答界面设计

#### 📰 最新资讯页面
- **企业动态** - 实时更新公司最新消息
- **行业资讯** - 相关行业新闻和趋势
- **图文并茂** - 丰富的多媒体内容展示
- **分享功能** - 支持资讯内容分享

### 🎨 设计特色

- **Material Design 3** - 最新设计规范，现代化视觉体验
- **响应式布局** - 完美适配各种屏幕尺寸
- **深浅主题** - 支持日间/夜间模式切换
- **流畅动画** - 页面切换和交互动画效果
- **无障碍设计** - 支持辅助功能，包容性设计

### ⚡ 性能优化

- **图片懒加载** - 优化内存使用和加载速度
- **数据缓存** - 本地缓存机制，提升用户体验
- **网络优化** - HTTP请求优化，支持重试机制
- **内存管理** - 资源生命周期管理，防止内存泄漏

---

## 🛠️ 技术栈 | Tech Stack

### 📱 核心框架
```yaml
Flutter: 3.32.1          # Google跨平台UI框架
Dart: 3.8.1              # 现代化编程语言
Material Design 3        # 最新设计系统
```

### 🎨 UI组件库
```yaml
bruno_ui: ^3.4.3         # 企业级UI组件库
getwidget: ^2.1.1        # 丰富的Widget集合
photo_view: ^0.14.0      # 图片查看组件
```

### 🌐 网络与数据
```yaml
http: ^0.13.6            # HTTP网络请求
shared_preferences       # 本地数据存储
json_annotation          # JSON序列化支持
```

### 🔧 开发工具
```yaml
flutter_lints: ^5.0.0    # 代码规范检查
build_runner             # 代码生成工具
json_serializable        # JSON模型生成
```

### 🏗️ 架构设计
- **MVC架构模式** - 清晰的代码分层
- **服务化设计** - 数据服务抽象
- **状态管理** - 响应式状态更新
- **模块化开发** - 功能模块独立

---

## 🚀 功能展示 | Screenshots

### 📱 移动端界面

<div align="center">

| 企业介绍 | 招聘职位 | 问答互动 | 最新资讯 |
|:---:|:---:|:---:|:---:|
| ![企业介绍](assets/screenshots/company_intro.png) | ![招聘职位](assets/screenshots/job_positions.png) | ![问答页面](assets/screenshots/qa_page.png) | ![最新资讯](assets/screenshots/news_page.png) |

</div>

### 💻 Web端展示

<div align="center">

| 响应式设计 | 桌面端界面 |
|:---:|:---:|
| ![响应式](assets/screenshots/responsive_design.png) | ![桌面端](assets/screenshots/desktop_view.png) |

</div>

---

## 🚀 快速开始 | Quick Start

### 📋 环境要求

- **Flutter SDK**: 3.0.0+
- **Dart SDK**: 3.0.0+
- **Android Studio**: 4.1+ (Android开发)
- **Xcode**: 12.0+ (iOS开发)
- **VS Code**: 推荐使用

### ⚙️ 安装步骤

#### 1️⃣ 克隆项目
```bash
git clone https://github.com/your-username/flutter-job.git
cd flutter-job
```

#### 2️⃣ 安装依赖
```bash
# 获取Flutter依赖
flutter pub get

# 检查环境配置
flutter doctor
```

#### 3️⃣ 运行项目
```bash
# 在Chrome浏览器中运行（推荐开发时使用）
flutter run -d chrome

# 在Android模拟器中运行
flutter run -d emulator-5554

# 在iOS模拟器中运行（需要macOS）
flutter run -d ios

# 构建APK（Android）
flutter build apk --release

# 构建Web版本
flutter build web
```

### 🔧 开发配置

#### Android配置
```bash
# 创建本地配置文件
echo "org.gradle.java.home=C:\\Program Files\\Android\\Android Studio\\jbr" >> android/gradle.properties
```

#### iOS配置（macOS）
```bash
# 安装CocoaPods依赖
cd ios && pod install
```

---

## 📁 项目结构 | Project Structure

```
flutter-job/
├── 📱 lib/                          # 源代码目录
│   ├── 🎨 constants/                # 常量定义
│   │   ├── app_constants.dart       # 应用常量配置
│   │   └── app_theme.dart           # 主题和样式定义
│   ├── 📊 models/                   # 数据模型
│   │   ├── job_position_model.dart  # 职位数据模型
│   │   ├── news_model.dart          # 新闻数据模型
│   │   └── qa_model.dart            # 问答数据模型
│   ├── 📄 pages/                    # 页面组件
│   │   ├── company_intro_page.dart  # 企业介绍页面
│   │   ├── job_positions_page.dart  # 招聘职位页面
│   │   ├── news_page.dart           # 最新资讯页面
│   │   └── qa_page.dart             # 问答页面
│   ├── 🔧 services/                 # 服务层
│   │   └── data_service.dart        # 数据服务接口
│   └── 🚀 main.dart                 # 应用入口文件
├── 🖼️ assets/                       # 静态资源
│   ├── images/                      # 图片资源
│   │   ├── company/                 # 企业相关图片
│   │   ├── news/                    # 新闻图片
│   │   └── icons/                   # 图标资源
│   └── fonts/                       # 字体文件
├── 🤖 android/                      # Android平台配置
│   ├── app/                         # Android应用配置
│   ├── gradle.properties            # Gradle配置
│   └── build.gradle                 # 构建配置
├── 🍎 ios/                          # iOS平台配置
│   ├── Runner/                      # iOS应用配置
│   └── Podfile                      # iOS依赖管理
├── 🌐 web/                          # Web平台配置
│   ├── index.html                   # Web入口页面
│   └── manifest.json                # Web应用清单
├── 🧪 test/                         # 测试文件
│   └── widget_test.dart             # Widget测试
├── 📝 pubspec.yaml                  # 项目配置文件
├── 📖 README.md                     # 项目文档
└── 📄 LICENSE                       # 开源协议
```

---

## ⚡ 性能优化 | Performance

### 🖼️ 图片优化
- **懒加载机制** - 按需加载图片资源
- **缓存策略** - 本地图片缓存管理
- **格式优化** - 支持WebP等现代图片格式
- **尺寸适配** - 根据设备分辨率加载合适尺寸

### 📦 构建优化
```bash
# 启用代码混淆
flutter build apk --obfuscate --split-debug-info=build/debug-info

# 启用Tree Shaking
flutter build web --release --tree-shake-icons

# 分析包大小
flutter build apk --analyze-size
```

### 🔧 性能监控
- **内存监控** - 实时监控内存使用情况
- **网络优化** - 请求合并和缓存策略
- **渲染优化** - 60fps流畅渲染
- **启动优化** - 应用冷启动时间优化

### 📊 性能指标
- ⚡ **冷启动时间** < 3秒
- 🎯 **内存使用** < 100MB
- 📱 **包体积** < 20MB
- 🔄 **页面切换** < 300ms

---

## 🌐 平台兼容性 | Platform Compatibility

### ✅ 支持平台

| 平台 | 最低版本 | 推荐版本 | 状态 |
|------|---------|---------|------|
| 🤖 **Android** | API 21 (5.0) | API 33+ | ✅ 完全支持 |
| 🍎 **iOS** | iOS 11.0 | iOS 15.0+ | ✅ 完全支持 |
| 🌐 **Web** | Chrome 57+ | Chrome 90+ | ✅ 完全支持 |
| 💻 **Desktop** | - | - | 🚧 计划中 |

### 📱 测试设备
- **Android**: Pixel 6, Samsung Galaxy S21, 小米12
- **iOS**: iPhone 13, iPhone 12, iPad Air
- **Web**: Chrome, Firefox, Safari, Edge

---

## 🔧 开发指南 | Development Guide

### 🎨 代码规范
```bash
# 代码格式化
flutter format .

# 代码分析
flutter analyze

# 运行测试
flutter test
```

### 🧪 测试策略
- **单元测试** - 业务逻辑测试
- **Widget测试** - UI组件测试
- **集成测试** - 端到端测试
- **性能测试** - 内存和渲染性能

### 📋 开发流程
1. **需求分析** - 确定功能需求和技术方案
2. **UI设计** - 遵循Material Design规范
3. **编码实现** - 模块化开发，代码复用
4. **测试验证** - 多平台兼容性测试
5. **性能优化** - 内存和渲染优化
6. **发布部署** - 多平台打包发布

---

## 🚀 部署指南 | Deployment

### 📦 优化打包 | Optimized Build

#### 🎯 通用优化策略
```bash
# 清理项目缓存
flutter clean && flutter pub get

# 启用代码混淆和调试信息分离
flutter build apk --release --obfuscate --split-debug-info=build/debug-info

# 分析包大小
flutter build apk --analyze-size

# 启用Tree Shaking优化
flutter build web --release --tree-shake-icons

# 启用压缩优化
flutter build apk --release --shrink
```

> **💡 PowerShell用户注意**：Windows PowerShell不支持反斜杠续行符，请使用单行命令或使用PowerShell的续行语法：
> ```powershell
> # PowerShell单行格式
> flutter build apk --release --obfuscate --split-debug-info=build/debug-info --shrink
> 
> # PowerShell多行格式（使用反引号）
> flutter build apk --release `
>   --obfuscate `
>   --split-debug-info=build/debug-info `
>   --shrink `
>   --split-per-abi
> ```

#### 🔧 高级优化配置

##### 代码混淆配置
```bash
# 创建混淆规则文件 (android/app/proguard-rules.pro)
# 生产环境构建时启用混淆
flutter build apk --release \
  --obfuscate \
  --split-debug-info=build/debug-info \
  --dart-define=FLAVOR=production
```

##### 资源优化
```bash
# 图片资源压缩
flutter build apk --release --compress

# 启用资源收缩
# 在 android/app/build.gradle 中配置:
# buildTypes {
#     release {
#         shrinkResources true
#         minifyEnabled true
#     }
# }
```

##### 多架构优化
```bash
# 为不同CPU架构分别打包 (减小单个包体积)
flutter build apk --release --split-per-abi

# 生成所有架构的包
flutter build apk --release --target-platform android-arm,android-arm64,android-x64
```

#### 📊 包大小分析
```bash
# 详细分析APK内容
flutter build apk --analyze-size --target-platform=android-arm64

# 生成大小报告
flutter build apk --release --analyze-size > build_analysis.txt

# 比较不同版本包大小
flutter build apk --release --analyze-size --compare-to=previous_build.apk
```

### 📱 Android部署
```bash
# 标准发布构建
flutter build apk --release

# 优化版发布构建 (推荐生产环境)
flutter build apk --release \
  --obfuscate \
  --split-debug-info=build/android-debug-info \
  --shrink \
  --split-per-abi

# 生成签名密钥
keytool -genkey -v -keystore android/app/release-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias release

# 构建App Bundle (推荐发布到Google Play)
flutter build appbundle --release \
  --obfuscate \
  --split-debug-info=build/android-debug-info

# 验证APK签名
jarsigner -verify -verbose -certs build/app/outputs/flutter-apk/app-release.apk
```

#### 💻 PowerShell用户命令参考
```powershell
# 优化版发布构建 (PowerShell格式)
flutter build apk --release --obfuscate --split-debug-info=build/android-debug-info --shrink --split-per-abi

# 或使用PowerShell多行格式
flutter build apk --release `
  --obfuscate `
  --split-debug-info=build/android-debug-info `
  --shrink `
  --split-per-abi

# 构建App Bundle
flutter build appbundle --release --obfuscate --split-debug-info=build/android-debug-info

# 生成签名密钥 (单行格式)
keytool -genkey -v -keystore android/app/release-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias release
```

### 🍎 iOS部署
```bash
# 优化版iOS构建
flutter build ios --release \
  --obfuscate \
  --split-debug-info=build/ios-debug-info

# 构建IPA文件
flutter build ipa --release \
  --obfuscate \
  --split-debug-info=build/ios-debug-info \
  --export-method=app-store

# 构建企业版IPA
flutter build ipa --release \
  --export-method=enterprise \
  --obfuscate

# 验证IPA文件
xcrun altool --validate-app -f build/ios/ipa/flutter_job.ipa \
  -t ios -u your-apple-id@example.com
```

### 🌐 Web部署
```bash
# 优化版Web构建
flutter build web --release \
  --tree-shake-icons \
  --dart-define=FLUTTER_WEB_USE_SKIA=true \
  --web-renderer=canvaskit

# PWA优化构建
flutter build web --release \
  --pwa-strategy=offline-first \
  --tree-shake-icons \
  --dart-define=FLUTTER_WEB_PWA=true

# 启用Gzip压缩
flutter build web --release && \
  find build/web -name "*.js" -exec gzip -k {} \; && \
  find build/web -name "*.css" -exec gzip -k {} \;

# 生成Web性能报告
flutter build web --release --source-maps
```

#### 🔍 性能分析工具
```bash
# Flutter Inspector
flutter run --observatory-port=9999 --disable-service-auth-codes

# 内存分析
flutter run --profile --trace-startup

# 网络分析
flutter run --verbose --enable-network-logging

# DevTools性能分析
flutter pub global activate devtools
flutter pub global run devtools
```

#### 📈 打包优化最佳实践

##### 🎯 减小包体积
- ✅ 启用代码混淆和Tree Shaking
- ✅ 使用WebP格式图片
- ✅ 移除未使用的资源和依赖
- ✅ 启用资源收缩
- ✅ 分架构打包

##### ⚡ 提升性能
- ✅ 使用release模式构建
- ✅ 启用AOT编译
- ✅ 优化图片和字体资源
- ✅ 实现代码分割和懒加载
- ✅ 配置合适的渲染器

##### 🔒 安全性优化
- ✅ 启用代码混淆
- ✅ 分离调试信息
- ✅ 移除开发调试代码
- ✅ 配置安全的网络传输
- ✅ 保护敏感数据

### 🔧 CI/CD配置
```yaml
# .github/workflows/build.yml
name: Build and Test
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter test
      - run: flutter build apk
```

#### 🚀 自动化部署配置

##### GitHub Actions完整配置
```yaml
# .github/workflows/deploy.yml
name: Build and Deploy
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  # 代码质量检查
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.32.1'
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test

  # Android构建
  build-android:
    needs: analyze
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: |
          flutter build apk --release \
            --obfuscate \
            --split-debug-info=build/android-debug-info \
            --shrink
      - uses: actions/upload-artifact@v3
        with:
          name: android-apk
          path: build/app/outputs/flutter-apk/

  # iOS构建 (需要macOS)
  build-ios:
    needs: analyze
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: |
          flutter build ios --release \
            --obfuscate \
            --split-debug-info=build/ios-debug-info \
            --no-codesign
      - uses: actions/upload-artifact@v3
        with:
          name: ios-app
          path: build/ios/iphoneos/

  # Web构建和部署
  build-web:
    needs: analyze
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v3
      - run: flutter pub get
      - run: |
          flutter build web --release \
            --tree-shake-icons \
            --web-renderer=canvaskit
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        if: github.ref == 'refs/heads/main'
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./build/web
```

##### 🔥 Firebase部署配置
```yaml
# firebase部署步骤
- name: Deploy to Firebase Hosting
  uses: FirebaseExtended/action-hosting-deploy@v0
  with:
    repoToken: '${{ secrets.GITHUB_TOKEN }}'
    firebaseServiceAccount: '${{ secrets.FIREBASE_SERVICE_ACCOUNT }}'
    projectId: flutter-job-app
    channelId: live
```

##### 📱 Google Play自动发布
```yaml
# Google Play Console发布
- name: Deploy to Play Store
  uses: r0adkll/upload-google-play@v1
  with:
    serviceAccountJsonPlainText: ${{ secrets.GOOGLE_PLAY_SERVICE_ACCOUNT }}
    packageName: com.example.flutter_job
    releaseFiles: build/app/outputs/bundle/release/app-release.aab
    track: production
    inAppUpdatePriority: 2
```

#### 🌐 平台部署指南

##### 📱 Google Play Store发布
```bash
# 1. 构建App Bundle
flutter build appbundle --release \
  --obfuscate \
  --split-debug-info=build/android-debug-info

# 2. 上传到Play Console
# 通过Web界面或使用API上传 build/app/outputs/bundle/release/app-release.aab

# 3. 配置发布信息
# - 应用图标和截图
# - 应用描述和关键词
# - 定价和分发设置
```

##### 🍎 App Store发布
```bash
# 1. 构建IPA
flutter build ipa --release \
  --obfuscate \
  --split-debug-info=build/ios-debug-info \
  --export-method=app-store

# 2. 使用Xcode或Transporter上传
xcrun altool --upload-app -f build/ios/ipa/flutter_job.ipa \
  -u your-apple-id@example.com \
  -p your-app-specific-password

# 3. App Store Connect配置
# - 应用元数据
# - 审核信息
# - 定价和销售范围
```

##### 🌐 Web平台部署

###### GitHub Pages部署
```bash
# 1. 构建Web版本
flutter build web --release --tree-shake-icons

# 2. 部署到GitHub Pages
git subtree push --prefix build/web origin gh-pages

# 3. 配置自定义域名 (可选)
echo "your-domain.com" > build/web/CNAME
```

###### Firebase Hosting部署
```bash
# 1. 安装Firebase CLI
npm install -g firebase-tools

# 2. 初始化Firebase项目
firebase init hosting

# 3. 构建并部署
flutter build web --release
firebase deploy --only hosting

# 4. 配置自定义域名
firebase hosting:channel:deploy production
```

###### Netlify部署
```bash
# 1. 安装Netlify CLI
npm install -g netlify-cli

# 2. 构建项目
flutter build web --release

# 3. 部署到Netlify
netlify deploy --prod --dir=build/web

# 4. 配置重定向规则 (build/web/_redirects)
/*    /index.html   200
```

#### 📊 部署后优化验证

##### 🔍 性能检测
```bash
# 使用Lighthouse进行Web性能测试
lighthouse https://your-app-url.com --output html --output-path ./performance-report.html

# 移动端性能测试
lighthouse https://your-app-url.com --preset=perf --form-factor=mobile

# 渐进式Web应用检测
lighthouse https://your-app-url.com --preset=pwa
```

##### 📱 设备兼容性测试
- **Android**: 不同厂商设备测试 (Samsung, Xiaomi, Huawei等)
- **iOS**: 不同iOS版本兼容性测试
- **Web**: 跨浏览器兼容性验证 (Chrome, Firefox, Safari, Edge)

##### 🌍 多地区部署验证
- CDN加速配置
- 多地区访问速度测试
- 国际化内容验证

---

## 🤝 贡献指南 | Contributing

我们欢迎所有形式的贡献！🎉

### 🐛 问题反馈
- 在GitHub Issues中报告Bug
- 提供详细的复现步骤
- 包含设备和系统信息

### 💡 功能建议
- 通过Issues提出新功能建议
- 详细描述使用场景和预期效果
- 讨论技术实现方案

### 🔧 代码贡献
```bash
# 1. Fork项目
# 2. 创建特性分支
git checkout -b feature/your-feature

# 3. 提交更改
git commit -m "Add: your feature description"

# 4. 推送到分支
git push origin feature/your-feature

# 5. 创建Pull Request
```

### 📝 代码规范
- 遵循Dart官方代码规范
- 添加必要的注释和文档
- 确保所有测试通过
- 遵循项目的架构设计

---

## 📈 开发计划 | Roadmap

### 🎯 短期目标 (Q1 2024)
- [x] ✅ 基础功能模块开发
- [x] ✅ Material Design 3适配
- [x] ✅ 多平台兼容性优化
- [ ] 🚧 用户登录注册功能
- [ ] 🚧 职位申请和简历管理

### 🚀 中期目标 (Q2-Q3 2024)
- [ ] 📋 实时聊天功能
- [ ] 🔔 消息推送系统
- [ ] 📊 数据统计和分析
- [ ] 🌙 深色主题完善
- [ ] 🌍 国际化多语言支持

### 💫 长期目标 (Q4 2024+)
- [ ] 🤖 AI职位推荐算法
- [ ] 📱 桌面端应用开发
- [ ] 🔌 第三方平台集成
- [ ] 📈 大数据分析平台
- [ ] 🎨 自定义主题系统

---

## 📄 许可证 | License

本项目采用 [MIT License](LICENSE) 开源协议。

```
MIT License

Copyright (c) 2024 Flutter Job Team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

## 🔗 相关链接 | Links


- 🌐 **在线演示**: [Flutter Job Demo](https://flutter-job-demo.web.app)
- 📱 **Android下载**: [Google Play Store](#)
- 🍎 **iOS下载**: [App Store](#)
- 📖 **技术文档**: [开发文档](docs/README.md)



---
<div align="center">

**🌟 如果这个项目对您有帮助，请给个 Star 支持一下！**

<p>
  <img src="https://img.shields.io/github/stars/NextEraAbyss/cv?style=social" alt="GitHub stars">
  <img src="https://img.shields.io/github/forks/NextEraAbyss/cv?style=social" alt="GitHub forks">
</p>

*Built with ❤️ by [秦若宸](https://cv.wat.ink)*

**💼 展示您的全栈技术能力，成就技术人生！**

</div>