import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multilinguilal/l10n/blocs/language/language_event.dart';
import 'package:multilinguilal/l10n/blocs/language/language_state.dart';
import 'package:multilinguilal/l10n/blocs/language/languate_bloc.dart';
import 'package:multilinguilal/l10n/data/models/language.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(s.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(s.greeting, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: context.select((LanguageBloc bloc) =>
                  bloc.state is LanguageLoaded
                      ? (bloc.state as LanguageLoaded).languageCode
                      : 'en'),
              items: supportedLanguages.map((Language language) {
                return DropdownMenuItem<String>(
                  value: language.code,
                  child: Text(language.name),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  context.read<LanguageBloc>().add(ChangeLanguage(newValue));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
