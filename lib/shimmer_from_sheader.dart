///
/// A package provides an easy way to add shimmer effect to Flutter application
///

library shimmer;

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///
/// An enum defines all supported directions of shimmer effect
///
/// * [ShimmerDirection.ltr] left to right direction
/// * [ShimmerDirection.rtl] right to left direction
/// * [ShimmerDirection.ttb] top to bottom direction
/// * [ShimmerDirection.btt] bottom to top direction
///
enum ShimmerDirection { ltr, rtl, ttb, btt }

///
/// A widget renders shimmer effect over [child] widget tree.
///
/// [child] defines an area that shimmer effect blends on. You can build [child]
/// from whatever [Widget] you like but there're some notices in order to get
/// exact expected effect and get better rendering performance:
///
/// * Use static [Widget] (which is an instance of [StatelessWidget]).
/// * [Widget] should be a solid color element. Every colors you set on these
/// [Widget]s will be overridden by colors of [gradient].
/// * Shimmer effect only affects to opaque areas of [child], transparent areas
/// still stays transparent.
///
/// [period] controls the speed of shimmer effect. The default value is 1500
/// milliseconds.
///
/// [direction] controls the direction of shimmer effect. The default value
/// is [ShimmerDirection.ltr].
///
/// [gradient] controls colors of shimmer effect.
///
/// [loop] the number of animation loop, set value of `0` to make animation run
/// forever.
///
/// [enabled] controls if shimmer effect is active. When set to false the animation
/// is paused
///
///
/// ## Pro tips:
///
/// * [child] should be made of basic and simple [Widget]s, such as [Container],
/// [Row] and [Column], to avoid side effect.
///
/// * use one [Shimmer] to wrap list of [Widget]s instead of a list of many [Shimmer]s
///
@immutable
class ShimmerFromShader extends StatefulWidget {
  final Widget child;
  final FragmentShader shader;
  const ShimmerFromShader({
    super.key,
    required this.child,
    required this.shader,
  });

  const ShimmerFromShader.fromShader({
    super.key,
    required this.child,
    required this.shader,
  });

  @override
  _ShimmerFromShaderState createState() => _ShimmerFromShaderState();
}

class _ShimmerFromShaderState extends State<ShimmerFromShader> {
  late Timer timer;
  double _time = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      setState(() {
        _time += 1 / 60;
      });
    });
  }

  @override
  void didUpdateWidget(ShimmerFromShader oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _ShimmerFromShader(
      shader: widget.shader,
      time: _time,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

@immutable
class _ShimmerFromShader extends SingleChildRenderObjectWidget {
  final FragmentShader shader;
  final double time;
  const _ShimmerFromShader({
    Widget? child,
    required this.shader,
    required this.time,
  }) : super(child: child);

  @override
  _ShimmerFilter createRenderObject(BuildContext context) {
    return _ShimmerFilter(shader, time);
  }

  @override
  void updateRenderObject(BuildContext context, _ShimmerFilter shimmer) {
    shimmer.time = time;
  }
}

class _ShimmerFilter extends RenderProxyBox {
  FragmentShader shader;
  double _time;
  _ShimmerFilter(this.shader, this._time);

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  set time(double newValue) {
    if (newValue == _time) {
      return;
    }
    _time = newValue;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      assert(needsCompositing);

      layer ??= ShaderMaskLayer();
      shader.setFloat(0, size.width);
      shader.setFloat(1, size.height);
      shader.setFloat(2, _time);
      layer!
        ..shader = shader
        ..maskRect = Offset.zero & size
        ..blendMode = BlendMode.srcIn;
      context.pushLayer(layer!, super.paint, offset);
    } else {
      layer = null;
    }
  }
}
