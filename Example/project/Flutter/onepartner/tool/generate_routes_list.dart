import 'dart:io';

/// Generates a routes list for AutoRoute by scanning lib/views/** files.
/// It infers route class names by replacing 'Page' with 'Route' and
/// paths from file names (e.g., profile_page.dart -> /profile).
/// Output: lib/router/generated_routes.dart
void main() async {
  final viewsDir = Directory('lib/views');
  final outputFile = File('lib/router/generated_routes.dart');

  if (!viewsDir.existsSync()) {
    stderr.writeln('Directory not found: lib/views');
    exit(1);
  }

  final routeEntries = <_RouteEntry>[];

  await for (final entity in viewsDir.list(recursive: true, followLinks: false)) {
    if (entity is File && entity.path.endsWith('_page.dart')) {
      final content = await entity.readAsString();

      // Try to find the class name ending with Page
      final classMatch = RegExp(r'class\s+(\w+Page)\s+extends').firstMatch(content);
      if (classMatch == null) {
        // skip files without a standard Page class
        continue;
      }
      final pageClass = classMatch.group(1)!;
      final routeClass = pageClass.replaceFirst(RegExp(r'Page$'), 'Route');

      // Path from file name: views/foo/bar_page.dart -> /bar
      final fileName = entity.uri.pathSegments.last; // e.g., bar_page.dart
      final base = fileName.replaceAll('_page.dart', '');
      final path = '/$base';

      routeEntries.add(_RouteEntry(routeClass: routeClass, path: path));
    }
  }

  routeEntries.sort((a, b) => a.path.compareTo(b.path));

  final buffer = StringBuffer()
    ..writeln('// GENERATED: Do not edit manually.')
    ..writeln('// Run: dart run tool/generate_routes_list.dart')
    ..writeln()
    ..writeln("import 'package:onepartner/utils/imports.dart';")
    ..writeln()
    ..writeln('final List<AutoRoute> generatedRoutes = [');

  for (final r in routeEntries) {
    buffer.writeln("  AutoRoute(page: ${r.routeClass}.page, path: '${r.path}'),");
  }
  buffer
    ..writeln('];')
    ..writeln();

  outputFile.createSync(recursive: true);
  await outputFile.writeAsString(buffer.toString());
  stdout.writeln('Wrote ${routeEntries.length} routes to ${outputFile.path}');
}

class _RouteEntry {
  final String routeClass;
  final String path;
  _RouteEntry({required this.routeClass, required this.path});
}