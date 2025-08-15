// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_modular/flutter_modular.dart';

final class KycRoutes {
  final String prefix_;
  final String _home;
  final String _step1;
  final String _step2;
  final String _step3;
  final String _step4;
  final String _step5a;
  final String _step5b;
  final String _step6a;
  final String _step6b;
  final String _complete;

  KycRoutes(
    this.prefix_, {
    String home = 'home',
    String step1 = 'step1',
    String step2 = 'step2',
    String step3 = 'step3',
    String step4 = 'step4',
    String step5a = 'step5a',
    String step5b = 'step5b',
    String step6a = 'step6a',
    String step6b = 'step6b',
    String complete = 'complete',
  }) : _home = home,
       _step1 = step1,
       _step2 = step2,
       _step3 = step3,
       _step4 = step4,
       _step5a = step5a,
       _step5b = step5b,
       _step6a = step6a,
       _step6b = step6b,
       _complete = complete;

  _RouteItem get home => _RouteItem(prefix_, _home);
  _RouteItem get step1 => _RouteItem(prefix_, _step1);
  _RouteItem get step2 => _RouteItem(prefix_, _step2);
  _RouteItem get step3 => _RouteItem(prefix_, _step3);
  _RouteItem get step4 => _RouteItem(prefix_, _step4);
  _RouteItem get step5a => _RouteItem(prefix_, _step5a);
  _RouteItem get step5b => _RouteItem(prefix_, _step5b);
  _RouteItem get step6a => _RouteItem(prefix_, _step6a);
  _RouteItem get step6b => _RouteItem(prefix_, _step6b);
  _RouteItem get complete => _RouteItem(prefix_, _complete);
}

final class _RouteItem<T> {
  final String _prefix;
  final String _route;

  _RouteItem(this._prefix, String route)
    : _route = route.startsWith('/') ? route.replaceFirst('/', '') : route;

  // Without prefix
  String get wp {
    //final r = _route.replaceFirst(_prefix, '');
    return _route.startsWith('/') ? _route : '/$_route';
  }

  @override
  String toString() {
    final r = '$_prefix/$_route'.replaceAll('//', '/');
    return r.startsWith('/') ? r : '/$r';
  }

  void navigate([T? arguments]) {
    return Modular.to.navigate(toString(), arguments: arguments);
  }

  Future<P?> push<P extends Object?>([
    T? arguments,
    Map<String, String>? params,
  ]) {
    var path = toString();
    if (params != null && params.isNotEmpty) {
      final query = params.keys
          .map((k) {
            final val = params[k];
            return (val?.isNotEmpty ?? false) ? 'k=$val' : '';
          })
          .join('&');

      if (query.isNotEmpty) path += '?$query';
    }
    return Modular.to.pushNamed(path, arguments: arguments);
  }
}
