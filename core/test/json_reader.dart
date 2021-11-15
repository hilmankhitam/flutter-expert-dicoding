import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('core')) {
    dir = dir.replaceAll('core', '');
  }
  return File('$dir/core/test/$name').readAsStringSync();
}