import '../../../create account/create account vendor/data layer/vendor_profile_model.dart';

class ProfileBlocModel {
  ProfileBlocModel({
    this.profileModel,
    this.isProfileOwner = false,
    this.likesCount = 0,
    this.reputationScore = 0,
    this.isLikedByMe = false,
  });
  final VendorProfileModel? profileModel;
  final bool isProfileOwner;
  final int likesCount;
  final int reputationScore;
  final bool isLikedByMe;

  ProfileBlocModel copyWith({
    VendorProfileModel? profileModel,
    bool? isProfileOwner,
    int? likesCount,
    int? reputationScore,
    bool? isLikedByMe,
  }) {
    return ProfileBlocModel(
      profileModel: profileModel ?? this.profileModel,
      isProfileOwner: isProfileOwner ?? this.isProfileOwner,
      likesCount: likesCount ?? this.likesCount,
      reputationScore: reputationScore ?? this.reputationScore,
      isLikedByMe: isLikedByMe ?? this.isLikedByMe,
    );
  }

  // OTHER BUSINESS LOGIC:

  bool checkIfProfileOwner({required String myId, required String secondId}) {
    return myId == secondId;
  }
}
