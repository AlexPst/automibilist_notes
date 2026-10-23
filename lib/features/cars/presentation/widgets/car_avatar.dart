import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../data/models/car.dart';

/// Круглое фото автомобиля или значок, если фото нет.
class CarAvatar extends StatelessWidget {
  const CarAvatar({super.key, required this.car, this.radius = 20});

  final Car car;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CarPhotoCircle(path: car.photoPath, radius: radius);
  }
}

class CarPhotoCircle extends StatelessWidget {
  const CarPhotoCircle({super.key, required this.path, this.radius = 20});

  final String? path;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: radius,
      backgroundColor: colors.secondaryContainer,
      foregroundImage: path == null ? null : FileImage(File(path!)),
      // Если файл фото пропал, остаётся значок.
      onForegroundImageError: path == null ? null : (_, _) {},
      child: Icon(
        Icons.directions_car,
        size: radius,
        color: colors.onSecondaryContainer,
      ),
    );
  }
}
