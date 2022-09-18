import 'package:flutter/material.dart';
import 'package:mitrace/authentication/auth.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20customer/data%20layer/create_account_repository.dart';
import 'package:mitrace/authorization/main%20app/data%20layer/payment%20data%20layer/payment_details_repository.dart';
import 'package:provider/provider.dart';
import '../authorization/create account/create account vendor/data layer/vendor_account_repository.dart';

class RepositoriesProvider extends StatelessWidget {
  const RepositoriesProvider({required this.myMaterialApp, Key? key})
      : super(key: key);
  final MaterialApp myMaterialApp;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // AUTHENTICATION DEPENDENCIES
        Provider<FirebaseAuthApi>(
          create: (_) => FirebaseAuthApi(),
        ),
        // CREATE ACCOUNT FOR VENDOR.
        Provider<VendorAccountRepository>(
          create: (_) => VendorAccountRepository(),
        ),
        Provider<CustomerAccountRepository>(
          create: (_) => CustomerAccountRepository(),
        ),
        Provider<PaymentDetailsRepository>(
          create: (_) => PaymentDetailsRepository(),
        ),

        // // MAIN APP
        // Provider<ChatRepository>(
        //   create: (_) => ChatRepository(),
        // ),
        // Provider<CloudsRepository>(
        //   create: (_) => CloudsRepository(),
        // ),
        // Provider<CommentsRepository>(
        //   create: (_) => CommentsRepository(),
        // ),
        // Provider<ConnectionRepository>(
        //   create: (_) => ConnectionRepository(),
        // ),
        // Provider<FriendsRepository>(
        //   create: (_) => FriendsRepository(),
        // ),
        // Provider<LikesRepository>(
        //   create: (_) => LikesRepository(),
        // ),
        // Provider<MapReposirory>(
        //   create: (_) => MapReposirory(),
        // ),
        // Provider<PostsRepository>(
        //   create: (_) => PostsRepository(),
        // ),
        // Provider<ProfileRepository>(
        //   create: (_) => ProfileRepository(),
        // ),
        // Provider<ProfileSearchesRepository>(
        //   create: (_) => ProfileSearchesRepository(),
        // ),
        // Provider<ReveledIdentityRepository>(
        //   create: (_) => ReveledIdentityRepository(),
        // ),
      ],
      child: myMaterialApp,
    );
  }
}
