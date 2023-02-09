class Env {
  final String? baseUrl;

  Env({this.baseUrl});
}

mixin EnvType {
  static Env get staging {
    return Env(baseUrl: 'https://jd-thirdparties.castellumdigital.org');
  }

  static Env get production {
    return Env(baseUrl: 'https://third-parties.jumpadokter.com');
  }
}
