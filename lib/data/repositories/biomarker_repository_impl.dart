import '../../features/shared/domain/entities/biomarker.dart' as domain;
import '../../features/shared/domain/repositories/biomarker_repository.dart';
import '../datasources/local/daos/biomarker_dao.dart';
import '../mappers/biomarker_mapper.dart';

class BiomarkerRepositoryImpl implements BiomarkerRepository {
  final BiomarkerDao _dao;
  final int _userId; // Single-user assumption

  BiomarkerRepositoryImpl(this._dao, this._userId);

  @override
  Stream<domain.Biomarker?> watchTodaysBiomarkers() {
    return _dao.watchTodaysBiomarkers(_userId).map((data) {
      if (data == null) return null;
      return data.toEntity();
    });
  }

  @override
  Future<void> saveBiomarkers(domain.Biomarker biomarker) async {
    await _dao.upsertBiomarkers(biomarker.toCompanion());
  }
}
