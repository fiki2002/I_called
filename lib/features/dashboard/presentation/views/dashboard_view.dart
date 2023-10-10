import 'package:flutter/material.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';
import 'package:i_called/features/dashboard/presentation/change-notifier/home_notifier.dart';
import 'package:i_called/features/dashboard/presentation/widgets/contact_list_tile.dart';
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
      appBar: AppBar(
        backgroundColor: kcWhiteColor,
        elevation: 0,
        title: const TextWidget(
          'Contacts',
          fontSize: kfsExtraLarge,
          fontWeight: kW700,
        ),
      ),
      body: Consumer<HomeNotifier>(builder: (context, homeNotifier, _) {
        return StreamBuilder<List<UserModel>>(
          stream: homeNotifier.userList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return TextWidget('${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const TextWidget('No contacts');
            } else {
              final userList = snapshot.data;

              return ListView.builder(
                itemCount: userList?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, contact) {
                  final user = userList![contact];

                  return ContactListTile(user: user);
                },
              );
            }
          },
        );
      }),
    );
  }
}
