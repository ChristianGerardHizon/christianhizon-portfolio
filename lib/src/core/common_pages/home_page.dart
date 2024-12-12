import 'package:flutter/material.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    ///
    ///
    ref.listen(authControllerProvider, (previous, current) {
      if (current is AsyncError) const LoginPageRoute().go(context);
    });


    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Placeholder(
            child: Text('Home Page'),
          ),
          ListTile(
            title: const Text('Account'),
            subtitle: const Text('your account details will be here'),
            onTap: () => const AccountPageRoute().push(context),
          ),
          // ListTile(
          //   title: const Text('Register as a Seller'),
          //   onTap: () => const SellerApplicationPageRoute().push(context),
          // ),
          // ListTile(
          //   title: const Text('Products'),
          //   subtitle: const Text('search for products here'),
          //   onTap: () => const PublicProductsPageRoute().push(context),
          // ),
          // ListTile(
          //   title: const Text('Bids'),
          //   subtitle: const Text('your bids are all here'),
          //   onTap: () => const BidsPageRoute().push(context),
          // ),
          // ListTile(
          //   title: const Text('Orders'),
          //   subtitle: const Text('your orders are all here'),
          //   onTap: () => const OrdersPageRoute().push(context),
          // ),
          // if (isStoreOwner)
          //   ListTile(
          //     title: const Text('Store Categories'),
          //     onTap: () => CategoriesPageRoute().push(context),
          //   ),
          // if (isStoreOwner)
          //   ListTile(
          //     title: const Text('Store Products'),
          //     onTap: () => const PublicProductsPageRoute().push(context),
          //   ),
          // if (isStoreOwner)
          //   ListTile(
          //     title: const Text('Stores'),
          //     subtitle: const Text('as a seller all the stores will be here'),
          //     onTap: () => const StoresPageRoute().push(context),
          //   ),
          ListTile(
            title: const Text('Settings'),
            subtitle: const Text('your orders are all here'),
            onTap: () => const SettingsPageRoute().push(context),
          )
        ],
      ),
    );
  }
}
