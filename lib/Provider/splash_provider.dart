import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashProvider = FutureProvider<bool>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return false;
});