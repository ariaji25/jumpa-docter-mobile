class Env {
  final String? baseUrl;

  Env({this.baseUrl});
}

mixin EnvType {
  static Env get staging {
    return Env(baseUrl: '');
  }

  static Env get production {
    return Env(baseUrl: '');
  }
}
