import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_localization/flutter_localization.dart';
// import 'package:mentorme/components/language/lang_strings.dart';
// import 'package:mentorme/screens/welcome_screen.dart';
import '/components/language/lang_strings.dart';
import '/components/provider.dart';
import '/screens/welcome_screen.dart';

class LangMainPage extends StatefulWidget {
  const LangMainPage({super.key});

  @override
  State<LangMainPage> createState() => _LangMainPageState();
}

class _LangMainPageState extends State<LangMainPage> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  void initState() {
    _localization.translate(LangPropHandler.crnt_lang_code);
    _localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('tm', AppLocale.TM),
        const MapLocale('hi', AppLocale.HI),
        const MapLocale('ml', AppLocale.ML),

      
      ],

      initLanguageCode: 'en',
    );
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: _localization.supportedLocales,
      localizationsDelegates: _localization.localizationsDelegates,
      home: const WelcomeScreen(),
    );
  }
}
