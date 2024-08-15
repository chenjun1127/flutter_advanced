import 'package:common_ui/common_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/widgets/list_widget.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 30),
      height: 280,
      child: Column(
        children: <Widget>[
          Expanded(child: Obx(() {
            return ListWidget(
              children: LanguageType.values.map((LanguageType e) => e.name).toList(),
              initItem: LanguageType.values.indexOf(LanguageController.to.language),
              onTap: (String value, int index) {
                final LanguageType language = LanguageType.values[index];
                LanguageController.to.language = language;
              },
            );
          })),
        ],
      ),
    );
  }
}
