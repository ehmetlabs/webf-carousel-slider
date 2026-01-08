[根目录](../../CLAUDE.md) > [native_uis](../) > **webf_carousel_slider**

---

# WebF Carousel Slider - Flutter 包

## 变更记录 (Changelog)

### 2026-01-06
- 初始化模块文档
- 完成代码结构与 API 分析
- 生成测试覆盖清单

---

## 模块职责

`webf_carousel_slider` 是 WebF Carousel Slider 项目的核心 Flutter 包，负责：

1. **Custom Element 实现** - 将 `carousel_slider_plus` Flutter 组件包装为 WebF Custom Element
2. **属性绑定** - 提供 HTML 属性到 Dart 属性的双向绑定
3. **方法暴露** - 将 Flutter 控制器方法暴露给 JavaScript
4. **事件派发** - 在页面变化时向 JavaScript 层派发自定义事件
5. **类型定义导出** - 生成 TypeScript 类型定义文件

---

## 入口与启动

### 主入口文件

**`lib/webf_carousel_slider.dart`**

```dart
// 导出核心组件
export 'src/carousel_slider.dart';

// 安装函数 - 在 Flutter 应用的 main() 中调用
void installWebFCarouselSlider() {
  WebF.defineCustomElement('carousel-slider', (context) {
    return CarouselSliderElement(context);
  });
}
```

### 初始化示例

```dart
import 'package:webf_carousel_slider/webf_carousel_slider.dart';

void main() {
  // 1. 初始化 WebF Controller Manager
  WebFControllerManager.instance.initialize(
    WebFControllerManagerConfig(
      maxAliveInstances: 2,
      maxAttachedInstances: 1,
    ),
  );

  // 2. 安装 Carousel Slider 组件
  installWebFCarouselSlider();

  // 3. 运行应用
  runApp(MyApp());
}
```

---

## 对外接口

### Custom Element: `<carousel-slider>`

**标签名**: `carousel-slider`

**HTML 属性映射**（见 `lib/src/carousel_slider_bindings_generated.dart`）:

| HTML 属性 | Dart 属性 | 类型 | 默认值 |
|-----------|----------|------|--------|
| `current-index` | `currentIndex` | `double?` | `0` |
| `autoplay` | `autoplay` | `bool` | `false` |
| `autoplay-interval` | `autoplayInterval` | `double?` | `3.0` (秒) |
| `enable-infinite-scroll` | `enableInfiniteScroll` | `bool` | `true` |
| `aspect-ratio` | `aspectRatio` | `double?` | `0.0` |
| `enlarge-center-page` | `enlargeCenterPage` | `bool` | `false` |
| `viewport-fraction` | `viewportFraction` | `double?` | `1.0` |
| `auto-play-animation-duration` | `autoPlayAnimationDuration` | `double?` | `800` (毫秒) |
| `auto-play-curve` | `autoPlayCurve` | `enum` | `Curves.ease` |
| `initial-page` | `initialPage` | `double?` | `0` |
| `reverse` | `reverse` | `bool` | `false` |
| `scroll-direction` | `scrollDirection` | `enum` | `Axis.horizontal` |
| `pad-ends` | `padEnds` | `bool` | `true` |
| `height` | `height` | `String?` | - |
| `options` | `options` | `String?` (JSON) | - |

### JavaScript 方法

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `next()` | - | `void` | 下一页 |
| `previous()` | - | `void` | 上一页 |
| `jumpToPage(page: number)` | `page: number` | `void` | 跳转到指定页 |
| `pause()` | - | `void` | 暂停自动播放 |
| `resume()` | - | `void` | 恢复自动播放 |

### JavaScript 事件

| 事件名 | 事件类型 | `detail` 字段 | 触发时机 |
|--------|----------|---------------|----------|
| `change` | `CustomEvent` | `{ index: number, reason: string }` | 页面变化时 |
| `pageAnimationStart` | `Event` | - | 页面动画开始 |
| `pageAnimationEnd` | `Event` | - | 页面动画结束 |

---

## 关键依赖与配置

### 依赖项 (`pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter
  webf: ^0.24.2                    # WebF 框架核心
  carousel_slider_plus: ^7.1.1     # 底层轮播组件

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0            # Dart 代码规范
```

### 环境要求

- Dart SDK: `>=3.0.0 <4.0.0`
- Flutter: `>=3.16.0`

---

## 数据模型

### 核心类结构

```
WidgetElement (WebF 基类)
    ↓
CarouselSliderElement
    ├── 属性 (Properties)
    │   ├── currentIndex (int)
    │   ├── autoplay (bool)
    │   ├── autoplayInterval (double)
    │   ├── aspectRatio (double)
    │   ├── viewportFraction (double)
    │   └── ...其他配置
    │
    ├── 方法 (Methods)
    │   ├── next()
    │   ├── previous()
    │   ├── jumpToPage(int page)
    │   ├── pause()
    │   └── resume()
    │
    └── State
        └── CarouselSliderElementState
            ├── _controller (CarouselSliderController)
            ├── _buildOptions() → CarouselOptions
            ├── _onPageChanged(int, CarouselPageChangedReason)
            └── build() → Widget
```

### CarouselOptions 配置映射

```dart
CarouselOptions(
  height: null,                              // 从 height 属性解析
  aspectRatio: widgetElement.aspectRatio,     // 从 aspect-ratio 属性
  viewportFraction: widgetElement.viewportFraction,  // 从 viewport-fraction
  initialPage: widgetElement.currentIndex,    // 从 current-index
  enableInfiniteScroll: widgetElement.enableInfiniteScroll,  // 从 enable-infinite-scroll
  autoPlay: widgetElement.autoplay,           // 从 autoplay
  autoPlayInterval: Duration(                 // 从 autoplay-interval (秒→毫秒)
    milliseconds: (widgetElement.autoplayInterval * 1000).toInt()
  ),
  enlargeCenterPage: widgetElement.enlargeCenterPage,  // 从 enlarge-center-page
  scrollDirection: Axis.horizontal,           // 从 scroll-direction enum
  onPageChanged: _onPageChanged,             // 内部回调，派发 change 事件
)
```

---

## 测试与质量

### 测试文件

**`test/carousel_slider_widget_test.dart`** (454 行)

测试覆盖：
- ✅ Widget 渲染测试（默认/自定义选项）
- ✅ CarouselOptions 构造与验证
- ✅ 边界条件（空列表、单项、大量项）
- ✅ 属性验证（viewportFraction、aspectRatio、autoplayInterval）
- ✅ 集成测试场景
- ✅ 边缘情况（极端值、负数等）

### 运行测试

```bash
# 单元测试
flutter test

# 覆盖率报告
flutter test --coverage

# 查看覆盖率报告
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### 代码质量工具

- **Lints**: `flutter_lints` ^6.0.0
- **格式化**: `dart format .`
- **静态分析**: `flutter analyze`

---

## 常见问题 (FAQ)

### Q1: 为什么自动播放不工作？

**A**: 检查以下几点：
1. 确保 `autoplay` 属性设置为 `true`
2. `autoplayInterval` 单位是**秒**，不是毫秒
3. 不要在用户交互后立即调用 `pause()`，因为这会覆盖自动播放状态

### Q2: 如何在 JavaScript 中监听页面变化？

**A**: 使用 `change` 事件：

```javascript
const carousel = document.querySelector('carousel-slider');
carousel.addEventListener('change', (event) => {
  console.log('当前页:', event.detail.index);
  console.log('触发原因:', event.detail.reason);
});
```

### Q3: `options` 属性如何使用？

**A**: `options` 是一个 JSON 字符串，可以批量设置属性：

```javascript
carousel.options = JSON.stringify({
  height: 400,
  aspectRatio: 16/9,
  viewportFraction: 0.8,
  autoPlay: true,
  autoPlayInterval: 3,  // 秒
  enlargeCenterPage: true
});
```

### Q4: 为什么我的自定义事件没有触发？

**A**: 确保：
1. 事件名称使用**小写**（如 `change`，不是 `Change`）
2. 在 Dart 层的 `_onPageChanged` 中调用了 `dispatchEvent`
3. JavaScript 中使用 `addEventListener` 而不是 `onchange` 属性

### Q5: 如何动态添加/删除轮播项？

**A**: 直接操作 DOM：

```javascript
const carousel = document.querySelector('carousel-slider');

// 添加新项
const newItem = document.createElement('img');
newItem.src = 'new-image.jpg';
carousel.appendChild(newItem);

// 删除第一项
carousel.removeChild(carousel.firstElementChild);
```

---

## 相关文件清单

### 核心代码

| 文件路径 | 行数 | 说明 |
|---------|------|------|
| `lib/webf_carousel_slider.dart` | 93 | 包入口，安装函数 |
| `lib/src/carousel_slider.dart` | 268 | Custom Element 实现 |
| `lib/src/carousel_slider_bindings_generated.dart` | 237 | 自动生成的属性绑定 |
| `lib/src/carousel_slider.d.ts` | 184 | TypeScript 类型定义 |

### 测试与示例

| 文件路径 | 行数 | 说明 |
|---------|------|------|
| `test/carousel_slider_widget_test.dart` | 454 | 单元测试（widget + options） |
| `example/lib/main.dart` | 73 | 示例应用入口 |
| `example/assets/index.html` | - | HTML 加载目标 |

### 配置文件

| 文件路径 | 说明 |
|---------|------|
| `pubspec.yaml` | 包配置与依赖 |
| `analysis_options.yaml` | Dart 分析选项 |
| `tsconfig.json` | TypeScript 编译配置（代码生成用） |

### 文档

| 文件路径 | 说明 |
|---------|------|
| `README.md` | 366 行 - 完整使用指南 |
| `CHANGELOG.md` | 版本变更记录 |

---

## 下一步建议

### 功能增强

1. **添加更多事件**
   - `slideStart` - 手势开始滑动
   - `slideEnd` - 手势结束滑动
   - `autoplayPause` - 自动播放暂停
   - `autoplayResume` - 自动播放恢复

2. **性能优化**
   - 实现虚拟滚动（支持大量项）
   - 懒加载图片（仅在可见时加载）
   - 缓存 Widget 实例

3. **API 扩展**
   - `get currentPage()` - 获取当前页索引
   - `set progress(double)` - 设置动画进度
   - `reset()` - 重置到初始状态

### 测试补充

- [ ] 添加集成测试（`integration_test/`）
- [ ] 添加 Mock 测试（Controller、事件）
- [ ] 测试与 JavaScript 的交互
- [ ] 性能测试（帧率、内存）

### 文档完善

- [ ] 添加故障排查指南
- [ ] 添加性能最佳实践
- [ ] 添加视频教程链接
- [ ] 翻译为英文版本

---

**模块维护者**: WebF Carousel Slider Team
**最后更新**: 2026-01-06
**包版本**: 0.1.0
