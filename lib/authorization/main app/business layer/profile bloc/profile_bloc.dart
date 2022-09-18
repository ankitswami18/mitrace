// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../data layer/profile data layer/profile_model.dart';
// import '../../data layer/profile data layer/profile_repository.dart';
// import 'profile_bloc_model.dart';

// class ProfileBloc {
//   // GETTING THE BLOC MODEL OBJECT.
//   ProfileBlocModel _model = ProfileBlocModel();

//   // STEP 1: CREATE THE STREAM-CONTROLLER
//   final StreamController<ProfileBlocModel> _streamController =
//       StreamController<ProfileBlocModel>();

//   // Step 2: CLOSING THE STREAM-CONTROLLER
//   dispose() {
//     _streamController.close();
//   }

//   // Step 3: STREAM (GET THE VALUES FROM STREAM)
//   Stream<ProfileBlocModel> get streamBlocModel => _streamController.stream;

//   // Step 4: ADDING VALUES TO THE STREAM
//   void updateWith({
//     ProfileModel? profileModel,
//     int? likesCount,
//     int? reputationScore,
//     bool? isLikedByMe,
//     bool? isProfileOwner,
//   }) {
//     _model = _model.copyWith(
//       profileModel: profileModel,
//       likesCount: likesCount,
//       reputationScore: reputationScore,
//       isLikedByMe: isLikedByMe,
//     );
//     _streamController.sink.add(_model);
//   }

//   // LOGIC CODE:

//   // Future<int> getReputationScore(
//   //   String profileId,
//   //   BuildContext context,
//   // ) async {
//   //   ProfileModel proMdl =
//   //       await getUserModel(context: context, ownerId: profileId);
//   //   int score = proMdl.sentLcCount! +
//   //       proMdl.sentPcCount! +
//   //       proMdl.recivedLcCount! +
//   //       proMdl.recivedPcCount!;
//   //   return score;
//   // }

//   // BACKEND CODE:

//   Future<ProfileModel> getUserModel({
//     required BuildContext context,
//     required String ownerId,
//   }) async {
//     final repObj = Provider.of<ProfileRepository>(context, listen: false);
//     return await repObj.getUserModel(userId: ownerId);
//   }

//   // Future<List<PostModel>> getPostModelsList({
//   //   required BuildContext context,
//   //   required String ownerId,
//   // }) async {
//   //   final postRepObj = Provider.of<PostsRepository>(context, listen: false);
//   //   List<PostModel> postsTemp =
//   //       await postRepObj.getAllPosts(profileId: ownerId);
//   //   return postsTemp;
//   // }

//   // Future<int> getLikesCount({
//   //   required BuildContext context,
//   //   required String ownerId,
//   // }) async {
//   //   final likesRepObj = Provider.of<LikesRepository>(context, listen: false);
//   //   int x = await likesRepObj.getLikesCount(ownerId: ownerId);
//   //   return x;
//   // }

//   // Future<bool> getIsLikedByMe({
//   //   required String ownerId,
//   //   required String myId,
//   //   required BuildContext context,
//   // }) async {
//   //   final likesRepObj = Provider.of<LikesRepository>(context, listen: false);
//   //   bool x = await likesRepObj.checkIsLikedByMe(
//   //     ownerId: ownerId,
//   //     myId: myId,
//   //   );
//   //   return x;
//   // }

//   // Future<ConnectionStatus> getConnectionStatus({
//   //   required BuildContext context,
//   //   required String ownerId,
//   //   required String myId,
//   // }) async {
//   //   final connectionRepObj =
//   //       Provider.of<ConnectionRepository>(context, listen: false);
//   //   ConnectionStatus cs = await connectionRepObj.getConnectionStatus(
//   //     myId: myId,
//   //     ownerId: ownerId,
//   //   );
//   //   return cs;
//   // }

//   // void removeConnection({
//   //   required BuildContext context,
//   //   required String myId,
//   //   required String ownerId,
//   // }) {
//   //   final connectionRepObj =
//   //       Provider.of<ConnectionRepository>(context, listen: false);
//   //   connectionRepObj.removeConnection(
//   //     ownerId: ownerId,
//   //     myId: myId,
//   //   );
//   // }

//   // void requestConnection({
//   //   required BuildContext context,
//   //   required String myId,
//   //   required String ownerId,
//   // }) {
//   //   final connectionRepObj =
//   //       Provider.of<ConnectionRepository>(context, listen: false);
//   //   connectionRepObj.requestConnection(
//   //     ownerId: ownerId,
//   //     myId: myId,
//   //   );
//   // }

//   // void acceptConnection({
//   //   required BuildContext context,
//   //   required String myId,
//   //   required String ownerId,
//   // }) {
//   //   final connectionRepObj =
//   //       Provider.of<ConnectionRepository>(context, listen: false);
//   //   connectionRepObj.acceptConnection(
//   //     ownerId: ownerId,
//   //     myId: myId,
//   //   );
//   // }

//   // updateFriendship({
//   //   required BuildContext context,
//   //   required String myId,
//   //   required String friendId,
//   // }) async {
//   //   final friendsRepObj =
//   //       Provider.of<FriendsRepository>(context, listen: false);
//   //   String x = await friendsRepObj.checkIfFriends(
//   //     myId: myId,
//   //     friendId: friendId,
//   //   );
//   //   _model = _model.copyWith(
//   //     isFriend: x,
//   //   );
//   //   _streamController.sink.add(_model);
//   //   // return x;
//   // }

//   // removeFriend({
//   //   required BuildContext context,
//   //   required String profileId,
//   //   required String myId,
//   // }) {
//   //   final friendRepObj = Provider.of<FriendsRepository>(context, listen: false);
//   //   friendRepObj.removeFriend(
//   //     friendId: profileId,
//   //     myId: myId,
//   //   );
//   //   updateTotalFriends(context: context, profileId: profileId);
//   //   updateFriendship(context: context, friendId: profileId, myId: myId);
//   // }

//   // sendFriendRequest({
//   //   required BuildContext context,
//   //   required String profileId,
//   //   required String myId,
//   // }) {
//   //   final friendRepObj = Provider.of<FriendsRepository>(context, listen: false);
//   //   friendRepObj.addFriend(
//   //     friendId: profileId,
//   //     myId: myId,
//   //   );
//   //   updateTotalFriends(context: context, profileId: profileId);
//   //   updateFriendship(context: context, friendId: profileId, myId: myId);
//   // }

//   // removeRequestSent({
//   //   required BuildContext context,
//   //   required String profileId,
//   //   required String myId,
//   // }) {
//   //   final friendRepObj = Provider.of<FriendsRepository>(context, listen: false);
//   //   friendRepObj.cancelFriendRequestSent(
//   //     friendId: profileId,
//   //     myId: myId,
//   //   );
//   //   updateTotalFriends(context: context, profileId: profileId);
//   //   // updateFriendship(context: context, friendId: profileId, myId: myId);
//   //   updateWith(isFriend: 'false');
//   // }

//   // Future<List<PostModel>> getPostModelsList({
//   //   required BuildContext context,
//   //   required String profileId,
//   // }) async {
//   //   final postRepObj = Provider.of<PostsRepository>(context, listen: false);
//   //   List<PostModel> postsTemp =
//   //       await postRepObj.getAllPosts(profileId: profileId);
//   //   return postsTemp;
//   //   // print('getPostModelsList : ${postsTemp.length}');
//   //   // _model = _model.copyWith(
//   //   //   postModelsList: postsTemp,
//   //   // );
//   //   // _streamController.sink.add(_model);
//   //   // return postsTemp;
//   // }

//   // sendCloudFromProfile({
//   //   required String cloudMessage,
//   //   required CloudType cloudType,
//   //   required UserModel sentByUsrModel,
//   //   required UserModel recivedByUsrModel,
//   //   required BuildContext context,
//   // }) {
//   //   final cloudsRepository =
//   //       Provider.of<CloudsRepository>(context, listen: false);
//   //   cloudsRepository.sendCloud(
//   //     cloudMessage: cloudMessage,
//   //     cloudType: cloudType,
//   //     sentByUsrModel: sentByUsrModel,
//   //     recivedByUsrModel: recivedByUsrModel,
//   //   );
//   // }
// }
