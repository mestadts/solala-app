// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breeding_record_local_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBreedingRecordLocalModelCollection on Isar {
  IsarCollection<BreedingRecordLocalModel> get breedingRecordLocalModels =>
      this.collection();
}

const BreedingRecordLocalModelSchema = CollectionSchema(
  name: r'BreedingRecordLocalModel',
  id: 2378434989318716093,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'damAnimalId': PropertySchema(
      id: 1,
      name: r'damAnimalId',
      type: IsarType.string,
    ),
    r'damSystemId': PropertySchema(
      id: 2,
      name: r'damSystemId',
      type: IsarType.string,
    ),
    r'damTagDisplay': PropertySchema(
      id: 3,
      name: r'damTagDisplay',
      type: IsarType.string,
    ),
    r'deliveryDate': PropertySchema(
      id: 4,
      name: r'deliveryDate',
      type: IsarType.string,
    ),
    r'femalesBorn': PropertySchema(
      id: 5,
      name: r'femalesBorn',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 6,
      name: r'id',
      type: IsarType.string,
    ),
    r'isSynced': PropertySchema(
      id: 7,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'malesBorn': PropertySchema(
      id: 8,
      name: r'malesBorn',
      type: IsarType.long,
    ),
    r'matingDate': PropertySchema(
      id: 9,
      name: r'matingDate',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 10,
      name: r'notes',
      type: IsarType.string,
    ),
    r'offspringCount': PropertySchema(
      id: 11,
      name: r'offspringCount',
      type: IsarType.long,
    ),
    r'orgId': PropertySchema(
      id: 12,
      name: r'orgId',
      type: IsarType.string,
    ),
    r'pendingOperation': PropertySchema(
      id: 13,
      name: r'pendingOperation',
      type: IsarType.string,
    ),
    r'sireAnimalId': PropertySchema(
      id: 14,
      name: r'sireAnimalId',
      type: IsarType.string,
    ),
    r'sireSystemId': PropertySchema(
      id: 15,
      name: r'sireSystemId',
      type: IsarType.string,
    ),
    r'sireTagDisplay': PropertySchema(
      id: 16,
      name: r'sireTagDisplay',
      type: IsarType.string,
    ),
    r'survivingCount': PropertySchema(
      id: 17,
      name: r'survivingCount',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 18,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _breedingRecordLocalModelEstimateSize,
  serialize: _breedingRecordLocalModelSerialize,
  deserialize: _breedingRecordLocalModelDeserialize,
  deserializeProp: _breedingRecordLocalModelDeserializeProp,
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
    ),
    r'damAnimalId': IndexSchema(
      id: 8917307930493326406,
      name: r'damAnimalId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'damAnimalId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _breedingRecordLocalModelGetId,
  getLinks: _breedingRecordLocalModelGetLinks,
  attach: _breedingRecordLocalModelAttach,
  version: '3.1.0+1',
);

int _breedingRecordLocalModelEstimateSize(
  BreedingRecordLocalModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.damAnimalId.length * 3;
  bytesCount += 3 + object.damSystemId.length * 3;
  bytesCount += 3 + object.damTagDisplay.length * 3;
  {
    final value = object.deliveryDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.matingDate.length * 3;
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
  {
    final value = object.sireAnimalId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sireSystemId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sireTagDisplay;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _breedingRecordLocalModelSerialize(
  BreedingRecordLocalModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.damAnimalId);
  writer.writeString(offsets[2], object.damSystemId);
  writer.writeString(offsets[3], object.damTagDisplay);
  writer.writeString(offsets[4], object.deliveryDate);
  writer.writeLong(offsets[5], object.femalesBorn);
  writer.writeString(offsets[6], object.id);
  writer.writeBool(offsets[7], object.isSynced);
  writer.writeLong(offsets[8], object.malesBorn);
  writer.writeString(offsets[9], object.matingDate);
  writer.writeString(offsets[10], object.notes);
  writer.writeLong(offsets[11], object.offspringCount);
  writer.writeString(offsets[12], object.orgId);
  writer.writeString(offsets[13], object.pendingOperation);
  writer.writeString(offsets[14], object.sireAnimalId);
  writer.writeString(offsets[15], object.sireSystemId);
  writer.writeString(offsets[16], object.sireTagDisplay);
  writer.writeLong(offsets[17], object.survivingCount);
  writer.writeDateTime(offsets[18], object.updatedAt);
}

BreedingRecordLocalModel _breedingRecordLocalModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BreedingRecordLocalModel();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.damAnimalId = reader.readString(offsets[1]);
  object.damSystemId = reader.readString(offsets[2]);
  object.damTagDisplay = reader.readString(offsets[3]);
  object.deliveryDate = reader.readStringOrNull(offsets[4]);
  object.femalesBorn = reader.readLongOrNull(offsets[5]);
  object.id = reader.readString(offsets[6]);
  object.isSynced = reader.readBool(offsets[7]);
  object.isarId = id;
  object.malesBorn = reader.readLongOrNull(offsets[8]);
  object.matingDate = reader.readString(offsets[9]);
  object.notes = reader.readStringOrNull(offsets[10]);
  object.offspringCount = reader.readLongOrNull(offsets[11]);
  object.orgId = reader.readString(offsets[12]);
  object.pendingOperation = reader.readStringOrNull(offsets[13]);
  object.sireAnimalId = reader.readStringOrNull(offsets[14]);
  object.sireSystemId = reader.readStringOrNull(offsets[15]);
  object.sireTagDisplay = reader.readStringOrNull(offsets[16]);
  object.survivingCount = reader.readLongOrNull(offsets[17]);
  object.updatedAt = reader.readDateTime(offsets[18]);
  return object;
}

P _breedingRecordLocalModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readLongOrNull(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readLongOrNull(offset)) as P;
    case 18:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _breedingRecordLocalModelGetId(BreedingRecordLocalModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _breedingRecordLocalModelGetLinks(
    BreedingRecordLocalModel object) {
  return [];
}

void _breedingRecordLocalModelAttach(
    IsarCollection<dynamic> col, Id id, BreedingRecordLocalModel object) {
  object.isarId = id;
}

extension BreedingRecordLocalModelByIndex
    on IsarCollection<BreedingRecordLocalModel> {
  Future<BreedingRecordLocalModel?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  BreedingRecordLocalModel? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<BreedingRecordLocalModel?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<BreedingRecordLocalModel?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(BreedingRecordLocalModel object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(BreedingRecordLocalModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<BreedingRecordLocalModel> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<BreedingRecordLocalModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension BreedingRecordLocalModelQueryWhereSort on QueryBuilder<
    BreedingRecordLocalModel, BreedingRecordLocalModel, QWhere> {
  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BreedingRecordLocalModelQueryWhere on QueryBuilder<
    BreedingRecordLocalModel, BreedingRecordLocalModel, QWhereClause> {
  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterWhereClause> isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterWhereClause> isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterWhereClause> orgIdEqualTo(String orgId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'orgId',
        value: [orgId],
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterWhereClause> damAnimalIdEqualTo(String damAnimalId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'damAnimalId',
        value: [damAnimalId],
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterWhereClause> damAnimalIdNotEqualTo(String damAnimalId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'damAnimalId',
              lower: [],
              upper: [damAnimalId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'damAnimalId',
              lower: [damAnimalId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'damAnimalId',
              lower: [damAnimalId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'damAnimalId',
              lower: [],
              upper: [damAnimalId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension BreedingRecordLocalModelQueryFilter on QueryBuilder<
    BreedingRecordLocalModel, BreedingRecordLocalModel, QFilterCondition> {
  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damAnimalIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'damAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damAnimalIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'damAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damAnimalIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'damAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damAnimalIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'damAnimalId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damAnimalIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'damAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damAnimalIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'damAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
          QAfterFilterCondition>
      damAnimalIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'damAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
          QAfterFilterCondition>
      damAnimalIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'damAnimalId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damAnimalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'damAnimalId',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damAnimalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'damAnimalId',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damSystemIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'damSystemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damSystemIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'damSystemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damSystemIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'damSystemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damSystemIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'damSystemId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damSystemIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'damSystemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damSystemIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'damSystemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
          QAfterFilterCondition>
      damSystemIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'damSystemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
          QAfterFilterCondition>
      damSystemIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'damSystemId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damSystemIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'damSystemId',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damSystemIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'damSystemId',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damTagDisplayEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'damTagDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damTagDisplayGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'damTagDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damTagDisplayLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'damTagDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damTagDisplayBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'damTagDisplay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damTagDisplayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'damTagDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damTagDisplayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'damTagDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
          QAfterFilterCondition>
      damTagDisplayContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'damTagDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
          QAfterFilterCondition>
      damTagDisplayMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'damTagDisplay',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damTagDisplayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'damTagDisplay',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> damTagDisplayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'damTagDisplay',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> deliveryDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deliveryDate',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> deliveryDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deliveryDate',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> deliveryDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> deliveryDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deliveryDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> deliveryDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deliveryDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> deliveryDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deliveryDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> deliveryDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deliveryDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> deliveryDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deliveryDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
          QAfterFilterCondition>
      deliveryDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deliveryDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
          QAfterFilterCondition>
      deliveryDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deliveryDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> deliveryDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryDate',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> deliveryDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deliveryDate',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> femalesBornIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'femalesBorn',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> femalesBornIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'femalesBorn',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> femalesBornEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'femalesBorn',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> femalesBornGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'femalesBorn',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> femalesBornLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'femalesBorn',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> femalesBornBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'femalesBorn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> isSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> malesBornIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'malesBorn',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> malesBornIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'malesBorn',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> malesBornEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'malesBorn',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> malesBornGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'malesBorn',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> malesBornLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'malesBorn',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> malesBornBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'malesBorn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> matingDateEqualTo(
    String value, {
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> matingDateGreaterThan(
    String value, {
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> matingDateLessThan(
    String value, {
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> matingDateBetween(
    String lower,
    String upper, {
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> matingDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matingDate',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> matingDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'matingDate',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> offspringCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'offspringCount',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> offspringCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'offspringCount',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> offspringCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'offspringCount',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> offspringCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'offspringCount',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> offspringCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'offspringCount',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> offspringCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'offspringCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> orgIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orgId',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> orgIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'orgId',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> pendingOperationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pendingOperation',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> pendingOperationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pendingOperation',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> pendingOperationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pendingOperation',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> pendingOperationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pendingOperation',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireAnimalIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sireAnimalId',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireAnimalIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sireAnimalId',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireAnimalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sireAnimalId',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireAnimalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sireAnimalId',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireSystemIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sireSystemId',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireSystemIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sireSystemId',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireSystemIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sireSystemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireSystemIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sireSystemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireSystemIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sireSystemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireSystemIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sireSystemId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireSystemIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sireSystemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireSystemIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sireSystemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
          QAfterFilterCondition>
      sireSystemIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sireSystemId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
          QAfterFilterCondition>
      sireSystemIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sireSystemId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireSystemIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sireSystemId',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireSystemIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sireSystemId',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireTagDisplayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sireTagDisplay',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireTagDisplayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sireTagDisplay',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireTagDisplayEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sireTagDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireTagDisplayGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sireTagDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireTagDisplayLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sireTagDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireTagDisplayBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sireTagDisplay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireTagDisplayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sireTagDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireTagDisplayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sireTagDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
          QAfterFilterCondition>
      sireTagDisplayContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sireTagDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
          QAfterFilterCondition>
      sireTagDisplayMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sireTagDisplay',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireTagDisplayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sireTagDisplay',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> sireTagDisplayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sireTagDisplay',
        value: '',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> survivingCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'survivingCount',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> survivingCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'survivingCount',
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> survivingCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'survivingCount',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> survivingCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'survivingCount',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> survivingCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'survivingCount',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> survivingCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'survivingCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
      QAfterFilterCondition> updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel,
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
}

extension BreedingRecordLocalModelQueryObject on QueryBuilder<
    BreedingRecordLocalModel, BreedingRecordLocalModel, QFilterCondition> {}

extension BreedingRecordLocalModelQueryLinks on QueryBuilder<
    BreedingRecordLocalModel, BreedingRecordLocalModel, QFilterCondition> {}

extension BreedingRecordLocalModelQuerySortBy on QueryBuilder<
    BreedingRecordLocalModel, BreedingRecordLocalModel, QSortBy> {
  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByDamAnimalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damAnimalId', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByDamAnimalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damAnimalId', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByDamSystemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damSystemId', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByDamSystemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damSystemId', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByDamTagDisplay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damTagDisplay', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByDamTagDisplayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damTagDisplay', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByDeliveryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDate', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByDeliveryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDate', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByFemalesBorn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'femalesBorn', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByFemalesBornDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'femalesBorn', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByMalesBorn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'malesBorn', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByMalesBornDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'malesBorn', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByMatingDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matingDate', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByMatingDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matingDate', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByOffspringCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'offspringCount', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByOffspringCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'offspringCount', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByOrgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByOrgIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByPendingOperation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByPendingOperationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortBySireAnimalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireAnimalId', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortBySireAnimalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireAnimalId', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortBySireSystemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireSystemId', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortBySireSystemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireSystemId', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortBySireTagDisplay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireTagDisplay', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortBySireTagDisplayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireTagDisplay', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortBySurvivingCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'survivingCount', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortBySurvivingCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'survivingCount', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension BreedingRecordLocalModelQuerySortThenBy on QueryBuilder<
    BreedingRecordLocalModel, BreedingRecordLocalModel, QSortThenBy> {
  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByDamAnimalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damAnimalId', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByDamAnimalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damAnimalId', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByDamSystemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damSystemId', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByDamSystemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damSystemId', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByDamTagDisplay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damTagDisplay', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByDamTagDisplayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damTagDisplay', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByDeliveryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDate', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByDeliveryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDate', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByFemalesBorn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'femalesBorn', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByFemalesBornDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'femalesBorn', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByMalesBorn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'malesBorn', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByMalesBornDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'malesBorn', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByMatingDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matingDate', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByMatingDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matingDate', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByOffspringCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'offspringCount', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByOffspringCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'offspringCount', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByOrgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByOrgIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByPendingOperation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByPendingOperationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenBySireAnimalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireAnimalId', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenBySireAnimalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireAnimalId', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenBySireSystemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireSystemId', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenBySireSystemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireSystemId', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenBySireTagDisplay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireTagDisplay', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenBySireTagDisplayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireTagDisplay', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenBySurvivingCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'survivingCount', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenBySurvivingCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'survivingCount', Sort.desc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension BreedingRecordLocalModelQueryWhereDistinct on QueryBuilder<
    BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct> {
  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctByDamAnimalId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'damAnimalId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctByDamSystemId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'damSystemId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctByDamTagDisplay({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'damTagDisplay',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctByDeliveryDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deliveryDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctByFemalesBorn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'femalesBorn');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctByMalesBorn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'malesBorn');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctByMatingDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'matingDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctByNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctByOffspringCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'offspringCount');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctByOrgId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orgId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctByPendingOperation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pendingOperation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctBySireAnimalId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sireAnimalId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctBySireSystemId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sireSystemId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctBySireTagDisplay({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sireTagDisplay',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctBySurvivingCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'survivingCount');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, BreedingRecordLocalModel, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension BreedingRecordLocalModelQueryProperty on QueryBuilder<
    BreedingRecordLocalModel, BreedingRecordLocalModel, QQueryProperty> {
  QueryBuilder<BreedingRecordLocalModel, int, QQueryOperations>
      isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, String, QQueryOperations>
      damAnimalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'damAnimalId');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, String, QQueryOperations>
      damSystemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'damSystemId');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, String, QQueryOperations>
      damTagDisplayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'damTagDisplay');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, String?, QQueryOperations>
      deliveryDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deliveryDate');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, int?, QQueryOperations>
      femalesBornProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'femalesBorn');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, String, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, bool, QQueryOperations>
      isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, int?, QQueryOperations>
      malesBornProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'malesBorn');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, String, QQueryOperations>
      matingDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'matingDate');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, String?, QQueryOperations>
      notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, int?, QQueryOperations>
      offspringCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'offspringCount');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, String, QQueryOperations>
      orgIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orgId');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, String?, QQueryOperations>
      pendingOperationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pendingOperation');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, String?, QQueryOperations>
      sireAnimalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sireAnimalId');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, String?, QQueryOperations>
      sireSystemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sireSystemId');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, String?, QQueryOperations>
      sireTagDisplayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sireTagDisplay');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, int?, QQueryOperations>
      survivingCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'survivingCount');
    });
  }

  QueryBuilder<BreedingRecordLocalModel, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
