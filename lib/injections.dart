import 'package:get_it/get_it.dart';
import 'package:mazloum_app/models/payment_model.dart';
import 'package:mazloum_app/provider/cart_provider.dart';
import 'package:mazloum_app/provider/login_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Injections {
  final getIt = GetIt.instance;

  void setupDependencyInjection()  {
    getIt.registerSingletonAsync<SharedPreferences>(() async {
      return await SharedPreferences.getInstance();
    });
    getIt.isReady<SharedPreferences>().then((_) =>  getIt.registerSingleton<CartProvider>(CartProvider(),signalsReady: true));
    getIt.registerSingleton<PaymentModel>(PaymentModel());
    getIt.registerSingleton<LoginProvider>(LoginProvider());

  }

}