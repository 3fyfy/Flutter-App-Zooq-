import 'package:app_zooq/Core/constants/app_contstant.dart';
import 'package:app_zooq/UI/views/Cart.dart';
import 'package:app_zooq/UI/views/Login.dart';
import 'package:app_zooq/UI/views/Mainnavbar.dart';
import 'package:app_zooq/UI/views/SearchResults.dart';
import 'package:app_zooq/UI/views/Signup.dart';
import 'package:app_zooq/UI/views/Splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Splash:
        return MaterialPageRoute(builder: (_) => Splash());
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => Login());
      case RoutePaths.SignUp:
        return MaterialPageRoute(builder: (_) => Signup());
      case RoutePaths.NavBar:
        return MaterialPageRoute(builder: (_) => Mainnavbar());
      case RoutePaths.SerachResults:
        return MaterialPageRoute(builder: (_) => SerachResults());

      case RoutePaths.Cart:
        return MaterialPageRoute(builder: (_) => Cart());
      case RoutePaths.Address:
       // var id = settings.arguments;
        //return MaterialPageRoute(builder: (_) => Address( );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}