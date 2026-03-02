import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A widget that fades and slides its child into view when it enters the
/// viewport. The animation fires once and stays visible after completing.
class ScrollFadeIn extends HookWidget {
  const ScrollFadeIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
    this.offset = const Offset(0, 30),
  });

  /// The widget to animate into view.
  final Widget child;

  /// Delay before the animation starts (useful for stagger effects).
  final Duration delay;

  /// Duration of the fade + slide animation.
  final Duration duration;

  /// Animation curve.
  final Curve curve;

  /// The starting offset (pixels) from which the child slides in.
  /// Defaults to 30px upward slide. Use `Offset(-30, 0)` for left-to-right.
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: duration);
    final hasTriggered = useRef(false);
    final widgetKey = useMemoized(() => GlobalKey());

    final curved = useMemoized(
      () => CurvedAnimation(parent: controller, curve: curve),
      [controller],
    );

    void trigger() {
      if (hasTriggered.value) return;
      hasTriggered.value = true;
      if (delay == Duration.zero) {
        controller.forward();
      } else {
        Future.delayed(delay, () {
          if (controller.status == AnimationStatus.dismissed) {
            controller.forward();
          }
        });
      }
    }

    void checkVisibility() {
      if (hasTriggered.value) return;

      final renderObject = widgetKey.currentContext?.findRenderObject();
      if (renderObject == null || !renderObject.attached) return;

      final viewport = RenderAbstractViewport.maybeOf(renderObject);
      if (viewport == null) return;

      final revealOffset = viewport.getOffsetToReveal(renderObject, 0.0);
      final scrollable = Scrollable.maybeOf(widgetKey.currentContext!);
      if (scrollable == null) return;

      final scrollPosition = scrollable.position;
      final viewportHeight = scrollPosition.viewportDimension;
      final scrollOffset = scrollPosition.pixels;

      // Widget top relative to scroll viewport
      final widgetTop = revealOffset.offset - scrollOffset;

      // Trigger when the widget top is within the viewport (with a threshold)
      if (widgetTop < viewportHeight * 0.9) {
        trigger();
      }
    }

    // Store the scroll position for safe cleanup
    final scrollPositionRef = useRef<ScrollPosition?>(null);

    // Attach a scroll listener to the nearest Scrollable ancestor
    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        checkVisibility();

        final scrollable = Scrollable.maybeOf(widgetKey.currentContext!);
        scrollPositionRef.value = scrollable?.position;
        scrollPositionRef.value?.addListener(checkVisibility);
      });

      return () {
        scrollPositionRef.value?.removeListener(checkVisibility);
      };
    }, []);

    return AnimatedBuilder(
      key: widgetKey,
      animation: curved,
      builder: (context, child) => Opacity(
        opacity: curved.value,
        child: Transform.translate(
          offset: Offset(
            this.offset.dx * (1 - curved.value),
            this.offset.dy * (1 - curved.value),
          ),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
