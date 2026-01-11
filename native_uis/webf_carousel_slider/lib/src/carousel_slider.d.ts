/**
 * WebF Carousel Slider Component
 *
 * 基于 carousel_slider_plus 7.1.1
 *
 * 本类型定义包含所有 carousel_slider_plus 提供的 API
 *
 * 标记为 @experimental 的 API 表示当前 Dart 层尚未实现，
 * 但类型定义已就绪，将在未来版本中添加实现。
 *
 * 未标记 @experimental 的 API 均已在当前版本中实现并可用。
 */

// ========== 枚举类型定义 ==========

/**
 * 页面变化原因枚举
 *
 * - timed: 自动播放触发
 * - manual: 用户手动滑动触发
 * - controller: 控制器方法触发
 */
export enum CarouselPageChangedReason {
  timed = 'timed',
  manual = 'manual',
  controller = 'controller',
}

/**
 * 中心页放大策略枚举
 *
 * - scale: 缩放策略（默认）
 * - height: 高度策略
 * - zoom: 缩放策略（带对齐）
 */
export enum CenterPageEnlargeStrategy {
  scale = 'scale',
  height = 'height',
  zoom = 'zoom',
}

/**
 * 滚动方向枚举
 *
 * 注意：Dart 中的枚举值是 Axis.horizontal 和 Axis.vertical
 * 在 WebF 绑定中映射为字符串 'Axis.horizontal' 和 'Axis.vertical'
 */
export enum Axis {
  horizontal = 'Axis.horizontal',
  vertical = 'Axis.vertical',
}

/**
 * 自动播放动画曲线枚举
 *
 * WebF 绑定中使用的字符串形式
 *
 * 常用曲线说明：
 * - Curves.ease: 缓入缓出
 * - Curves.easeIn: 缓入
 * - Curves.easeOut: 缓出
 * - Curves.easeInOut: 缓入缓出（更平滑）
 * - Curves.fastOutSlowIn: 快速开始，缓慢结束（默认）
 * - Curves.linear: 线性匀速
 */
export enum Curve {
  ease = 'Curves.ease',
  easeIn = 'Curves.easeIn',
  easeOut = 'Curves.easeOut',
  easeInOut = 'Curves.easeInOut',
  fastOutSlowIn = 'Curves.fastOutSlowIn',
  linear = 'Curves.linear',
}

// ========== 属性接口 ==========

/**
 * Properties for <carousel-slider> Custom Element
 *
 * 所有属性都支持 HTML 属性方式设置（kebab-case）
 * 和 JavaScript 属性方式设置（camelCase）
 *
 * @example
 * // HTML 方式
 * <carousel-slider autoplay="true" autoplay-interval="4"></carousel-slider>
 *
 * @example
 * // JavaScript 方式
 * carousel.autoplay = true;
 * carousel.autoplayInterval = 4;
 */
interface CarouselSliderProperties {
  // ========== 当前页面 ==========

  /**
   * 当前页面索引（0-based）
   *
   * - 设置此值会触发页面跳转
   * - 页面变化时会自动更新此值
   * - 读取此值可获取当前页索引
   *
   * @default 0
   * @attribute current-index
   */
  currentIndex?: number;

  // ========== 批量配置 ==========

  /**
   * JSON 格式的批量配置
   *
   * 一次设置多个属性，使用 JSON 格式
   *
   * @example
   * carousel.options = JSON.stringify({
   *   autoplay: true,
   *   autoplayInterval: 4.0,
   *   viewportFraction: 0.8,
   *   enlargeCenterPage: true,
   *   enlargeFactor: 0.3
   * });
   *
   * @attribute options
   */
  options?: string;

  // ========== 布局属性 ==========

  /**
   * 轮播高度（字符串形式）
   *
   * - 如果设置了 height，将覆盖 aspectRatio
   * - 支持 "400", "400px", "400.0" 等格式
   * - 单位为逻辑像素
   *
   * @default null
   * @attribute height
   */
  height?: string;

  /**
   * 宽高比
   *
   * - 如果未设置 height，则根据此比例计算高度
   * - 常见比例: 16/9, 4/3, 1/1
   *
   * @default 16/9
   * @attribute aspect-ratio
   */
  aspectRatio?: number;

  /**
   * 视口占比
   *
   * - 每个页面占据视口的宽度比例
   * - 范围: 0.0 - 1.0
   * - 小于 1.0 时可看到相邻页面的一部分
   *
   * @default 0.8
   * @attribute viewport-fraction
   */
  viewportFraction?: number;

  /**
   * 初始页面索引
   *
   * - 组件首次加载时显示的页面
   * - 仅在初始化时生效
   *
   * @default 0
   * @attribute initial-page
   */
  initialPage?: number;

  /**
   * 两端添加填充
   *
   * - viewportFraction < 1.0 时生效
   * - 为首尾页面添加填充，使其可以居中显示
   *
   * @default true
   * @attribute pad-ends
   */
  padEnds: boolean;

  /**
   * 禁用 Center widget
   *
   * - 为每个页面禁用 Center widget
   * - 可能会影响布局对齐
   *
   * @default false
   * @experimental 暂未实现，将在未来版本中添加
   * @attribute disable-center
   */
  disableCenter?: boolean;

  // ========== 滚动属性 ==========

  /**
   * 启用无限循环滚动
   *
   * - true: 可以无限向前/向后滚动
   * - false: 到达首尾时停止
   *
   * @default true
   * @attribute enable-infinite-scroll
   */
  enableInfiniteScroll: boolean;

  /**
   * 循环到最近的页面
   *
   * - enableInfiniteScroll = true 时生效
   * - 跳转时选择最近的循环路径
   * - 减少跳转动画的距离
   *
   * @default true
   * @experimental 暂未实现，将在未来版本中添加
   * @attribute animate-to-closest
   */
  animateToClosest?: boolean;

  /**
   * 反向滚动
   *
   * - 翻转轮播的滚动方向
   * - 水平模式下从右到左
   * - 垂直模式下从下到上
   *
   * @default false
   * @attribute reverse
   */
  reverse: boolean;

  /**
   * 滚动方向
   *
   * - Axis.horizontal: 水平滚动（默认）
   * - Axis.vertical: 垂直滚动
   *
   * @default 'Axis.horizontal'
   * @attribute scroll-direction
   */
  scrollDirection?: Axis;

  /**
   * 页面吸附效果
   *
   * - true: 滚动停止时自动吸附到页面边界
   * - false: 可以停留在任意位置
   *
   * @default true
   * @attribute page-snapping
   */
  pageSnapping: boolean;

  /**
   * 滚动物理效果
   *
   * - 高级配置，控制滚动行为
   * - 通常不需要手动设置
   *
   * @experimental 暂未实现，未来版本可能添加
   * @attribute scroll-physics
   */
  scrollPhysics?: string;

  // ========== 自动播放属性 ==========

  /**
   * 启用自动播放
   *
   * - 开启后会按间隔自动切换页面
   * - 可通过 pause() 方法或用户交互暂停
   * - 可通过 resume() 方法恢复
   *
   * @default false
   * @attribute autoplay
   */
  autoplay: boolean;

  /**
   * 自动播放间隔（秒）
   *
   * - 两次自动播放之间的时间间隔
   * - 单位为秒（不是毫秒）
   * - 建议最小值: 0.5 秒
   *
   * @default 4.0
   * @attribute autoplay-interval
   */
  autoplayInterval?: number;

  /**
   * 自动播放动画持续时间（毫秒）
   *
   * - 页面切换动画的持续时间
   * - 单位为毫秒
   * - 建议范围: 100 - 5000
   *
   * @default 800
   * @attribute auto-play-animation-duration
   */
  autoPlayAnimationDuration?: number;

  /**
   * 自动播放动画曲线
   *
   * - 控制动画的时间-速度曲线
   * - 常用值: Curves.fastOutSlowIn（默认）、Curves.ease
   *
   * @default 'Curves.fastOutSlowIn'
   * @attribute auto-play-curve
   */
  autoPlayCurve?: Curve;

  /**
   * 触摸时暂停自动播放
   *
   * - 用户触摸轮播时自动暂停
   * - 松手后自动恢复播放
   * - 提供更好的交互体验
   *
   * @default true
   * @attribute pause-auto-play-on-touch
   */
  pauseAutoPlayOnTouch: boolean;

  /**
   * 手动导航时暂停自动播放
   *
   * - 调用 next()/previous()/jumpToPage() 时暂停
   * - 动画完成后自动恢复播放
   * - 防止自动播放干扰用户操作
   *
   * @default true
   * @attribute pause-auto-play-on-manual-navigate
   */
  pauseAutoPlayOnManualNavigate: boolean;

  /**
   * 非无限循环时到达末尾暂停自动播放
   *
   * - enableInfiniteScroll = false 时生效
   * - 到达最后一页时是否暂停自动播放
   * - false 则会循环到第一页
   *
   * @default false
   * @experimental 暂未实现，将在未来版本中添加
   * @attribute pause-auto-play-in-finite-scroll
   */
  pauseAutoPlayInFiniteScroll?: boolean;

  // ========== 中心页放大属性 ==========

  /**
   * 放大中心页
   *
   * - 当前页面显示得比相邻页面大
   * - 创造出一种深度感
   * - 需要 enlargeFactor 配合使用
   *
   * @default false
   * @attribute enlarge-center-page
   */
  enlargeCenterPage: boolean;

  /**
   * 中心页放大策略
   *
   * - scale: 通过缩放放大（默认）
   * - height: 通过高度放大
   * - zoom: 通过缩放放大（与 scale 类似但有细微差别）
   *
   * @default 'scale'
   * @experimental 暂未实现，将在未来版本中添加
   * @attribute enlarge-strategy
   */
  enlargeStrategy?: CenterPageEnlargeStrategy;

  /**
   * 中心页放大因子
   *
   * - 相邻页面相对于中心页的缩小比例
   * - 范围: 0.0 - 1.0
   * - 值越大，相邻页缩小越多
   *
   * @default 0.3
   * @attribute enlarge-factor
   */
  enlargeFactor?: number;
}

// ========== 方法接口 ==========

/**
 * Methods for <carousel-slider> Custom Element
 *
 * 所有方法都通过 JavaScript 调用
 *
 * @example
 * const carousel = document.querySelector('carousel-slider');
 * carousel.next();
 * carousel.jumpToPage(2);
 */
interface CarouselSliderMethods {
  /**
   * 下一页（带动画）
   *
   * 切换到下一页，使用动画
   *
   * @param duration - 动画持续时间（毫秒），默认 300ms
   * @param curve - 动画曲线，默认 'Curves.linear'
   *
   * @throws 如果已到达最后一页且 enableInfiniteScroll = false
   *
   * @example
   * carousel.next();
   *
   * @example
   * // 自定义动画
   * carousel.next(500, 'Curves.easeInOut');
   */
  next(duration?: number, curve?: Curve): void;

  /**
   * 上一页（带动画）
   *
   * 切换到上一页，使用动画
   *
   * @param duration - 动画持续时间（毫秒），默认 300ms
   * @param curve - 动画曲线，默认 'Curves.linear'
   *
   * @throws 如果已在第一页且 enableInfiniteScroll = false
   *
   * @example
   * carousel.previous();
   */
  previous(duration?: number, curve?: Curve): void;

  /**
   * 跳转到指定页（无动画）
   *
   * 立即跳转到目标页面，不显示动画
   *
   * @param page - 目标页面索引（0-based）
   * @throws 如果 page < 0 或 page >= 页面总数
   *
   * @example
   * carousel.jumpToPage(0);  // 跳转到第一页
   * carousel.jumpToPage(2);  // 跳转到第三页
   */
  jumpToPage(page: number): void;

  /**
   * 动画到指定页（带动画）
   *
   * 带动画切换到目标页面
   *
   * @param page - 目标页面索引（0-based）
   * @param duration - 动画持续时间（毫秒），默认 300ms
   * @param curve - 动画曲线，默认 'Curves.linear'
   * @throws 如果 page < 0 或 page >= 页面总数
   *
   * @example
   * // 使用默认动画
   * carousel.animateToPage(2);
   *
   * @example
   * // 自定义动画
   * carousel.animateToPage(2, 500, 'Curves.easeInOut');
   *
   * @experimental 暂未实现，将在未来版本中添加
   */
  animateToPage(page: number, duration?: number, curve?: Curve): void;

  /**
   * 暂停自动播放
   *
   * 立即暂停自动播放
   * - 触发 autoplaypause 事件
   * - 不会修改 autoplay 属性
   *
   * @example
   * carousel.pause();
   *
   * @see resume
   * @see stopAutoPlay
   */
  pause(): void;

  /**
   * 恢复自动播放
   *
   * 恢复之前暂停的自动播放
   * - 触发 autoplayresume 事件
   * - 如果 autoplay = false，此方法无效
   *
   * @example
   * carousel.resume();
   *
   * @see pause
   * @see startAutoPlay
   */
  resume(): void;

  /**
   * 启动自动播放
   *
   * 强制启动自动播放计时器
   * - 比 resume() 更明确
   * - 即使 autoplay = false 也能启动
   *
   * @example
   * carousel.startAutoPlay();
   *
   * @see resume
   * @see stopAutoPlay
   *
   * @experimental 暂未实现，将在未来版本中添加
   */
  startAutoPlay(): void;

  /**
   * 停止自动播放
   *
   * 强制停止自动播放计时器
   * - 比 pause() 更明确
   * - 会暂停直到调用 startAutoPlay() 或 resume()
   *
   * @example
   * carousel.stopAutoPlay();
   *
   * @see pause
   * @see startAutoPlay
   *
   * @experimental 暂未实现，将在未来版本中添加
   */
  stopAutoPlay(): void;
}

// ========== 事件接口 ==========

/**
 * Events for <carousel-slider> Custom Element
 *
 * 所有事件都通过 addEventListener 监听
 *
 * @example
 * carousel.addEventListener('change', (event) => {
 *   console.log('Page:', event.detail.index);
 * });
 */
interface CarouselSliderEvents {
  /**
   * 页面变化事件
   *
   * 当轮播切换到新页面时触发
   *
   * @event change
   * @property {number} detail.index - 新页面索引（0-based）
   * @property {CarouselPageChangedReason} detail.reason - 触发原因
   *
   * @example
   * carousel.addEventListener('change', (event) => {
   *   console.log('New page:', event.detail.index);
   *   console.log('Reason:', event.detail.reason);
   *   // Reason: 'timed' | 'manual' | 'controller'
   * });
   */
  change: CustomEvent<{
    index: number;
    reason: CarouselPageChangedReason;
  }>;

  /**
   * 滑动开始事件
   *
   * 用户开始拖动轮播时触发
   *
   * @event slidestart
   *
   * @example
   * carousel.addEventListener('slidestart', () => {
   *   console.log('User started sliding');
   * });
   */
  slidestart: Event;

  /**
   * 滑动结束事件
   *
   * 用户停止拖动轮播时触发
   *
   * @event slideend
   *
   * @example
   * carousel.addEventListener('slideend', () => {
   *   console.log('User stopped sliding');
   * });
   */
  slideend: Event;

  /**
   * 页面动画开始事件
   *
   * 页面切换动画开始时触发
   *
   * @event pageanimationstart
   * @property {number} detail.from - 起始页面索引
   * @property {number} detail.to - 目标页面索引
   *
   * @example
   * carousel.addEventListener('pageanimationstart', (event) => {
   *   console.log(`Animating from ${event.detail.from} to ${event.detail.to}`);
   * });
   */
  pageanimationstart: CustomEvent<{
    from: number;
    to: number;
  }>;

  /**
   * 页面动画结束事件
   *
   * 页面切换动画完成时触发
   *
   * @event pageanimationend
   * @property {number} detail.index - 当前页面索引
   *
   * @example
   * carousel.addEventListener('pageanimationend', (event) => {
   *   console.log(`Animation ended at page ${event.detail.index}`);
   * });
   */
  pageanimationend: CustomEvent<{
    index: number;
  }>;

  /**
   * 自动播放暂停事件
   *
   * 自动播放被暂停时触发
   *
   * @event autoplaypause
   *
   * @example
   * carousel.addEventListener('autoplaypause', () => {
   *   console.log('Autoplay paused');
   * });
   */
  autoplaypause: Event;

  /**
   * 自动播放恢复事件
   *
   * 自动播放恢复时触发
   *
   * @event autoplayresume
   *
   * @example
   * carousel.addEventListener('autoplayresume', () => {
   *   console.log('Autoplay resumed');
   * });
   */
  autoplayresume: Event;

  /**
   * 滚动事件
   *
   * 轮播滚动时持续触发
   *
   * @event scrolled
   * @property {number | null} detail - 当前滚动位置（像素），null 表示无法确定
   *
   * @example
   * carousel.addEventListener('scrolled', (event) => {
   *   console.log('Scrolled to:', event.detail);
   * });
   *
   * @experimental 暂未实现，将在未来版本中添加
   */
  scrolled: CustomEvent<number | null>;

  /**
   * 单项点击事件
   *
   * 点击轮播图片项时触发
   *
   * @event itemclick
   * @property {string | number} detail.id - 图片项 ID
   *
   * @example
   * carousel.addEventListener('itemclick', (event) => {
   *   console.log('Clicked item id:', event.detail.id);
   * });
   */
  itemclick: CustomEvent<{
    id: string | number;
  }>;
}

// ========== 全局声明 ==========

/**
 * 声明 Custom Element 标签
 *
 * 确保 TypeScript 识别 <carousel-slider> 标签
 *
 * @example
 * const carousel = document.querySelector('carousel-slider');
 * carousel.autoplay = true;
 */
declare global {
  /**
   * CarouselSlider Custom Element
   *
   * 扩展 HTMLElement 以包含自定义属性和方法
   */
  interface HTMLElementTagNameMap {
    'carousel-slider': HTMLElement &
      CarouselSliderProperties &
      CarouselSliderMethods;
  }

  /**
   * HTMLElement 扩展
   *
   * 为所有 carousel-slider 元素添加类型提示
   */
  interface HTMLElement extends
    CarouselSliderProperties,
    CarouselSliderMethods {}
}

export {};
