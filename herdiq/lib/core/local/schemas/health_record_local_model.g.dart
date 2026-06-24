// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_record_local_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHealthRecordLocalModelCollection on Isar {
  IsarCollection<HealthRecordLocalModel> get healthRecordLocalModels =>
      this.collection();
}

const HealthRecordLocalModelSchema = CollectionSchema(
  name: r'HealthRecordLocalModel',
  id: 4257280117367775921,
  properties: {
    r'animalId': PropertySchema(
      id: 0,
      name: r'animalId',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'date': PropertySchema(
      id: 2,
      name: r'date',
      type: IsarType.string,
    ),
    r'dewormingDose': PropertySchema(
      id: 3,
      name: r'dewormingDose',
      type: IsarType.string,
    ),
    r'dewormingProduct': PropertySchema(
      id: 4,
      name: r'dewormingProduct',
      type: IsarType.string,
    ),
    r'expectedDelivery': PropertySchema(
      id: 5,
      name: r'expectedDelivery',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 6,
      name: r'id',
      type: IsarType.string,
    ),
    r'isOfficialWeight': PropertySchema(
      id: 7,
      name: r'isOfficialWeight',
      type: IsarType.bool,
    ),
    r'isSynced': PropertySchema(
      id: 8,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'matingDate': PropertySchema(
      id: 9,
      name: r'matingDate',
      type: IsarType.string,
    ),
    r'medications': PropertySchema(
      id: 10,
      name: r'medications',
      type: IsarType.string,
    ),
    r'nextDue': PropertySchema(
      id: 11,
      name: r'nextDue',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 12,
      name: r'notes',
      type: IsarType.string,
    ),
    r'orgId': PropertySchema(
      id: 13,
      name: r'orgId',
      type: IsarType.string,
    ),
    r'pendingOperation': PropertySchema(
      id: 14,
      name: r'pendingOperation',
      type: IsarType.string,
    ),
    r'recordType': PropertySchema(
      id: 15,
      name: r'recordType',
      type: IsarType.string,
    ),
    r'sireAnimalId': PropertySchema(
      id: 16,
      name: r'sireAnimalId',
      type: IsarType.string,
    ),
    r'treatmentType': PropertySchema(
      id: 17,
      name: r'treatmentType',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 18,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'vaccineName': PropertySchema(
      id: 19,
      name: r'vaccineName',
      type: IsarType.string,
    ),
    r'vetName': PropertySchema(
      id: 20,
      name: r'vetName',
      type: IsarType.string,
    ),
    r'weightUnit': PropertySchema(
      id: 21,
      name: r'weightUnit',
      type: IsarType.string,
    ),
    r'weightValue': PropertySchema(
      id: 22,
      name: r'weightValue',
      type: IsarType.double,
    )
  },
  estimateSize: _healthRecordLocalModelEstimateSize,
  serialize: _healthRecordLocalModelSerialize,
  deserialize: _healthRecordLocalModelDeserialize,
  deserializeProp: _healthRecordLocalModelDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'animalId': IndexSchema(
      id: -8446297297210463032,
      name: r'animalId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'animalId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'orgId': IndexSchema(
      id: 4612512750172861184,
      name: r'orgId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'orgId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _healthRecordLocalModelGetId,
  getLinks: _healthRecordLocalModelGetLinks,
  attach: _healthRecordLocalModelAttach,
  version: '3.1.0+1',
);

int _healthRecordLocalModelEstimateSize(
  HealthRecordLocalModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.animalId.length * 3;
  bytesCount += 3 + object.date.length * 3;
  {
    final value = object.dewormingDose;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.dewormingProduct;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.expectedDelivery;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.matingDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.medications;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nextDue;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.orgId.length * 3;
  {
    final value = object.pendingOperation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.recordType.length * 3;
  {
    final value = object.sireAnimalId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.treatmentType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.vaccineName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.vetName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.weightUnit;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _healthRecordLocalModelSerialize(
  HealthRecordLocalModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.animalId);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.date);
  writer.writeString(offsets[3], object.dewormingDose);
  writer.writeString(offsets[4], object.dewormingProduct);
  writer.writeString(offsets[5], object.expectedDelivery);
  writer.writeString(offsets[6], object.id);
  writer.writeBool(offsets[7], object.isOfficialWeight);
  writer.writeBool(offsets[8], object.isSynced);
  writer.writeString(offsets[9], object.matingDate);
  writer.writeString(offsets[10], object.medications);
  writer.writeString(offsets[11], object.nextDue);
  writer.writeString(offsets[12], object.notes);
  writer.writeString(offsets[13], object.orgId);
  writer.writeString(offsets[14], object.pendingOperation);
  writer.writeString(offsets[15], object.recordType);
  writer.writeString(offsets[16], object.sireAnimalId);
  writer.writeString(offsets[17], object.treatmentType);
  writer.writeDateTime(offsets[18], object.updatedAt);
  writer.writeString(offsets[19], object.vaccineName);
  writer.writeString(offsets[20], object.vetName);
  writer.writeString(offsets[21], object.weightUnit);
  writer.writeDouble(offsets[22], object.weightValue);
}

HealthRecordLocalModel _healthRecordLocalModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HealthRecordLocalModel();
  object.animalId = reader.readString(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.date = reader.readString(offsets[2]);
  object.dewormingDose = reader.readStringOrNull(offsets[3]);
  object.dewormingProduct = reader.readStringOrNull(offsets[4]);
  object.expectedDelivery = reader.readStringOrNull(offsets[5]);
  object.id = reader.readString(offsets[6]);
  object.isOfficialWeight = reader.readBool(offsets[7]);
  object.isSynced = reader.readBool(offsets[8]);
  object.isarId = id;
  object.matingDate = reader.readStringOrNull(offsets[9]);
  object.medications = reader.readStringOrNull(offsets[10]);
  object.nextDue = reader.readStringOrNull(offsets[11]);
  object.notes = reader.readStringOrNull(offsets[12]);
  object.orgId = reader.readString(offsets[13]);
  object.pendingOperation = reader.readStringOrNull(offsets[14]);
  object.recordType = reader.readString(offsets[15]);
  object.sireAnimalId = reader.readStringOrNull(offsets[16]);
  object.treatmentType = reader.readStringOrNull(offsets[17]);
  object.updatedAt = reader.readDateTime(offsets[18]);
  object.vaccineName = reader.readStringOrNull(offsets[19]);
  object.vetName = reader.readStringOrNull(offsets[20]);
  object.weightUnit = reader.readStringOrNull(offsets[21]);
  object.weightValue = reader.readDoubleOrNull(offsets[22]);
  return object;
}

P _healthRecordLocalModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readDateTime(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _healthRecordLocalModelGetId(HealthRecordLocalModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _healthRecordLocalModelGetLinks(
    HealthRecordLocalModel object) {
  return [];
}

void _healthRecordLocalModelAttach(
    IsarCollection<dynamic> col, Id id, HealthRecordLocalModel object) {
  object.isarId = id;
}

extension HealthRecordLocalModelByIndex
    on IsarCollection<HealthRecordLocalModel> {
  Future<HealthRecordLocalModel?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  HealthRecordLocalModel? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<HealthRecordLocalModel?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<HealthRecordLocalModel?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(HealthRecordLocalModel object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(HealthRecordLocalModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<HealthRecordLocalModel> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<HealthRecordLocalModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension HealthRecordLocalModelQueryWhereSort
    on QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QWhere> {
  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HealthRecordLocalModelQueryWhere on QueryBuilder<
    HealthRecordLocalModel, HealthRecordLocalModel, QWhereClause> {
  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterWhereClause> isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterWhereClause> isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterWhereClause> isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterWhereClause> idNotEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterWhereClause> animalIdEqualTo(String animalId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'animalId',
        value: [animalId],
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterWhereClause> animalIdNotEqualTo(String animalId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'animalId',
              lower: [],
              upper: [animalId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'animalId',
              lower: [animalId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'animalId',
              lower: [animalId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'animalId',
              lower: [],
              upper: [animalId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterWhereClause> orgIdEqualTo(String orgId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'orgId',
        value: [orgId],
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterWhereClause> orgIdNotEqualTo(String orgId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orgId',
              lower: [],
              upper: [orgId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orgId',
              lower: [orgId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orgId',
              lower: [orgId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orgId',
              lower: [],
              upper: [orgId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension HealthRecordLocalModelQueryFilter on QueryBuilder<
    HealthRecordLocalModel, HealthRecordLocalModel, QFilterCondition> {
  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> animalIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'animalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> animalIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'animalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> animalIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'animalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> animalIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'animalId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> animalIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'animalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> animalIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'animalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      animalIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'animalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      animalIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'animalId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> animalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'animalId',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> animalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'animalId',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      dateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      dateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'date',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingDoseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dewormingDose',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingDoseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dewormingDose',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingDoseEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dewormingDose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingDoseGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dewormingDose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingDoseLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dewormingDose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingDoseBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dewormingDose',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingDoseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dewormingDose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingDoseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dewormingDose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      dewormingDoseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dewormingDose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      dewormingDoseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dewormingDose',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingDoseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dewormingDose',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingDoseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dewormingDose',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingProductIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dewormingProduct',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingProductIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dewormingProduct',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingProductEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dewormingProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingProductGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dewormingProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingProductLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dewormingProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingProductBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dewormingProduct',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingProductStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dewormingProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingProductEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dewormingProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      dewormingProductContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dewormingProduct',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      dewormingProductMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dewormingProduct',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingProductIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dewormingProduct',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> dewormingProductIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dewormingProduct',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> expectedDeliveryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expectedDelivery',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> expectedDeliveryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expectedDelivery',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> expectedDeliveryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedDelivery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> expectedDeliveryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedDelivery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> expectedDeliveryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedDelivery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> expectedDeliveryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedDelivery',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> expectedDeliveryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'expectedDelivery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> expectedDeliveryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'expectedDelivery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      expectedDeliveryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'expectedDelivery',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      expectedDeliveryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'expectedDelivery',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> expectedDeliveryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedDelivery',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> expectedDeliveryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'expectedDelivery',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> isOfficialWeightEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOfficialWeight',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> isSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> matingDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'matingDate',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> matingDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'matingDate',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> matingDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matingDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> matingDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'matingDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> matingDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'matingDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> matingDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'matingDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> matingDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'matingDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> matingDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'matingDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      matingDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'matingDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      matingDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'matingDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> matingDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matingDate',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> matingDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'matingDate',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> medicationsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'medications',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> medicationsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'medications',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> medicationsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'medications',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> medicationsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'medications',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> medicationsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'medications',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> medicationsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'medications',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> medicationsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'medications',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> medicationsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'medications',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      medicationsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'medications',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      medicationsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'medications',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> medicationsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'medications',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> medicationsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'medications',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> nextDueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextDue',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> nextDueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextDue',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> nextDueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextDue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> nextDueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextDue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> nextDueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextDue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> nextDueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextDue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> nextDueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nextDue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> nextDueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nextDue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      nextDueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nextDue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      nextDueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nextDue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> nextDueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextDue',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> nextDueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nextDue',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> orgIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> orgIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> orgIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> orgIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orgId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> orgIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'orgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> orgIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'orgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      orgIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'orgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      orgIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'orgId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> orgIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orgId',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> orgIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'orgId',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> pendingOperationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pendingOperation',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> pendingOperationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pendingOperation',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> pendingOperationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pendingOperation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> pendingOperationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pendingOperation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> pendingOperationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pendingOperation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> pendingOperationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pendingOperation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> pendingOperationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pendingOperation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> pendingOperationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pendingOperation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      pendingOperationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pendingOperation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      pendingOperationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pendingOperation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> pendingOperationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pendingOperation',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> pendingOperationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pendingOperation',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> recordTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recordType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> recordTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recordType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> recordTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recordType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> recordTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recordType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> recordTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recordType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> recordTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recordType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      recordTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recordType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      recordTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recordType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> recordTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recordType',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> recordTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recordType',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> sireAnimalIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sireAnimalId',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> sireAnimalIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sireAnimalId',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> sireAnimalIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sireAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> sireAnimalIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sireAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> sireAnimalIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sireAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> sireAnimalIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sireAnimalId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> sireAnimalIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sireAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> sireAnimalIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sireAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      sireAnimalIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sireAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      sireAnimalIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sireAnimalId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> sireAnimalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sireAnimalId',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> sireAnimalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sireAnimalId',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> treatmentTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'treatmentType',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> treatmentTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'treatmentType',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> treatmentTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'treatmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> treatmentTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'treatmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> treatmentTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'treatmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> treatmentTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'treatmentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> treatmentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'treatmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> treatmentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'treatmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      treatmentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'treatmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      treatmentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'treatmentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> treatmentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'treatmentType',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> treatmentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'treatmentType',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vaccineNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vaccineName',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vaccineNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vaccineName',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vaccineNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vaccineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vaccineNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vaccineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vaccineNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vaccineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vaccineNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vaccineName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vaccineNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vaccineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vaccineNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vaccineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      vaccineNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vaccineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      vaccineNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vaccineName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vaccineNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vaccineName',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vaccineNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vaccineName',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vetNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vetName',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vetNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vetName',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vetNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vetName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vetNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vetName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vetNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vetName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vetNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vetName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vetNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vetName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vetNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vetName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      vetNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vetName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      vetNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vetName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vetNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vetName',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> vetNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vetName',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weightUnit',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weightUnit',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightUnitEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightUnitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightUnitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightUnitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weightUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'weightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'weightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      weightUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'weightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
          QAfterFilterCondition>
      weightUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'weightUnit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weightUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'weightUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weightValue',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weightValue',
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightValueEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weightValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightValueGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weightValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightValueLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weightValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel,
      QAfterFilterCondition> weightValueBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weightValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension HealthRecordLocalModelQueryObject on QueryBuilder<
    HealthRecordLocalModel, HealthRecordLocalModel, QFilterCondition> {}

extension HealthRecordLocalModelQueryLinks on QueryBuilder<
    HealthRecordLocalModel, HealthRecordLocalModel, QFilterCondition> {}

extension HealthRecordLocalModelQuerySortBy
    on QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QSortBy> {
  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByAnimalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalId', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByAnimalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalId', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByDewormingDose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dewormingDose', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByDewormingDoseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dewormingDose', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByDewormingProduct() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dewormingProduct', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByDewormingProductDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dewormingProduct', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByExpectedDelivery() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedDelivery', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByExpectedDeliveryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedDelivery', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByIsOfficialWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOfficialWeight', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByIsOfficialWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOfficialWeight', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByMatingDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matingDate', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByMatingDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matingDate', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByMedications() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medications', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByMedicationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medications', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByNextDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDue', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByNextDueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDue', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByOrgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByOrgIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByPendingOperation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByPendingOperationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByRecordType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordType', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByRecordTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordType', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortBySireAnimalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireAnimalId', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortBySireAnimalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireAnimalId', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByTreatmentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'treatmentType', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByTreatmentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'treatmentType', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByVaccineName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vaccineName', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByVaccineNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vaccineName', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByVetName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vetName', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByVetNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vetName', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByWeightUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightUnit', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByWeightUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightUnit', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByWeightValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightValue', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      sortByWeightValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightValue', Sort.desc);
    });
  }
}

extension HealthRecordLocalModelQuerySortThenBy on QueryBuilder<
    HealthRecordLocalModel, HealthRecordLocalModel, QSortThenBy> {
  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByAnimalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalId', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByAnimalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalId', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByDewormingDose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dewormingDose', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByDewormingDoseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dewormingDose', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByDewormingProduct() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dewormingProduct', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByDewormingProductDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dewormingProduct', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByExpectedDelivery() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedDelivery', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByExpectedDeliveryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedDelivery', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByIsOfficialWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOfficialWeight', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByIsOfficialWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOfficialWeight', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByMatingDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matingDate', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByMatingDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matingDate', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByMedications() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medications', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByMedicationsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medications', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByNextDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDue', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByNextDueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDue', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByOrgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByOrgIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByPendingOperation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByPendingOperationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByRecordType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordType', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByRecordTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordType', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenBySireAnimalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireAnimalId', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenBySireAnimalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireAnimalId', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByTreatmentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'treatmentType', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByTreatmentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'treatmentType', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByVaccineName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vaccineName', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByVaccineNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vaccineName', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByVetName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vetName', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByVetNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vetName', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByWeightUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightUnit', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByWeightUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightUnit', Sort.desc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByWeightValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightValue', Sort.asc);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QAfterSortBy>
      thenByWeightValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightValue', Sort.desc);
    });
  }
}

extension HealthRecordLocalModelQueryWhereDistinct
    on QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct> {
  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByAnimalId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'animalId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByDewormingDose({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dewormingDose',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByDewormingProduct({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dewormingProduct',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByExpectedDelivery({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expectedDelivery',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByIsOfficialWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOfficialWeight');
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByMatingDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'matingDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByMedications({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'medications', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByNextDue({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextDue', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByOrgId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orgId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByPendingOperation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pendingOperation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByRecordType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctBySireAnimalId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sireAnimalId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByTreatmentType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'treatmentType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByVaccineName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vaccineName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByVetName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vetName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByWeightUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecordLocalModel, HealthRecordLocalModel, QDistinct>
      distinctByWeightValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightValue');
    });
  }
}

extension HealthRecordLocalModelQueryProperty on QueryBuilder<
    HealthRecordLocalModel, HealthRecordLocalModel, QQueryProperty> {
  QueryBuilder<HealthRecordLocalModel, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String, QQueryOperations>
      animalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'animalId');
    });
  }

  QueryBuilder<HealthRecordLocalModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String, QQueryOperations>
      dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String?, QQueryOperations>
      dewormingDoseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dewormingDose');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String?, QQueryOperations>
      dewormingProductProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dewormingProduct');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String?, QQueryOperations>
      expectedDeliveryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expectedDelivery');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HealthRecordLocalModel, bool, QQueryOperations>
      isOfficialWeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOfficialWeight');
    });
  }

  QueryBuilder<HealthRecordLocalModel, bool, QQueryOperations>
      isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String?, QQueryOperations>
      matingDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'matingDate');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String?, QQueryOperations>
      medicationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medications');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String?, QQueryOperations>
      nextDueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextDue');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String?, QQueryOperations>
      notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String, QQueryOperations>
      orgIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orgId');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String?, QQueryOperations>
      pendingOperationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pendingOperation');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String, QQueryOperations>
      recordTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordType');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String?, QQueryOperations>
      sireAnimalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sireAnimalId');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String?, QQueryOperations>
      treatmentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'treatmentType');
    });
  }

  QueryBuilder<HealthRecordLocalModel, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String?, QQueryOperations>
      vaccineNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vaccineName');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String?, QQueryOperations>
      vetNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vetName');
    });
  }

  QueryBuilder<HealthRecordLocalModel, String?, QQueryOperations>
      weightUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightUnit');
    });
  }

  QueryBuilder<HealthRecordLocalModel, double?, QQueryOperations>
      weightValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightValue');
    });
  }
}
