import 'package:flutter/material.dart';
import 'package:i_called/core/components/scaffold_widget.dart';
import 'package:i_called/features/dashboard/presentation/change-notifier/home_notifier.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});
  static const String route = 'dashboard-view';

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<HomeNotifier>(context, listen: false).getUser(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Consumer<HomeNotifier>(
        builder: (context, value, _) {
          return const Column(
            children: [],
          );
        },
      ),
    );
  }
}
