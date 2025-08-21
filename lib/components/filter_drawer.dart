import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/quran_provider.dart';

class FilterDrawer extends ConsumerWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(translationLangProvider);

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
              Text(
                'Translation',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
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
              Text(
                'Arabic Font Size',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.secondaryContainer
                      .withAlpha((0.3 * 255).round()),
                ),
                child: StatefulBuilder(
                  builder: (context, setModalState) {
                    int _selectedCount = 16;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SliderTheme(
                          data: Theme.of(context).sliderTheme,
                          child: Slider(
                            min: 1,
                            max: 100,
                            divisions: 99,
                            value: _selectedCount.toDouble(),
                            onChanged: (value) {
                              setModalState(() {
                                _selectedCount = value.toInt();
                              });
                            },
                          ),
                        ),
                        Text(
                          'Font Size: $_selectedCount',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${lang.label} Font Size',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.secondaryContainer
                      .withAlpha((0.3 * 255).round()),
                ),
                child: StatefulBuilder(
                  builder: (context, setModalState) {
                    int _selectedCount = 16;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SliderTheme(
                          data: Theme.of(context).sliderTheme,
                          child: Slider(
                            min: 1,
                            max: 100,
                            divisions: 99,
                            value: _selectedCount.toDouble(),
                            onChanged: (value) {
                              setModalState(() {
                                _selectedCount = value.toInt();
                              });
                            },
                          ),
                        ),
                        Text(
                          'Font Size: $_selectedCount',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
