import 'package:flutter/material.dart';
import 'package:repeater/l10n/app_localizations.dart';
import 'package:repeater/screens/main/main_navigation.dart';
import 'package:repeater/services/user_preferences.dart';
import 'package:repeater/utils/constants/styles.dart';
import 'package:repeater/widgets/custom_list_view.dart';
import 'package:repeater/widgets/gap.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _juzController;
  late TextEditingController _maqraController;
  final _memorizationInfoFormKey = GlobalKey<FormState>();

  late bool hasKhatam;

  @override
  void initState() {
    super.initState();
    final user = UserPreferences().getUser()!;
    final juzNumber =
        (user.juzNumber == null) ? null : user.juzNumber.toString();
    final maqraNumber =
        (user.maqraNumber == null) ? null : user.maqraNumber.toString();

    _juzController = TextEditingController(text: juzNumber);
    _maqraController = TextEditingController(text: maqraNumber);
    hasKhatam = user.juzNumber == null;
  }

  @override
  void dispose() {
    _juzController.dispose();
    _maqraController.dispose();
    super.dispose();
  }

  void _updateChanges() async {
    final userPrefs = UserPreferences();

    if (hasKhatam) {
      await userPrefs.setKhatam();
    } else {
      if (!_memorizationInfoFormKey.currentState!.validate()) return;
      await userPrefs.updateUser(
        juzNumber: int.tryParse(_juzController.text),
        maqraNumber: int.tryParse(_maqraController.text),
      );
    }

    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const MainNavigation(),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editInfo),
      ),
      body: CustomListView(
        children: [
          SwitchListTile(
            title: Text(
              'Khatam',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(AppLocalizations.of(context)!.have),
            value: hasKhatam,
            onChanged: (value) => setState(() => hasKhatam = value),
          ),
          if (!hasKhatam) ...[
            const SmallGap(),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.memorizationInfo,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(AppLocalizations.of(context)!.fill),
            ),
            const SmallGap(),
            ListTile(
              title: Form(
                key: _memorizationInfoFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _juzController,
                      decoration: InputDecoration(
                        labelText: 'Juz*',
                        helperText:
                            '${AppLocalizations.of(context)!.choose} 1 - 30.',
                        border: const OutlineInputBorder(
                          borderRadius: Styles.mediumBorderRadius,
                        ),
                      ),
                      validator: (value) {
                        final juz = int.tryParse(value!);
                        if (juz == null || juz < 1 || juz > 30) {
                          return 'Invalid input!';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (_) {
                        _memorizationInfoFormKey.currentState!.validate();
                      },
                    ),
                    const MediumGap(),
                    TextFormField(
                      controller: _maqraController,
                      decoration: InputDecoration(
                        labelText: 'Maqra*',
                        helperText:
                            '${AppLocalizations.of(context)!.choose} 1 - 8.',
                        border: const OutlineInputBorder(
                          borderRadius: Styles.mediumBorderRadius,
                        ),
                      ),
                      validator: (value) {
                        final maqra = int.tryParse(value!);
                        if (maqra == null || maqra < 1 || maqra > 8) {
                          return AppLocalizations.of(context)!.invalidInput;
                        } else {
                          return null;
                        }
                      },
                      onChanged: (_) {
                        _memorizationInfoFormKey.currentState!.validate();
                      },
                    ),
                    const ScreenGap(),
                  ],
                ),
              ),
            ),
          ],
          ListTile(
            title: FilledButton.icon(
              onPressed: _updateChanges,
              icon: const Icon(Icons.check),
              label: Text(AppLocalizations.of(context)!.confirm),
            ),
          ),
        ],
      ),
    );
  }
}
