import 'package:flutter/material.dart';
import 'package:ego/app/get_it/get_it.dart';
import 'package:ego/core/common/services/dialog/dialog_service.dart';
import 'package:ego/core/localization/lang_repo.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../localization/loc_keys.dart';


class LanguageChangeDialog extends StatefulWidget {
  final String? currentLanguageCode;
  final Function(String) onLanguageSelected;

  const LanguageChangeDialog({
    super.key,
    required this.currentLanguageCode,
    required this.onLanguageSelected,
  });

  @override
  State<LanguageChangeDialog> createState() => _LanguageChangeDialogState();
}

class _LanguageChangeDialogState extends State<LanguageChangeDialog> {
  late String _selectedLanguageCode;
  late String _selectedLanguage;
  bool _isLoading = false;

  final Map<String, String> languages = {
    'en': Loc.english(),
    'zh': Loc.mandarinChinese(),
    'hi': Loc.hindi(),
    'es': Loc.spanish(),
    'fr': Loc.french(),
    'ar': Loc.arabic(),
    'bn': Loc.bengali(),
    'pt': Loc.portuguese(),
    'ru': Loc.russian(),
    'ur': Loc.urdu(),
  };

  @override
  void initState() {
    super.initState();
    // 🔥 Default to English if not found
    _selectedLanguageCode = languages.containsKey(widget.currentLanguageCode)
        ? widget.currentLanguageCode!
        : 'en';

    _selectedLanguage =
        di<LangRepo>().selectedLanguage ?? Loc.english();
  }

  @override
  Widget build(BuildContext context) {
    final dialogService = di<DialogService>();
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: theme.dialogBackgroundColor.withOpacity(0.95),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tr('change_language'),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: languages.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final code = languages.keys.elementAt(index);
                  final name = languages.values.elementAt(index);

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: _selectedLanguageCode == code
                          ? theme.primaryColor.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: RadioListTile<String>(
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      title: Text(name),
                      value: code,
                      groupValue: _selectedLanguageCode,
                      activeColor: theme.primaryColor,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedLanguageCode = value;
                            _selectedLanguage =
                                languages[value] ?? Loc.unknownLanguage();
                          });
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => dialogService.hideDialog(context),
                  child: Text(
                    Loc.cancel(),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: _isLoading
                      ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: Colors.white,
                    ),
                  )
                      : const Icon(Icons.check),
                  label: Text(
                    _isLoading ? tr('loading') : Loc.apply(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: _isLoading
                      ? null
                      : () async {
                    setState(() => _isLoading = true);
                    final result = await di<LangRepo>().setLang(
                      lang: _selectedLanguageCode,
                      language: _selectedLanguage,
                      context: context,
                    );
                    setState(() => _isLoading = false);

                    result.match(
                          (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error)),
                        );
                      },
                          (_) {
                        widget.onLanguageSelected(_selectedLanguageCode);
                        dialogService.hideDialog(context);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
