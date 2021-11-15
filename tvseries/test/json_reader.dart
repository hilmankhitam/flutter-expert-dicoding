import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('tvseries')) {
    dir = dir.replaceAll('tvseries', '');
  }
  return File('$dir/tvseries/test/$name').readAsStringSync();
}
