# Flutter Job - 企业招聘应用

一个使用Flutter开发的企业招聘展示应用，包含企业介绍、招聘职位、问答和最新资讯等功能。

## 功能特点

- **企业介绍页面**：展示公司简介和地址信息，顶部轮播图展示公司环境
- **招聘职位页面**：展示公司发布的招聘职位，包含职位筛选和搜索功能
- **问答页面**：展示常见问题及解答，帮助求职者了解公司情况
- **最新资讯页面**：展示公司最新动态和新闻

## 技术栈

- Flutter 3.x
- Bruno UI 组件库
- GetWidget UI 组件库

## 项目结构

```
lib/
├── constants/          # 常量定义
│   ├── app_constants.dart  # 应用常量
│   └── app_theme.dart      # 应用主题和样式
├── models/             # 数据模型
│   ├── job_position_model.dart  # 职位数据模型
│   ├── news_model.dart          # 新闻数据模型
│   └── qa_model.dart            # 问答数据模型
├── pages/              # 页面组件
│   ├── company_intro_page.dart  # 企业介绍页面
│   ├── job_positions_page.dart  # 招聘职位页面
│   ├── news_page.dart           # 最新资讯页面
│   └── qa_page.dart             # 问答页面
├── services/           # 服务层
│   └── data_service.dart        # 数据服务
└── main.dart           # 应用入口

assets/
└── images/             # 图片资源
    ├── company1.jpg           # 公司图片
    ├── news_red_panda.jpg     # 红熊猫新闻图片
    ├── news_groundhog.jpg     # 土拨鼠新闻图片
    ├── news_panda.jpg         # 熊猫新闻图片
    ├── news_building.jpg      # 建筑新闻图片
    └── news_meerkat.jpg       # 猫鼬新闻图片
```

## 如何运行

1. 确保已安装Flutter环境和依赖
```bash
flutter pub get
```

2. 运行应用
```bash
flutter run
```

## 开发计划

- [ ] 添加登录和注册功能
- [ ] 实现职位申请表单提交
- [ ] 添加职位详情页面
- [ ] 优化移动端适配
- [ ] 添加主题切换功能
