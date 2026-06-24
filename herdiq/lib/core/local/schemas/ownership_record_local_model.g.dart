// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ownership_record_local_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOwnershipRecordLocalModelCollection on Isar {
  IsarCollection<OwnershipRecordLocalModel> get ownershipRecordLocalModels =>
      this.collection();
}

const OwnershipRecordLocalModelSchema = CollectionSchema(
  name: r'OwnershipRecordLocalModel',
  id: 8328055551361075442,
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
    r'currency': PropertySchema(
      id: 2,
      name: r'currency',
      type: IsarType.string,
    ),
    r'documentUrl': PropertySchema(
      id: 3,
      name: r'documentUrl',
      type: IsarType.string,
    ),
    r'fromOwnerId': PropertySchema(
      id: 4,
      name: r'fromOwnerId',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 5,
      name: r'id',
      type: IsarType.string,
    ),
    r'isSynced': PropertySchema(
      id: 6,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'notes': PropertySchema(
      id: 7,
      name: r'notes',
      type: IsarType.string,
    ),
    r'orgId': PropertySchema(
      id: 8,
      name: r'orgId',
      type: IsarType.string,
    ),
    r'pendingOperation': PropertySchema(
      id: 9,
      name: r'pendingOperation',
      type: IsarType.string,
    ),
    r'salePrice': PropertySchema(
      id: 10,
      name: r'salePrice',
      type: IsarType.double,
    ),
    r'toOwnerId': PropertySchema(
      id: 11,
      name: r'toOwnerId',
      type: IsarType.string,
    ),
    r'toOwnerName': PropertySchema(
      id: 12,
      name: r'toOwnerName',
      type: IsarType.string,
    ),
    r'toOwnerPhone': PropertySchema(
      id: 13,
      name: r'toOwnerPhone',
      type: IsarType.string,
    ),
    r'transferDate': PropertySchema(
      id: 14,
      name: r'transferDate',
      type: IsarType.string,
    ),
    r'transferType': PropertySchema(
      id: 15,
      name: r'transferType',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 16,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _ownershipRecordLocalModelEstimateSize,
  serialize: _ownershipRecordLocalModelSerialize,
  deserialize: _ownershipRecordLocalModelDeserialize,
  deserializeProp: _ownershipRecordLocalModelDeserializeProp,
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
  getId: _ownershipRecordLocalModelGetId,
  getLinks: _ownershipRecordLocalModelGetLinks,
  attach: _ownershipRecordLocalModelAttach,
  version: '3.1.0+1',
);

int _ownershipRecordLocalModelEstimateSize(
  OwnershipRecordLocalModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.animalId.length * 3;
  {
    final value = object.currency;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.documentUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.fromOwnerId.length * 3;
  bytesCount += 3 + object.id.length * 3;
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
  bytesCount += 3 + object.toOwnerId.length * 3;
  bytesCount += 3 + object.toOwnerName.length * 3;
  bytesCount += 3 + object.toOwnerPhone.length * 3;
  bytesCount += 3 + object.transferDate.length * 3;
  bytesCount += 3 + object.transferType.length * 3;
  return bytesCount;
}

void _ownershipRecordLocalModelSerialize(
  OwnershipRecordLocalModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.animalId);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.currency);
  writer.writeString(offsets[3], object.documentUrl);
  writer.writeString(offsets[4], object.fromOwnerId);
  writer.writeString(offsets[5], object.id);
  writer.writeBool(offsets[6], object.isSynced);
  writer.writeString(offsets[7], object.notes);
  writer.writeString(offsets[8], object.orgId);
  writer.writeString(offsets[9], object.pendingOperation);
  writer.writeDouble(offsets[10], object.salePrice);
  writer.writeString(offsets[11], object.toOwnerId);
  writer.writeString(offsets[12], object.toOwnerName);
  writer.writeString(offsets[13], object.toOwnerPhone);
  writer.writeString(offsets[14], object.transferDate);
  writer.writeString(offsets[15], object.transferType);
  writer.writeDateTime(offsets[16], object.updatedAt);
}

OwnershipRecordLocalModel _ownershipRecordLocalModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OwnershipRecordLocalModel();
  object.animalId = reader.readString(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.currency = reader.readStringOrNull(offsets[2]);
  object.documentUrl = reader.readStringOrNull(offsets[3]);
  object.fromOwnerId = reader.readString(offsets[4]);
  object.id = reader.readString(offsets[5]);
  object.isSynced = reader.readBool(offsets[6]);
  object.isarId = id;
  object.notes = reader.readStringOrNull(offsets[7]);
  object.orgId = reader.readString(offsets[8]);
  object.pendingOperation = reader.readStringOrNull(offsets[9]);
  object.salePrice = reader.readDoubleOrNull(offsets[10]);
  object.toOwnerId = reader.readString(offsets[11]);
  object.toOwnerName = reader.readString(offsets[12]);
  object.toOwnerPhone = reader.readString(offsets[13]);
  object.transferDate = reader.readString(offsets[14]);
  object.transferType = reader.readString(offsets[15]);
  object.updatedAt = reader.readDateTime(offsets[16]);
  return object;
}

P _ownershipRecordLocalModelDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _ownershipRecordLocalModelGetId(OwnershipRecordLocalModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _ownershipRecordLocalModelGetLinks(
    OwnershipRecordLocalModel object) {
  return [];
}

void _ownershipRecordLocalModelAttach(
    IsarCollection<dynamic> col, Id id, OwnershipRecordLocalModel object) {
  object.isarId = id;
}

extension OwnershipRecordLocalModelByIndex
    on IsarCollection<OwnershipRecordLocalModel> {
  Future<OwnershipRecordLocalModel?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  OwnershipRecordLocalModel? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<OwnershipRecordLocalModel?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<OwnershipRecordLocalModel?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(OwnershipRecordLocalModel object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(OwnershipRecordLocalModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<OwnershipRecordLocalModel> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<OwnershipRecordLocalModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension OwnershipRecordLocalModelQueryWhereSort on QueryBuilder<
    OwnershipRecordLocalModel, OwnershipRecordLocalModel, QWhere> {
  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OwnershipRecordLocalModelQueryWhere on QueryBuilder<
    OwnershipRecordLocalModel, OwnershipRecordLocalModel, QWhereClause> {
  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterWhereClause> isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterWhereClause> isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterWhereClause> animalIdEqualTo(String animalId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'animalId',
        value: [animalId],
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterWhereClause> orgIdEqualTo(String orgId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'orgId',
        value: [orgId],
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

extension OwnershipRecordLocalModelQueryFilter on QueryBuilder<
    OwnershipRecordLocalModel, OwnershipRecordLocalModel, QFilterCondition> {
  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> animalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'animalId',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> animalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'animalId',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> currencyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currency',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> currencyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currency',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> currencyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> currencyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> currencyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> currencyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> currencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> currencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      currencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> documentUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'documentUrl',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> documentUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'documentUrl',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> documentUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> documentUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'documentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> documentUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'documentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> documentUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'documentUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> documentUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'documentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> documentUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'documentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      documentUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'documentUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      documentUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'documentUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> documentUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> documentUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'documentUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> fromOwnerIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> fromOwnerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fromOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> fromOwnerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fromOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> fromOwnerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fromOwnerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> fromOwnerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fromOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> fromOwnerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fromOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      fromOwnerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fromOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      fromOwnerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fromOwnerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> fromOwnerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromOwnerId',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> fromOwnerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fromOwnerId',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> isSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> orgIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orgId',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> orgIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'orgId',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> pendingOperationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pendingOperation',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> pendingOperationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pendingOperation',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> pendingOperationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pendingOperation',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> pendingOperationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pendingOperation',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> salePriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'salePrice',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> salePriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'salePrice',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> salePriceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'salePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> salePriceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'salePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> salePriceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'salePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> salePriceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'salePrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toOwnerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'toOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'toOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      toOwnerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      toOwnerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toOwnerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toOwnerId',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toOwnerId',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toOwnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toOwnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toOwnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toOwnerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'toOwnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'toOwnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      toOwnerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toOwnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      toOwnerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toOwnerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toOwnerName',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toOwnerName',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerPhoneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toOwnerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerPhoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toOwnerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerPhoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toOwnerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerPhoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toOwnerPhone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerPhoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'toOwnerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerPhoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'toOwnerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      toOwnerPhoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toOwnerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      toOwnerPhoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toOwnerPhone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerPhoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toOwnerPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> toOwnerPhoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toOwnerPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transferDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transferDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transferDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transferDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'transferDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'transferDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      transferDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'transferDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      transferDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'transferDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transferDate',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'transferDate',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transferType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transferType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transferType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transferType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'transferType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'transferType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      transferTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'transferType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
          QAfterFilterCondition>
      transferTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'transferType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transferType',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> transferTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'transferType',
        value: '',
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterFilterCondition> updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
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

extension OwnershipRecordLocalModelQueryObject on QueryBuilder<
    OwnershipRecordLocalModel, OwnershipRecordLocalModel, QFilterCondition> {}

extension OwnershipRecordLocalModelQueryLinks on QueryBuilder<
    OwnershipRecordLocalModel, OwnershipRecordLocalModel, QFilterCondition> {}

extension OwnershipRecordLocalModelQuerySortBy on QueryBuilder<
    OwnershipRecordLocalModel, OwnershipRecordLocalModel, QSortBy> {
  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByAnimalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalId', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByAnimalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalId', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByDocumentUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentUrl', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByDocumentUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentUrl', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByFromOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromOwnerId', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByFromOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromOwnerId', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByOrgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByOrgIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByPendingOperation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByPendingOperationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortBySalePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salePrice', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortBySalePriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salePrice', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByToOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toOwnerId', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByToOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toOwnerId', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByToOwnerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toOwnerName', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByToOwnerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toOwnerName', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByToOwnerPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toOwnerPhone', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByToOwnerPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toOwnerPhone', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByTransferDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferDate', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByTransferDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferDate', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByTransferType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferType', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByTransferTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferType', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension OwnershipRecordLocalModelQuerySortThenBy on QueryBuilder<
    OwnershipRecordLocalModel, OwnershipRecordLocalModel, QSortThenBy> {
  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByAnimalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalId', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByAnimalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animalId', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByDocumentUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentUrl', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByDocumentUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentUrl', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByFromOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromOwnerId', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByFromOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromOwnerId', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByOrgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByOrgIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByPendingOperation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByPendingOperationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenBySalePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salePrice', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenBySalePriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salePrice', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByToOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toOwnerId', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByToOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toOwnerId', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByToOwnerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toOwnerName', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByToOwnerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toOwnerName', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByToOwnerPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toOwnerPhone', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByToOwnerPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toOwnerPhone', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByTransferDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferDate', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByTransferDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferDate', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByTransferType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferType', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByTransferTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transferType', Sort.desc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel,
      QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension OwnershipRecordLocalModelQueryWhereDistinct on QueryBuilder<
    OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct> {
  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByAnimalId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'animalId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByCurrency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByDocumentUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'documentUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByFromOwnerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromOwnerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByOrgId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orgId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByPendingOperation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pendingOperation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctBySalePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'salePrice');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByToOwnerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toOwnerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByToOwnerName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toOwnerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByToOwnerPhone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toOwnerPhone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByTransferDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transferDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByTransferType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transferType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, OwnershipRecordLocalModel, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension OwnershipRecordLocalModelQueryProperty on QueryBuilder<
    OwnershipRecordLocalModel, OwnershipRecordLocalModel, QQueryProperty> {
  QueryBuilder<OwnershipRecordLocalModel, int, QQueryOperations>
      isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, String, QQueryOperations>
      animalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'animalId');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, String?, QQueryOperations>
      currencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currency');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, String?, QQueryOperations>
      documentUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'documentUrl');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, String, QQueryOperations>
      fromOwnerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromOwnerId');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, String, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, bool, QQueryOperations>
      isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, String?, QQueryOperations>
      notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, String, QQueryOperations>
      orgIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orgId');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, String?, QQueryOperations>
      pendingOperationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pendingOperation');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, double?, QQueryOperations>
      salePriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'salePrice');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, String, QQueryOperations>
      toOwnerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toOwnerId');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, String, QQueryOperations>
      toOwnerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toOwnerName');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, String, QQueryOperations>
      toOwnerPhoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toOwnerPhone');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, String, QQueryOperations>
      transferDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transferDate');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, String, QQueryOperations>
      transferTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transferType');
    });
  }

  QueryBuilder<OwnershipRecordLocalModel, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
