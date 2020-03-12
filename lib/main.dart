import 'package:app_zooq/Core/constants/app_contstant.dart';
import 'package:app_zooq/Core/constants/router.dart';
import 'package:app_zooq/Core/services/addressProvider.dart';
import 'package:app_zooq/Core/services/mainProvider.dart';
import 'package:app_zooq/Core/services/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   MultiProvider(
        providers: [
                  ChangeNotifierProvider<UserProvider>.value(value: UserProvider(),),
          ChangeNotifierProvider<AddressProvider>.value(value: AddressProvider(),),
          ChangeNotifierProvider<MainProvider>.value(value: MainProvider(),),


        ],

    child: MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily:'cairo' ,
          backgroundColor: Colors.white,
          accentColor:  Color(0xffC01232),
          appBarTheme: AppBarTheme(color: Colors.white,actionsIconTheme: IconThemeData(color:Color(0xffC01232),))
      ),
      initialRoute: RoutePaths.Splash,
      onGenerateRoute: Router.generateRoute,
    )
    );
  }
}

