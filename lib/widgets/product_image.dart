import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageAsset;
  final double size;

  const ProductImage({Key? key, required this.imageAsset, this.size = 80})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imageAsset,
        height: size,
        width: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: size,
            width: size,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
          );
        },
      ),
    );
  }
}
