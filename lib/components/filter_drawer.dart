import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/quran_provider.dart';

class FilterDrawer extends ConsumerWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(translationLangProvider);
    final arabicFontSize = ref.watch(arabicFontSizeProvider);
    final translationFontSize = ref.watch(translationFontSizeProvider);

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
          child: Column(
            children: [
              Text(
                'F I L T E R S',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const Divider(indent: 25, endIndent: 25),
              const SizedBox(height: 12),

              // 🔹 Language Switch
              Text(
                'Translation',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.secondaryContainer
                      .withAlpha((0.3 * 255).round()),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'বাংলা',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        CupertinoSwitch(
                          value: lang == TranslationLang.bn,
                          onChanged: (val) {
                            if (val) {
                              ref.read(translationLangProvider.notifier).state =
                                  TranslationLang.bn;
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'English',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        CupertinoSwitch(
                          value: lang == TranslationLang.en,
                          onChanged: (val) {
                            if (val) {
                              ref.read(translationLangProvider.notifier).state =
                                  TranslationLang.en;
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 🔹 Arabic Font Slider
              Text(
                'Arabic Font Size',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.secondaryContainer
                      .withAlpha((0.3 * 255).round()),
                ),
                child: Column(
                  children: [
                    Slider(
                      min: 8,
                      max: 50,
                      divisions: 42,
                      value: arabicFontSize.toDouble(),
                      onChanged: (value) {
                        ref.read(arabicFontSizeProvider.notifier).state = value
                            .toInt();
                      },
                    ),
                    Text(
                      'Font Size: $arabicFontSize',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 🔹 Translation Font Slider
              Text(
                '${lang.label} Font Size',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.secondaryContainer
                      .withAlpha((0.3 * 255).round()),
                ),
                child: Column(
                  children: [
                    Slider(
                      min: 8,
                      max: 50,
                      divisions: 42,
                      value: translationFontSize.toDouble(),
                      onChanged: (value) {
                        ref.read(translationFontSizeProvider.notifier).state =
                            value.toInt();
                      },
                    ),
                    Text(
                      'Font Size: $translationFontSize',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
