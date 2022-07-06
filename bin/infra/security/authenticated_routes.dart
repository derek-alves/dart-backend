class AuthenticatedRoutes {
  final List<String> routes = [];
  AuthenticatedRoutes add(String route) {
    routes.add(route);
    return this;
  }

  bool authenticated(String route) {
    return routes.contains(route);
  }
}
