[根目录](../../CLAUDE.md) > [packages](../) > **webf-react-carousel-slider**

---

# WebF React Carousel Slider - React 绑定包

## 变更记录 (Changelog)

### 2026-01-06
- 初始化模块文档
- 完成组件 API 与类型定义分析
- 生成开发指南与示例

---

## 模块职责

`webf-react-carousel-slider` 是 WebF Carousel Slider 的 React 组件绑定包，负责：

1. **React 组件封装** - 将 `<carousel-slider>` Custom Element 封装为 React 组件
2. **类型安全** - 提供完整的 TypeScript Props 与 Ref 类型定义
3. **事件处理** - 将 DOM 事件映射为 React 事件处理器
4. **属性同步** - 自动将 React props 转换为 HTML attributes（kebab-case）
5. **Ref 方法暴露** - 通过 ref 暴露 JavaScript 方法

---

## 入口与启动

### 包入口

**`src/index.ts`**

```typescript
export { CarouselSlider, CarouselSliderElement } from "./lib/src/carousel_slider";
```

### 主组件文件

**`src/lib/src/carousel_slider.tsx`** (279 行)

使用 `createWebFComponent` 工厂函数创建组件：

```typescript
export const CarouselSlider = createWebFComponent<
  CarouselSliderElement,
  CarouselSliderProps
>({
  tagName: 'carousel-slider',
  displayName: 'CarouselSlider',
  attributeProps: [...],
  attributeMap: {...},
  events: [...],
  defaultProps: {...}
});
```

---

## 对外接口

### React 组件: `<CarouselSlider />`

**导入**:

```typescript
import { CarouselSlider, CarouselSliderElement } from 'webf_carousel_slider';
```

### Props 接口

**`CarouselSliderProps`** (interface)

| Prop 名称 | 类型 | 默认值 | HTML 属性 | 说明 |
|-----------|------|--------|----------|------|
| `autoplay` | `boolean` | `false` | `autoplay` | 启用自动播放 |
| `autoplayInterval` | `number` | `3000` | `autoplay-interval` | 自动播放间隔（毫秒） |
| `enableInfiniteScroll` | `boolean` | `true` | `enable-infinite-scroll` | 启用无限循环 |
| `aspectRatio` | `number` | `0.0` | `aspect-ratio` | 宽高比（0 = 禁用） |
| `enlargeCenterPage` | `boolean` | `false` | `enlarge-center-page` | 放大中心页 |
| `viewportFraction` | `number` | `1.0` | `viewport-fraction` | 视口占比（0.0-1.0） |
| `autoPlayAnimationDuration` | `number` | `800` | `auto-play-animation-duration` | 动画时长（毫秒） |
| `autoPlayCurve` | `enum` | `'Curves.ease'` | `auto-play-curve` | 动画曲线 |
| `initialPage` | `number` | `0` | `initial-page` | 初始页索引 |
| `reverse` | `boolean` | `false` | `reverse` | 反向滚动 |
| `scrollDirection` | `'Axis.horizontal' \| 'Axis.vertical'` | `'Axis.horizontal'` | `scroll-direction` | 滚动方向 |
| `padEnds` | `boolean` | `true` | `pad-ends` | 两端填充 |
| `height` | `string` | - | `height` | 固定高度（如 "400"） |
| `currentIndex` | `number` | `0` | `current-index` | 当前页索引（可读写） |
| `options` | `string` (JSON) | - | `options` | 批量配置选项 |
| `onChange` | `(event: CustomEvent) => void` | - | - | 页面变化回调 |
| `onPageAnimationStart` | `(event: Event) => void` | - | - | 动画开始回调 |
| `onPageAnimationEnd` | `(event: Event) => void` | - | - | 动画结束回调 |
| `id` | `string` | - | `id` | HTML id 属性 |
| `style` | `React.CSSProperties` | - | - | CSS 样式 |
| `className` | `string` | - | `class` | CSS 类名 |
| `children` | `React.ReactNode` | - | - | 子元素 |

### Ref 接口

**`CarouselSliderElement`** (extends `WebFElementWithMethods`)

```typescript
interface CarouselSliderElement {
  // 方法（通过 ref.current?.method() 调用）
  next(): void;
  previous(): void;
  jumpToPage(page: number): void;
  pause(): void;
  resume(): void;
}
```

---

## 关键依赖与配置

### 依赖项 (`package.json`)

```json
{
  "peerDependencies": {
    "react": ">=16.8.0",
    "react-dom": ">=16.8.0",
    "@openwebf/react-core-ui": "^0.24.2"
  },
  "devDependencies": {
    "@openwebf/react-core-ui": "^0.24.2",
    "@types/react": "^19.2.7",
    "@types/react-dom": "^19.2.3",
    "typescript": "^5.9.3",
    "tsup": "^8.5.1"
  }
}
```

### 构建配置

**`tsconfig.json`**

```json
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "ESNext",
    "jsx": "react-jsx",
    "declaration": true,
    "outDir": "dist",
    "strict": true
  }
}
```

**`tsup.config.ts`**

```typescript
export default defineConfig({
  entry: ['src/index.ts'],
  format: ['esm', 'cjs'],    // 输出 ESM 和 CommonJS
  dts: true,                 // 生成类型定义
  sourcemap: true,
  clean: true,
  external: ['react', 'react-dom', '@openwebf/react-core-ui']
});
```

---

## 数据模型

### 组件实现结构

```
createWebFComponent (来自 @openwebf/react-core-ui)
    ↓
CarouselSlider (React 组件)
    ├── Props: CarouselSliderProps
    │   ├── 属性 Props (autoplay, aspectRatio, etc.)
    │   ├── 事件 Props (onChange, onPageAnimationStart, etc.)
    │   └── 样式 Props (style, className, id)
    │
    ├── 属性映射: attributeMap
    │   ├── currentIndex → 'current-index'
    │   ├── autoplayInterval → 'autoplay-interval'
    │   ├── enableInfiniteScroll → 'enable-infinite-scroll'
    │   └── ... (camelCase → kebab-case)
    │
    ├── 事件绑定: events[]
    │   ├── onChange → 'change' 事件
    │   ├── onPageAnimationStart → 'pageAnimationStart' 事件
    │   └── onPageAnimationEnd → 'pageAnimationEnd' 事件
    │
    └── Ref 方法: CarouselSliderElement
        ├── next()
        ├── previous()
        ├── jumpToPage(page)
        ├── pause()
        └── resume()
```

### 事件流

```
用户交互 / 自动播放
    ↓
Flutter carousel_slider_plus
    ↓
CarouselSliderElementState._onPageChanged()
    ↓
dispatchEvent('change', { index, reason })
    ↓
DOM Event: carousel-slider
    ↓
React Wrapper: createWebFComponent
    ↓
onChange Callback (React)
```

---

## 测试与质量

### 测试现状

**⚠️ 当前版本未包含测试文件**

### 推荐测试策略

```bash
# 安装测试依赖
npm install --save-dev jest @testing-library/react @testing-library/jest-dom

# 创建测试文件
# src/__tests__/carousel_slider.test.tsx
```

**测试用例建议**:

1. **组件渲染测试**
   - 默认 props 渲染
   - 自定义 props 渲染
   - 子元素渲染

2. **Props 传递测试**
   - camelCase → kebab-case 转换
   - 数字/布尔值正确传递
   - JSON options 解析

3. **事件处理测试**
   - onChange 回调触发
   - onPageAnimationStart 回调
   - onPageAnimationEnd 回调
   - event.detail 正确传递

4. **Ref 方法测试**
   - next() 方法调用
   - previous() 方法调用
   - jumpToPage() 方法调用
   - pause/resume 方法调用

5. **集成测试**
   - 与真实 WebF 环境集成
   - 与 Flutter 包通信测试

---

## 常见问题 (FAQ)

### Q1: 如何在 React 中使用 CarouselSlider？

**A**: 基础用法：

```tsx
import { CarouselSlider } from 'webf_carousel_slider';

function App() {
  return (
    <CarouselSlider
      autoplay={true}
      autoplayInterval={3000}
      aspectRatio={16 / 9}
      viewportFraction={0.8}
      enlargeCenterPage={true}
    >
      <img src="slide1.jpg" alt="Slide 1" />
      <img src="slide2.jpg" alt="Slide 2" />
      <img src="slide3.jpg" alt="Slide 3" />
    </CarouselSlider>
  );
}
```

### Q2: 如何监听页面变化事件？

**A**: 使用 `onChange` prop：

```tsx
const [currentIndex, setCurrentIndex] = useState(0);

const handleChange = (event: CustomEvent<any>) => {
  console.log('新索引:', event.detail.index);
  console.log('触发原因:', event.detail.reason);
  setCurrentIndex(event.detail.index);
};

<CarouselSlider onChange={handleChange}>
  {/* ... */}
</CarouselSlider>
```

### Q3: 如何通过 ref 控制轮播？

**A**: 使用 useRef：

```tsx
import { useRef, useEffect } from 'react';
import { CarouselSlider, CarouselSliderElement } from 'webf_carousel_slider';

function App() {
  const carouselRef = useRef<CarouselSliderElement>(null);

  const handleNext = () => {
    carouselRef.current?.next();
  };

  const handlePause = () => {
    carouselRef.current?.pause();
  };

  return (
    <div>
      <CarouselSlider ref={carouselRef} autoplay={true}>
        {/* ... */}
      </CarouselSlider>
      <button onClick={handleNext}>下一页</button>
      <button onClick={handlePause}>暂停</button>
    </div>
  );
}
```

### Q4: TypeScript 类型错误如何解决？

**A**: 确保正确导入类型：

```tsx
import {
  CarouselSlider,
  CarouselSliderElement,
  CarouselSliderProps
} from 'webf_carousel_slider';

// 使用泛型
const carouselRef = useRef<CarouselSliderElement>(null);

// Props 类型
const props: CarouselSliderProps = {
  autoplay: true,
  autoplayInterval: 3000
};
```

### Q5: 如何动态更新轮播项？

**A**: 使用 React state：

```tsx
const [images, setImages] = useState([
  'slide1.jpg',
  'slide2.jpg',
  'slide3.jpg'
]);

const addImage = () => {
  setImages([...images, `slide${images.length + 1}.jpg`]);
};

<CarouselSlider autoplay={true}>
  {images.map((src, index) => (
    <img key={index} src={src} alt={`Slide ${index + 1}`} />
  ))}
</CarouselSlider>
```

### Q6: build 后找不到模块？

**A**: 确保正确配置构建：

```bash
# 构建前
npm run build

# 检查输出
ls -la dist/
# 应该看到: index.js, index.mjs, index.d.ts
```

在 `package.json` 中：

```json
{
  "main": "dist/index.js",      // CommonJS
  "module": "dist/index.mjs",   // ESM
  "types": "dist/index.d.ts",   // TypeScript
  "files": ["dist"]
}
```

---

## 相关文件清单

### 核心代码

| 文件路径 | 行数 | 说明 |
|---------|------|------|
| `src/index.ts` | 7 | 包入口，导出组件与类型 |
| `src/lib/src/carousel_slider.tsx` | 279 | React 组件实现 |
| `src/types.ts` | 2 | 聚合类型声明（自动生成） |

### 配置文件

| 文件路径 | 说明 |
|---------|------|
| `package.json` | 包配置、依赖、脚本 |
| `tsconfig.json` | TypeScript 编译配置 |
| `tsup.config.ts` | tsup 构建配置 |
| `.gitignore` | 忽略 node_modules、dist、lib |

### 构建输出

| 目录/文件 | 说明 |
|-----------|------|
| `dist/index.js` | CommonJS 输出 |
| `dist/index.mjs` | ES Module 输出 |
| `dist/index.d.ts` | TypeScript 类型定义 |
| `dist/*.map` | Source Maps |

---

## 开发指南

### 本地开发

```bash
# 1. 安装依赖
npm install

# 2. 开发模式（监听文件变化）
npm run dev

# 3. 构建生产版本
npm run build

# 4. 链接到本地项目（测试）
npm link
cd /path/to/test-project
npm link webf_carousel_slider
```

### 发布到 npm

```bash
# 1. 更新版本号
npm version patch  # 或 minor / major

# 2. 构建
npm run build

# 3. 检查包内容
npm pack --dry-run

# 4. 发布
npm publish
```

### 与 Flutter 包联动

当 Flutter 包 API 变化时：

1. **更新 Dart 代码**
   ```bash
   cd ../../native_uis/webf_carousel_slider
   # 修改 lib/src/carousel_slider.dart
   ```

2. **重新生成 TypeScript 定义**
   ```bash
   # 确保 .d.ts 文件同步更新
   # lib/src/carousel_slider.d.ts
   ```

3. **重新生成 React 绑定**
   ```bash
   webf codegen webf-carousel-slider-react \
     --flutter-package-src=../../native_uis/webf_carousel_slider \
     --framework=react
   ```

4. **更新 React 包**
   ```bash
   cd ../../packages/webf-react-carousel-slider
   # 复制生成的文件到 src/
   npm run build
   ```

---

## 下一步建议

### 功能增强

1. **添加 hooks**
   - `useCarouselSlider(ref)` - 封装常用操作
   - `useCarouselState()` - 管理轮播状态
   - `useCarouselAutoPlay()` - 自动播放控制

2. **提供预配置组件**
   - `<ImageCarousel />` - 专用图片轮播
   - `<CardCarousel />` - 卡片轮播
   - `<ThumbnailCarousel />` - 缩略图轮播

3. **性能优化**
   - React.memo 优化渲染
   - useMemo 缓存配置对象
   - useCallback 稳定回调函数

### 测试补充

- [ ] 添加 Jest + React Testing Library 测试
- [ ] 添加 Storybook 可视化测试
- [ ] 添加 E2E 测试（与真实 WebF 集成）
- [ ] 添加性能测试（渲染时间、内存占用）

### 文档完善

- [ ] 添加 Storybook 故事
- [ ] 添加 API 文档（JSDoc 完善）
- [ ] 添加迁移指南（从其他轮播库）
- [ ] 添加视频教程链接

### 工具链改进

- [ ] 添加 ESLint 配置
- [ ] 添加 Prettier 配置
- [ ] 添加 Husky pre-commit hooks
- [ ] 添加 CI/CD 配置（GitHub Actions）

---

**模块维护者**: WebF Carousel Slider Team
**最后更新**: 2026-01-06
**包版本**: 0.1.0
