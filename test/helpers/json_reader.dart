import 'dart:io';

String readJson(String libro) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '/');
  }
  return File('$dir/test/$libro').readAsStringSync();
}
