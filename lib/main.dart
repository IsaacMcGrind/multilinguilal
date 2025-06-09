import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multilinguilal/blocs/language/language_event.dart';
import 'package:multilinguilal/blocs/language/language_state.dart';
import 'package:multilinguilal/blocs/language/languate_bloc.dart';
import 'package:multilinguilal/data/repositories/language_repository.dart';
import 'package:multilinguilal/ui/screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => LanguageRepository(),
      child: BlocProvider(
        create: (context) => LanguageBloc(
          repository: context.read<LanguageRepository>(),
        )..add(LoadLanguage()),
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Multilingual Demo',
              locale: state is LanguageLoaded 
                  ? Locale(state.languageCode)
                  : const Locale('en'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: const HomeScreen(),
            );
          },
        ),
      ),
    );
  }
}
