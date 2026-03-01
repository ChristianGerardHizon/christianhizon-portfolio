import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/profile.dart';

part 'profile_repository.g.dart';

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(pb: ref.watch(pocketbaseProvider));
}

class ProfileRepository {
  final PocketBase pb;

  ProfileRepository({required this.pb});

  RecordService get _collection =>
      pb.collection(PocketBaseCollections.profile);

  Profile _fromRecord(RecordModel record) {
    final data = record.toJson();
    // Parse skills JSON
    List<Skill> skills = [];
    if (data['skills'] is List) {
      skills = (data['skills'] as List)
          .map((s) => Skill(
                name: s['name']?.toString() ?? '',
                category: s['category']?.toString() ?? '',
              ))
          .toList();
    }

    // Parse experience JSON
    List<Experience> experience = [];
    if (data['experience'] is List) {
      experience = (data['experience'] as List)
          .map((e) => Experience(
                company: e['company']?.toString() ?? '',
                role: e['role']?.toString() ?? '',
                startDate: e['startDate']?.toString() ?? '',
                endDate: e['endDate']?.toString(),
                description: e['description']?.toString() ?? '',
              ))
          .toList();
    }

    // Parse stats JSON
    List<ProfileStat> stats = [];
    if (data['stats'] is List) {
      stats = (data['stats'] as List)
          .map((s) => ProfileStat(
                value: s['value']?.toString() ?? '',
                label: s['label']?.toString() ?? '',
              ))
          .toList();
    }

    return Profile(
      id: record.id,
      name: data['name']?.toString() ?? '',
      title: data['title']?.toString() ?? '',
      bio: data['bio']?.toString() ?? '',
      photo: data['photo']?.toString() ?? '',
      email: data['email']?.toString() ?? '',
      phone: data['phone']?.toString() ?? '',
      location: data['location']?.toString() ?? '',
      githubUrl: data['githubUrl']?.toString() ?? '',
      linkedinUrl: data['linkedinUrl']?.toString() ?? '',
      websiteUrl: data['websiteUrl']?.toString() ?? '',
      resumeUrl: data['resumeUrl']?.toString() ?? '',
      availabilityStatus: data['availabilityStatus']?.toString() ?? '',
      stackOverflowUrl: data['stackOverflowUrl']?.toString() ?? '',
      skills: skills,
      experience: experience,
      stats: stats,
      collectionId: record.collectionId,
    );
  }

  /// Get the single profile record.
  FutureEither<Profile?> getProfile() async {
    return TaskEither.tryCatch(
      () async {
        final result = await _collection.getList(page: 1, perPage: 1);
        if (result.items.isEmpty) return null;
        return _fromRecord(result.items.first);
      },
      Failure.handle,
    ).run();
  }

  /// Create or update the profile.
  FutureEither<Profile> saveProfile({
    String? id,
    required Map<String, dynamic> data,
  }) async {
    return TaskEither.tryCatch(
      () async {
        RecordModel record;
        if (id != null && id.isNotEmpty) {
          record = await _collection.update(id, body: data);
        } else {
          record = await _collection.create(body: data);
        }
        return _fromRecord(record);
      },
      Failure.handle,
    ).run();
  }
}
