# Shimmer

[![pub package](https://img.shields.io/pub/v/shimmer.svg)](https://pub.dartlang.org/packages/shimmer) ![](https://github.com/hnvn/flutter_shimmer/workflows/unit%20test/badge.svg)

A package provides an easy way to add shimmer effect in Flutter project

## New Feature

Add support shader
<p>
    <img src="https://github.com/serk87/flutter_shimmer/blob/master/screenshots/shader.gif?raw=true"/>
</p>

## How to use shader

```dart
import 'package:shimmer/shimmer.dart';

```

```dart
ShimmerFromShader.fromShader(
    shader: snapshot.data!,
    child: const SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          BannerPlaceholder(),
          TitlePlaceholder(width: double.infinity),
          SizedBox(height: 16.0),
          ContentPlaceholder(
            lineType: ContentLineType.threeLines,
          ),
          SizedBox(height: 16.0),
          TitlePlaceholder(width: 200.0),
          SizedBox(height: 16.0),
          ContentPlaceholder(
            lineType: ContentLineType.twoLines,
          ),
          SizedBox(height: 16.0),
          TitlePlaceholder(width: 200.0),
          SizedBox(height: 16.0),
          ContentPlaceholder(
            lineType: ContentLineType.twoLines,
          ),
        ],
      ),
    ));
```
<p>
    <img src="https://github.com/hnvn/flutter_shimmer/blob/master/screenshots/loading_list.gif?raw=true"/>
    <img src="https://github.com/hnvn/flutter_shimmer/blob/master/screenshots/slide_to_unlock.gif?raw=true"/>
</p>

## How to use

```dart
import 'package:shimmer/shimmer.dart';

```

```dart
SizedBox(
  width: 200.0,
  height: 100.0,
  child: Shimmer.fromColors(
    baseColor: Colors.red,
    highlightColor: Colors.yellow,
    child: Text(
      'Shimmer',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 40.0,
        fontWeight:
        FontWeight.bold,
      ),
    ),
  ),
);

```
