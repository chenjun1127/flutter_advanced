import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/routes/routes.dart';
import 'package:flutter_advanced/ui/pages/state/change_notifier_widget.dart';
import 'package:flutter_advanced/ui/pages/state/stream_subscription_widget.dart';
import 'package:flutter_advanced/ui/pages/state/value_notifier_widget.dart';

class StatePage extends StatelessWidget {
  const StatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return buildItem(index, context);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 0.5),
      itemCount: routeMap.keys.length,
    );
  }

  Widget buildItem(int index, BuildContext context) {
    return CupertinoButton(
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(routeMap.keys.toList()[index], style: const TextStyle(color: Colors.black, fontSize: 18)),
      ),
      onPressed: () {
        if (index == 0) {
          Navigator.pushNamed(context, ChangeNotifierWidget.routeName);
        } else if (index == 1) {
          Navigator.pushNamed(context, StreamSubscriptionWidget.routeName);
        } else if (index == 2) {
          Navigator.pushNamed(context, ValueNotifierWidget.routeName);
        }
      },
    );
  }
}
