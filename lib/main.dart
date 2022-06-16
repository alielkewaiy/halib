import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halib/layout/cubit.dart';
import 'package:halib/layout/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:halib/modules/week_details/week_details.dart';
import 'package:halib/shared/components/applocal.dart';
import 'package:halib/shared/network/local/cache_helper.dart';
import 'layout/states.dart';
import 'modules/default_price/default_price_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  print('ppppppppppppppppppppppppp');
  print(CacheHelper.getData(key: 'bovinePrice').toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MilkCubit()..createDatabase(),
      child: BlocConsumer<MilkCubit, MilkStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: CacheHelper.getData(key: 'bovinePrice') == null
                ? DefaultPrice()
                : HomeLayout(),
            localizationsDelegates: const [
              AppLocale.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar', ''), //Arabic, no country code
            ],
            localeResolutionCallback: (currentLang, supportLang) {
              if (currentLang != null) {
                for (Locale locale in supportLang) {
                  if (locale.languageCode == currentLang.languageCode) {
                    return currentLang;
                  }
                }
              }
              return supportLang.first;
            },
          );
        },
      ),
    );
  }
}
//https://www.youtube.com/watch?v=nCqC9yUOcVQ
