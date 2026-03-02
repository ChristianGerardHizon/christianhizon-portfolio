import 'package:flutter/material.dart';
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

    return _VisibilityObserver(
      onVisible: trigger,
      child: AnimatedBuilder(
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
      ),
    );
  }
}

/// Observes when the widget becomes visible in the viewport using
/// [LayoutBuilder] + post-frame callbacks and scroll listeners.
class _VisibilityObserver extends StatefulWidget {
  const _VisibilityObserver({
    required this.onVisible,
    required this.child,
  });

  final VoidCallback onVisible;
  final Widget child;

  @override
  State<_VisibilityObserver> createState() => _VisibilityObserverState();
}

class _VisibilityObserverState extends State<_VisibilityObserver> {
  ScrollPosition? _scrollPosition;
  bool _triggered = false;

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Re-attach scroll listener if scrollable ancestor changes
    _detach();
    _scrollPosition = Scrollable.maybeOf(context)?.position;
    _scrollPosition?.addListener(_check);

    // Check visibility after the frame is laid out
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _check();
    });
  }

  @override
  void dispose() {
    _detach();
    super.dispose();
  }

  void _detach() {
    _scrollPosition?.removeListener(_check);
  }

  void _check() {
    if (_triggered || !mounted) return;

    final renderObject = context.findRenderObject();
    if (renderObject == null || !renderObject.attached) return;

    final renderBox = renderObject as RenderBox;
    // Get the widget's position relative to the viewport
    final offset = renderBox.localToGlobal(Offset.zero);
    final viewportHeight = MediaQuery.sizeOf(context).height;

    // Trigger when the top of the widget is within 90% of the viewport height
    if (offset.dy < viewportHeight * 0.9) {
      _triggered = true;
      widget.onVisible();
    }
  }
}
