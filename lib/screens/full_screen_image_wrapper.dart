import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_betting_predictions/widgets/full_screen_image.dart';

class ImageFullScreenWrapperWidget extends StatelessWidget {
  final CachedNetworkImage child;
  final bool dark;

  ImageFullScreenWrapperWidget({
    required this.child,
    this.dark = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            opaque: false,
            barrierColor: dark ? Colors.black : Colors.white,
            pageBuilder: (BuildContext context, _, __) {
              return FullScreenPage(
                child: child,
                dark: dark,
              );
            },
          ),
        );
      },
      child: child,
    );
  }
}
