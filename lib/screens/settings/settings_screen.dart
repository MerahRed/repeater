import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repeater/screens/form/intro_screen.dart';
import 'package:repeater/screens/main/main_navigation.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/bool_alert_dialog.dart';
import 'package:repeater/widgets/custom_list_view.dart';
import 'package:repeater/widgets/gap.dart';
import 'package:repeater/widgets/section_title.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:repeater/l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String currentLocale;
  late String currentTheme;
  late Color currentColor;

  final List<Color> colorSchemeOptions = [
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.deepOrange,
    Colors.pink,
  ];
  final userGuideUrl =
      Uri.parse('https://adaniel52.github.io/repeater/links/guide/');
  final sendFeedbackUrl =
      Uri.parse('https://adaniel52.github.io/repeater/links/feedback/');

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() {
    final user =
        Provider.of<UserPreferences>(context, listen: false).getUser()!;
    currentTheme = user.themeMode;
    currentColor = Color(user.colorScheme);
  }

  void _resetSchedules() async {
    final result = await showBoolAlertDialog(
      context,
      title: AppLocalizations.of(context)!.resetSchedules,
      content: AppLocalizations.of(context)!.resetScheduleAbout,
      falseText: Text(AppLocalizations.of(context)!.cancel),
      trueText: Text(
        AppLocalizations.of(context)!.reset,
        style: const TextStyle(color: Colors.red),
      ),
    );

    if (result == false) return;

    await UserPreferences().logIn(shouldReschedule: true);
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const MainNavigation(),
      ),
      (_) => false,
    );
  }

  void _resetData() async {
    final result = await showBoolAlertDialog(
      context,
      title: AppLocalizations.of(context)!.resetData,
      content: AppLocalizations.of(context)!.resetDataAbout,
      falseText: Text(AppLocalizations.of(context)!.cancel),
      trueText: Text(
        AppLocalizations.of(context)!.reset,
        style: const TextStyle(color: Colors.red),
      ),
    );

    if (!result) return;

    await UserPreferences().resetUser();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const IntroScreen(),
      ),
      (_) => false,
    );
  }

  Future<void> _launchUrl(Uri url) async {
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: CustomListView(
        children: [
          SectionTitle(AppLocalizations.of(context)!.appearance),
          _setThemeTile(userPrefs),
          _setColorSchemeTile(userPrefs),
          _setLocaleTile(userPrefs),
          const LargeGap(),
          SectionTitle(AppLocalizations.of(context)!.danger),
          _rescheduleTile(),
          _resetDataTile(),
          const LargeGap(),
          SectionTitle(AppLocalizations.of(context)!.extra),
          _userGuideTile(),
          _sendFeedbackTile(),
          _aboutAppTile(),
        ],
      ),
    );
  }

  Widget _setThemeTile(UserPreferences userPrefs) => PopupMenuButton(
        tooltip: '',
        child: ListTile(
          leading: const Icon(Icons.brightness_6),
          title: Text(AppLocalizations.of(context)!.theme),
          trailing: Text(currentTheme),
        ),
        itemBuilder: (_) {
          return ['System', 'Light', 'Dark'].map((e) {
            return PopupMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList();
        },
        onSelected: (value) async {
          setState(() => currentTheme = value);
          await userPrefs.updateUser(themeMode: value);
        },
      );

  Widget _setColorSchemeTile(UserPreferences userPrefs) => PopupMenuButton(
        tooltip: '',
        child: ListTile(
          leading: const Icon(Icons.color_lens),
          title: Text(AppLocalizations.of(context)!.color),
          trailing: CircleAvatar(backgroundColor: currentColor),
        ),
        itemBuilder: (_) {
          return colorSchemeOptions.map(
            (color) {
              return PopupMenuItem(
                value: color,
                child: CircleAvatar(backgroundColor: color),
              );
            },
          ).toList();
        },
        onSelected: (value) async {
          setState(() => currentColor = value);
          await userPrefs.updateUser(colorScheme: currentColor.toARGB32());
        },
      );

  Widget _setLocaleTile(UserPreferences userPrefs) => PopupMenuButton(
        tooltip: '',
        child: ListTile(
          leading: const Icon(Icons.language),
          title: Text(AppLocalizations.of(context)!.language),
          trailing: Text(
            (userPrefs.getUser()?.locale == 'en')
                ? 'English'
                : (userPrefs.getUser()?.locale == 'ms')
                    ? 'Malay (Latin)'
                    : (userPrefs.getUser()?.locale == 'ms_Arab')
                        ? 'Malay (Jawi)'
                        : (userPrefs.getUser()?.locale == 'ar')
                            ? 'Arabic'
                            : 'Unknown',
          ),
        ),
        itemBuilder: (_) {
          final locales = {
            'en': 'English',
            'ms': 'Malay (Latin)',
            'ms_Arab': 'Malay (Jawi)',
            'ar': 'Arabic',
          };
          return locales.entries.map((entry) {
            return PopupMenuItem(
              value: entry.key,
              child: Text(entry.value),
            );
          }).toList();
        },
        onSelected: (String lan) async {
          setState(() => currentLocale = lan);
          await userPrefs.updateUser(locale: lan);
        },
      );

  Widget _rescheduleTile() => ListTile(
        leading: const Icon(Icons.calendar_month),
        title: Text(AppLocalizations.of(context)!.resetSchedules),
        onTap: _resetSchedules,
      );

  Widget _resetDataTile() => ListTile(
        leading: const Icon(Icons.delete),
        title: Text(AppLocalizations.of(context)!.resetData),
        onTap: _resetData,
      );

  Widget _userGuideTile() => ListTile(
        onTap: () async => await _launchUrl(userGuideUrl),
        leading: const Icon(Icons.library_books),
        title: Text(AppLocalizations.of(context)!.guide),
      );

  Widget _sendFeedbackTile() => ListTile(
        onTap: () async => await _launchUrl(sendFeedbackUrl),
        leading: const Icon(Icons.mail),
        title: Text(AppLocalizations.of(context)!.sendFeedback),
      );

  Widget _aboutAppTile() => AboutListTile(
        icon: const Icon(Icons.info),
        applicationIcon: const ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image(
            image: AssetImage('assets/icon/icon.png'),
            width: 50,
          ),
        ),
        applicationVersion: 'v0.2.1',
        aboutBoxChildren: [
          Text(AppLocalizations.of(context)!.about),
        ],
      );
}
