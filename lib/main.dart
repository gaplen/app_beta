import 'package:app_beta/src/pages/client/address/create/client_address_create_page.dart';
import 'package:app_beta/src/pages/client/address/list/client_address_list_page.dart';
import 'package:app_beta/src/pages/client/adoptpets/adopt_pets.dart';
import 'package:app_beta/src/pages/client/donations/donations_page.dart';
import 'package:app_beta/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:app_beta/src/pages/client/products/favorite/client_favorite_create_page.dart';
import 'package:app_beta/src/pages/client/products/list/client_products_list_page.dart';
import 'package:app_beta/src/pages/client/update/client_update_page.dart';
import 'package:app_beta/src/pages/login/login_page.dart';
import 'package:app_beta/src/pages/pets/categories/create/pets_categories_create_page.dart';
import 'package:app_beta/src/pages/pets/donations/create/donations_products_create_page.dart';
import 'package:app_beta/src/pages/pets/orders/list/admin_list_page.dart';
import 'package:app_beta/src/pages/pets/orders/list/pets_orders_list_page.dart';
import 'package:app_beta/src/pages/pets/products/create/pets_products_create_page.dart';
import 'package:app_beta/src/pages/register/register_page.dart';
import 'package:app_beta/src/pages/roles/roles_page.dart';
import 'package:app_beta/src/provider/push_notifications_provider.dart';
import 'package:app_beta/src/utils/my_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';






PushNotificationsProvider pushNotificationsProvider = new PushNotificationsProvider();


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  pushNotificationsProvider.initPushNotifications();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();


  @override
  void initState() {
    super.initState();

    pushNotificationsProvider.onMessageListener();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App Flutter',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'register' : (BuildContext context) => RegisterPage(),
        'roles' : (BuildContext context) => RolesPage(),
        'client/products/list' : (BuildContext context) => ClientProductsListPage(),
        'client/orders/create': (BuildContext context) => ClientOrdersCreatePage(),
        'client/products/favorite': (BuildContext context) => ClientFavoriteCreatePage(),
        'client/adoptpets' : (BuildContext context ) => PetsPage(),
        'client/update' : (BuildContext context) => ClientUpdatePage(),
        
        'pets/orders/list' : (BuildContext context) => AdminOrdersListPage(),
        'pets/categories/create' : (BuildContext context) => PetsCategoriesCreatePage(),
        'pets/products/create' : (BuildContext context) => RestaurantProductsCreatePage(),
      
        'client/donations/donatepage': (BuildContext context) => ClientDontationsPage(),
        
        'pets/order/list' : (BuildContext context) => PetsOrdersListPage(),

        
        'pets/donations/create' : (BuildContext context) => DonationsProductsCreatePage(),

        
        'client/address/create' : (BuildContext context) => ClientAddressCreatePage(),
        'client/address/list' : (BuildContext context) => ClientAddressListPage(),
        

        
        
        // 'client/orders/create' : (BuildContext context) => ClientOrdersCreatePage(),
      },
      theme: ThemeData(
        // fontFamily: 'NimbusSans',
        primaryColor: MyColors.primaryColor,
        appBarTheme: AppBarTheme(elevation: 0)
      ),
    );
  }
}
