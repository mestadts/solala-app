// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_local_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAnimalLocalModelCollection on Isar {
  IsarCollection<AnimalLocalModel> get animalLocalModels => this.collection();
}

const AnimalLocalModelSchema = CollectionSchema(
  name: r'AnimalLocalModel',
  id: 8451160611293076652,
  properties: {
    r'ageClassId': PropertySchema(
      id: 0,
      name: r'ageClassId',
      type: IsarType.string,
    ),
    r'breed': PropertySchema(
      id: 1,
      name: r'breed',
      type: IsarType.string,
    ),
    r'breederTag': PropertySchema(
      id: 2,
      name: r'breederTag',
      type: IsarType.string,
    ),
    r'colorId': PropertySchema(
      id: 3,
      name: r'colorId',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 4,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'customValuesJson': PropertySchema(
      id: 5,
      name: r'customValuesJson',
      type: IsarType.string,
    ),
    r'damId': PropertySchema(
      id: 6,
      name: r'damId',
      type: IsarType.string,
    ),
    r'dateOfBirth': PropertySchema(
      id: 7,
      name: r'dateOfBirth',
      type: IsarType.string,
    ),
    r'gender': PropertySchema(
      id: 8,
      name: r'gender',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 9,
      name: r'id',
      type: IsarType.string,
    ),
    r'isSynced': PropertySchema(
      id: 10,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 11,
      name: r'name',
      type: IsarType.string,
    ),
    r'officialTagNumber': PropertySchema(
      id: 12,
      name: r'officialTagNumber',
      type: IsarType.string,
    ),
    r'orgId': PropertySchema(
      id: 13,
      name: r'orgId',
      type: IsarType.string,
    ),
    r'penId': PropertySchema(
      id: 14,
      name: r'penId',
      type: IsarType.string,
    ),
    r'pendingOperation': PropertySchema(
      id: 15,
      name: r'pendingOperation',
      type: IsarType.string,
    ),
    r'photoUrl': PropertySchema(
      id: 16,
      name: r'photoUrl',
      type: IsarType.string,
    ),
    r'price': PropertySchema(
      id: 17,
      name: r'price',
      type: IsarType.double,
    ),
    r'purpose': PropertySchema(
      id: 18,
      name: r'purpose',
      type: IsarType.string,
    ),
    r'sireId': PropertySchema(
      id: 19,
      name: r'sireId',
      type: IsarType.string,
    ),
    r'species': PropertySchema(
      id: 20,
      name: r'species',
      type: IsarType.string,
    ),
    r'speciesAttributesJson': PropertySchema(
      id: 21,
      name: r'speciesAttributesJson',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 22,
      name: r'status',
      type: IsarType.string,
    ),
    r'systemAnimalId': PropertySchema(
      id: 23,
      name: r'systemAnimalId',
      type: IsarType.string,
    ),
    r'tagColorId': PropertySchema(
      id: 24,
      name: r'tagColorId',
      type: IsarType.string,
    ),
    r'tagNumber': PropertySchema(
      id: 25,
      name: r'tagNumber',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 26,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'weaningFromDays': PropertySchema(
      id: 27,
      name: r'weaningFromDays',
      type: IsarType.long,
    ),
    r'weaningToDays': PropertySchema(
      id: 28,
      name: r'weaningToDays',
      type: IsarType.long,
    ),
    r'weight': PropertySchema(
      id: 29,
      name: r'weight',
      type: IsarType.double,
    )
  },
  estimateSize: _animalLocalModelEstimateSize,
  serialize: _animalLocalModelSerialize,
  deserialize: _animalLocalModelDeserialize,
  deserializeProp: _animalLocalModelDeserializeProp,
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
    r'species': IndexSchema(
      id: 8973755993794745371,
      name: r'species',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'species',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _animalLocalModelGetId,
  getLinks: _animalLocalModelGetLinks,
  attach: _animalLocalModelAttach,
  version: '3.1.0+1',
);

int _animalLocalModelEstimateSize(
  AnimalLocalModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.ageClassId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.breed.length * 3;
  bytesCount += 3 + object.breederTag.length * 3;
  bytesCount += 3 + object.colorId.length * 3;
  {
    final value = object.customValuesJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.damId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.dateOfBirth.length * 3;
  bytesCount += 3 + object.gender.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.officialTagNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.orgId.length * 3;
  {
    final value = object.penId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pendingOperation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.photoUrl.length * 3;
  {
    final value = object.purpose;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sireId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.species.length * 3;
  bytesCount += 3 + object.speciesAttributesJson.length * 3;
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.systemAnimalId.length * 3;
  bytesCount += 3 + object.tagColorId.length * 3;
  return bytesCount;
}

void _animalLocalModelSerialize(
  AnimalLocalModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ageClassId);
  writer.writeString(offsets[1], object.breed);
  writer.writeString(offsets[2], object.breederTag);
  writer.writeString(offsets[3], object.colorId);
  writer.writeDateTime(offsets[4], object.createdAt);
  writer.writeString(offsets[5], object.customValuesJson);
  writer.writeString(offsets[6], object.damId);
  writer.writeString(offsets[7], object.dateOfBirth);
  writer.writeString(offsets[8], object.gender);
  writer.writeString(offsets[9], object.id);
  writer.writeBool(offsets[10], object.isSynced);
  writer.writeString(offsets[11], object.name);
  writer.writeString(offsets[12], object.officialTagNumber);
  writer.writeString(offsets[13], object.orgId);
  writer.writeString(offsets[14], object.penId);
  writer.writeString(offsets[15], object.pendingOperation);
  writer.writeString(offsets[16], object.photoUrl);
  writer.writeDouble(offsets[17], object.price);
  writer.writeString(offsets[18], object.purpose);
  writer.writeString(offsets[19], object.sireId);
  writer.writeString(offsets[20], object.species);
  writer.writeString(offsets[21], object.speciesAttributesJson);
  writer.writeString(offsets[22], object.status);
  writer.writeString(offsets[23], object.systemAnimalId);
  writer.writeString(offsets[24], object.tagColorId);
  writer.writeLong(offsets[25], object.tagNumber);
  writer.writeDateTime(offsets[26], object.updatedAt);
  writer.writeLong(offsets[27], object.weaningFromDays);
  writer.writeLong(offsets[28], object.weaningToDays);
  writer.writeDouble(offsets[29], object.weight);
}

AnimalLocalModel _animalLocalModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AnimalLocalModel();
  object.ageClassId = reader.readStringOrNull(offsets[0]);
  object.breed = reader.readString(offsets[1]);
  object.breederTag = reader.readString(offsets[2]);
  object.colorId = reader.readString(offsets[3]);
  object.createdAt = reader.readDateTime(offsets[4]);
  object.customValuesJson = reader.readStringOrNull(offsets[5]);
  object.damId = reader.readStringOrNull(offsets[6]);
  object.dateOfBirth = reader.readString(offsets[7]);
  object.gender = reader.readString(offsets[8]);
  object.id = reader.readString(offsets[9]);
  object.isSynced = reader.readBool(offsets[10]);
  object.isarId = id;
  object.name = reader.readString(offsets[11]);
  object.officialTagNumber = reader.readStringOrNull(offsets[12]);
  object.orgId = reader.readString(offsets[13]);
  object.penId = reader.readStringOrNull(offsets[14]);
  object.pendingOperation = reader.readStringOrNull(offsets[15]);
  object.photoUrl = reader.readString(offsets[16]);
  object.price = reader.readDoubleOrNull(offsets[17]);
  object.purpose = reader.readStringOrNull(offsets[18]);
  object.sireId = reader.readStringOrNull(offsets[19]);
  object.species = reader.readString(offsets[20]);
  object.speciesAttributesJson = reader.readString(offsets[21]);
  object.status = reader.readString(offsets[22]);
  object.systemAnimalId = reader.readString(offsets[23]);
  object.tagColorId = reader.readString(offsets[24]);
  object.tagNumber = reader.readLong(offsets[25]);
  object.updatedAt = reader.readDateTime(offsets[26]);
  object.weaningFromDays = reader.readLongOrNull(offsets[27]);
  object.weaningToDays = reader.readLongOrNull(offsets[28]);
  object.weight = reader.readDouble(offsets[29]);
  return object;
}

P _animalLocalModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readDoubleOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readString(offset)) as P;
    case 23:
      return (reader.readString(offset)) as P;
    case 24:
      return (reader.readString(offset)) as P;
    case 25:
      return (reader.readLong(offset)) as P;
    case 26:
      return (reader.readDateTime(offset)) as P;
    case 27:
      return (reader.readLongOrNull(offset)) as P;
    case 28:
      return (reader.readLongOrNull(offset)) as P;
    case 29:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _animalLocalModelGetId(AnimalLocalModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _animalLocalModelGetLinks(AnimalLocalModel object) {
  return [];
}

void _animalLocalModelAttach(
    IsarCollection<dynamic> col, Id id, AnimalLocalModel object) {
  object.isarId = id;
}

extension AnimalLocalModelByIndex on IsarCollection<AnimalLocalModel> {
  Future<AnimalLocalModel?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  AnimalLocalModel? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<AnimalLocalModel?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<AnimalLocalModel?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(AnimalLocalModel object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(AnimalLocalModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<AnimalLocalModel> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<AnimalLocalModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension AnimalLocalModelQueryWhereSort
    on QueryBuilder<AnimalLocalModel, AnimalLocalModel, QWhere> {
  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AnimalLocalModelQueryWhere
    on QueryBuilder<AnimalLocalModel, AnimalLocalModel, QWhereClause> {
  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterWhereClause>
      isarIdBetween(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterWhereClause> idEqualTo(
      String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterWhereClause>
      idNotEqualTo(String id) {
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterWhereClause>
      orgIdEqualTo(String orgId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'orgId',
        value: [orgId],
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterWhereClause>
      orgIdNotEqualTo(String orgId) {
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterWhereClause>
      speciesEqualTo(String species) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'species',
        value: [species],
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterWhereClause>
      speciesNotEqualTo(String species) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'species',
              lower: [],
              upper: [species],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'species',
              lower: [species],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'species',
              lower: [species],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'species',
              lower: [],
              upper: [species],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AnimalLocalModelQueryFilter
    on QueryBuilder<AnimalLocalModel, AnimalLocalModel, QFilterCondition> {
  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      ageClassIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ageClassId',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      ageClassIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ageClassId',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      ageClassIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ageClassId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      ageClassIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ageClassId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      ageClassIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ageClassId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      ageClassIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ageClassId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      ageClassIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ageClassId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      ageClassIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ageClassId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      ageClassIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ageClassId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      ageClassIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ageClassId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      ageClassIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ageClassId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      ageClassIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ageClassId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breedEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breedGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breedLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breedBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'breed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'breed',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breed',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'breed',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breederTagEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breederTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breederTagGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'breederTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breederTagLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'breederTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breederTagBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'breederTag',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breederTagStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'breederTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breederTagEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'breederTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breederTagContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'breederTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breederTagMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'breederTag',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breederTagIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breederTag',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      breederTagIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'breederTag',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      colorIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      colorIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'colorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      colorIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'colorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      colorIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'colorId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      colorIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'colorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      colorIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'colorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      colorIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'colorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      colorIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'colorId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      colorIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      colorIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'colorId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      createdAtGreaterThan(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      createdAtLessThan(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      createdAtBetween(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      customValuesJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customValuesJson',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      customValuesJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customValuesJson',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      customValuesJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customValuesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      customValuesJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customValuesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      customValuesJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customValuesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      customValuesJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customValuesJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      customValuesJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customValuesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      customValuesJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customValuesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      customValuesJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customValuesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      customValuesJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customValuesJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      customValuesJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customValuesJson',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      customValuesJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customValuesJson',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      damIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'damId',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      damIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'damId',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      damIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'damId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      damIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'damId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      damIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'damId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      damIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'damId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      damIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'damId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      damIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'damId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      damIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'damId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      damIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'damId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      damIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'damId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      damIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'damId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      dateOfBirthEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateOfBirth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      dateOfBirthGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateOfBirth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      dateOfBirthLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateOfBirth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      dateOfBirthBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateOfBirth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      dateOfBirthStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dateOfBirth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      dateOfBirthEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dateOfBirth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      dateOfBirthContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dateOfBirth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      dateOfBirthMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dateOfBirth',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      dateOfBirthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateOfBirth',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      dateOfBirthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateOfBirth',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      genderEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      genderGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      genderLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      genderBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gender',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      genderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      genderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      genderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      genderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gender',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      genderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gender',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      genderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gender',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      idEqualTo(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      idStartsWith(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      idEndsWith(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      isSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      isarIdGreaterThan(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      isarIdLessThan(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      isarIdBetween(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      officialTagNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'officialTagNumber',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      officialTagNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'officialTagNumber',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      officialTagNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'officialTagNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      officialTagNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'officialTagNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      officialTagNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'officialTagNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      officialTagNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'officialTagNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      officialTagNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'officialTagNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      officialTagNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'officialTagNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      officialTagNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'officialTagNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      officialTagNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'officialTagNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      officialTagNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'officialTagNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      officialTagNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'officialTagNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      orgIdEqualTo(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      orgIdGreaterThan(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      orgIdLessThan(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      orgIdBetween(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      orgIdStartsWith(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      orgIdEndsWith(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      orgIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'orgId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      orgIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'orgId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      orgIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orgId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      orgIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'orgId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      penIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'penId',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      penIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'penId',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      penIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'penId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      penIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'penId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      penIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'penId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      penIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'penId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      penIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'penId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      penIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'penId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      penIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'penId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      penIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'penId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      penIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'penId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      penIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'penId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      pendingOperationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pendingOperation',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      pendingOperationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pendingOperation',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      pendingOperationEqualTo(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      pendingOperationGreaterThan(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      pendingOperationLessThan(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      pendingOperationBetween(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      pendingOperationStartsWith(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      pendingOperationEndsWith(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      pendingOperationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pendingOperation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      pendingOperationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pendingOperation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      pendingOperationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pendingOperation',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      pendingOperationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pendingOperation',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      photoUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      photoUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      photoUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      photoUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      photoUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      photoUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      photoUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      photoUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      photoUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      photoUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      priceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      priceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      priceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      priceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      priceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      priceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      purposeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'purpose',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      purposeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'purpose',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      purposeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purpose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      purposeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'purpose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      purposeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'purpose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      purposeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'purpose',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      purposeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'purpose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      purposeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'purpose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      purposeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'purpose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      purposeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'purpose',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      purposeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purpose',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      purposeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'purpose',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      sireIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sireId',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      sireIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sireId',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      sireIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sireId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      sireIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sireId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      sireIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sireId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      sireIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sireId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      sireIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sireId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      sireIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sireId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      sireIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sireId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      sireIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sireId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      sireIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sireId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      sireIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sireId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'species',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'species',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'species',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'species',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'species',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'species',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'species',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'species',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'species',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'species',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesAttributesJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speciesAttributesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesAttributesJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'speciesAttributesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesAttributesJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'speciesAttributesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesAttributesJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'speciesAttributesJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesAttributesJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'speciesAttributesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesAttributesJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'speciesAttributesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesAttributesJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'speciesAttributesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesAttributesJsonMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'speciesAttributesJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesAttributesJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speciesAttributesJson',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      speciesAttributesJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'speciesAttributesJson',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      systemAnimalIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'systemAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      systemAnimalIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'systemAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      systemAnimalIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'systemAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      systemAnimalIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'systemAnimalId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      systemAnimalIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'systemAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      systemAnimalIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'systemAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      systemAnimalIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'systemAnimalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      systemAnimalIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'systemAnimalId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      systemAnimalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'systemAnimalId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      systemAnimalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'systemAnimalId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      tagColorIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagColorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      tagColorIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagColorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      tagColorIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagColorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      tagColorIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagColorId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      tagColorIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tagColorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      tagColorIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tagColorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      tagColorIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tagColorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      tagColorIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tagColorId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      tagColorIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagColorId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      tagColorIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tagColorId',
        value: '',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      tagNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      tagNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      tagNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      tagNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      updatedAtGreaterThan(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      updatedAtLessThan(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      updatedAtBetween(
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

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weaningFromDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weaningFromDays',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weaningFromDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weaningFromDays',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weaningFromDaysEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weaningFromDays',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weaningFromDaysGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weaningFromDays',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weaningFromDaysLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weaningFromDays',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weaningFromDaysBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weaningFromDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weaningToDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weaningToDays',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weaningToDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weaningToDays',
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weaningToDaysEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weaningToDays',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weaningToDaysGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weaningToDays',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weaningToDaysLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weaningToDays',
        value: value,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weaningToDaysBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weaningToDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterFilterCondition>
      weightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension AnimalLocalModelQueryObject
    on QueryBuilder<AnimalLocalModel, AnimalLocalModel, QFilterCondition> {}

extension AnimalLocalModelQueryLinks
    on QueryBuilder<AnimalLocalModel, AnimalLocalModel, QFilterCondition> {}

extension AnimalLocalModelQuerySortBy
    on QueryBuilder<AnimalLocalModel, AnimalLocalModel, QSortBy> {
  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByAgeClassId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ageClassId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByAgeClassIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ageClassId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy> sortByBreed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByBreedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByBreederTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breederTag', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByBreederTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breederTag', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByColorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByColorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByCustomValuesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customValuesJson', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByCustomValuesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customValuesJson', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy> sortByDamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByDamIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByDateOfBirth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByDateOfBirthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByOfficialTagNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officialTagNumber', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByOfficialTagNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officialTagNumber', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy> sortByOrgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByOrgIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy> sortByPenId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'penId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByPenIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'penId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByPendingOperation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByPendingOperationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByPhotoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByPhotoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByPurpose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purpose', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByPurposeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purpose', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortBySireId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortBySireIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortBySpecies() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'species', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortBySpeciesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'species', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortBySpeciesAttributesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesAttributesJson', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortBySpeciesAttributesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesAttributesJson', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortBySystemAnimalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systemAnimalId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortBySystemAnimalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systemAnimalId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByTagColorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColorId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByTagColorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColorId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByTagNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagNumber', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByTagNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagNumber', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByWeaningFromDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weaningFromDays', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByWeaningFromDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weaningFromDays', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByWeaningToDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weaningToDays', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByWeaningToDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weaningToDays', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      sortByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension AnimalLocalModelQuerySortThenBy
    on QueryBuilder<AnimalLocalModel, AnimalLocalModel, QSortThenBy> {
  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByAgeClassId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ageClassId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByAgeClassIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ageClassId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy> thenByBreed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByBreedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByBreederTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breederTag', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByBreederTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breederTag', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByColorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByColorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByCustomValuesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customValuesJson', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByCustomValuesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customValuesJson', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy> thenByDamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByDamIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'damId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByDateOfBirth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByDateOfBirthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByOfficialTagNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officialTagNumber', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByOfficialTagNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officialTagNumber', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy> thenByOrgId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByOrgIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orgId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy> thenByPenId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'penId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByPenIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'penId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByPendingOperation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByPendingOperationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingOperation', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByPhotoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByPhotoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByPurpose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purpose', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByPurposeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purpose', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenBySireId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenBySireIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sireId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenBySpecies() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'species', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenBySpeciesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'species', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenBySpeciesAttributesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesAttributesJson', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenBySpeciesAttributesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesAttributesJson', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenBySystemAnimalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systemAnimalId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenBySystemAnimalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'systemAnimalId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByTagColorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColorId', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByTagColorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagColorId', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByTagNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagNumber', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByTagNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagNumber', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByWeaningFromDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weaningFromDays', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByWeaningFromDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weaningFromDays', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByWeaningToDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weaningToDays', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByWeaningToDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weaningToDays', Sort.desc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QAfterSortBy>
      thenByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension AnimalLocalModelQueryWhereDistinct
    on QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct> {
  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByAgeClassId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ageClassId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct> distinctByBreed(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breed', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByBreederTag({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breederTag', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct> distinctByColorId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByCustomValuesJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customValuesJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct> distinctByDamId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'damId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByDateOfBirth({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateOfBirth', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct> distinctByGender(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gender', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByOfficialTagNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'officialTagNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct> distinctByOrgId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orgId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct> distinctByPenId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'penId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByPendingOperation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pendingOperation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByPhotoUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct> distinctByPurpose(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'purpose', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct> distinctBySireId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sireId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct> distinctBySpecies(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'species', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctBySpeciesAttributesJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'speciesAttributesJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctBySystemAnimalId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'systemAnimalId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByTagColorId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagColorId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByTagNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagNumber');
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByWeaningFromDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weaningFromDays');
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByWeaningToDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weaningToDays');
    });
  }

  QueryBuilder<AnimalLocalModel, AnimalLocalModel, QDistinct>
      distinctByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weight');
    });
  }
}

extension AnimalLocalModelQueryProperty
    on QueryBuilder<AnimalLocalModel, AnimalLocalModel, QQueryProperty> {
  QueryBuilder<AnimalLocalModel, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<AnimalLocalModel, String?, QQueryOperations>
      ageClassIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ageClassId');
    });
  }

  QueryBuilder<AnimalLocalModel, String, QQueryOperations> breedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breed');
    });
  }

  QueryBuilder<AnimalLocalModel, String, QQueryOperations>
      breederTagProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breederTag');
    });
  }

  QueryBuilder<AnimalLocalModel, String, QQueryOperations> colorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorId');
    });
  }

  QueryBuilder<AnimalLocalModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<AnimalLocalModel, String?, QQueryOperations>
      customValuesJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customValuesJson');
    });
  }

  QueryBuilder<AnimalLocalModel, String?, QQueryOperations> damIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'damId');
    });
  }

  QueryBuilder<AnimalLocalModel, String, QQueryOperations>
      dateOfBirthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateOfBirth');
    });
  }

  QueryBuilder<AnimalLocalModel, String, QQueryOperations> genderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gender');
    });
  }

  QueryBuilder<AnimalLocalModel, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AnimalLocalModel, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<AnimalLocalModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<AnimalLocalModel, String?, QQueryOperations>
      officialTagNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'officialTagNumber');
    });
  }

  QueryBuilder<AnimalLocalModel, String, QQueryOperations> orgIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orgId');
    });
  }

  QueryBuilder<AnimalLocalModel, String?, QQueryOperations> penIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'penId');
    });
  }

  QueryBuilder<AnimalLocalModel, String?, QQueryOperations>
      pendingOperationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pendingOperation');
    });
  }

  QueryBuilder<AnimalLocalModel, String, QQueryOperations> photoUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoUrl');
    });
  }

  QueryBuilder<AnimalLocalModel, double?, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<AnimalLocalModel, String?, QQueryOperations> purposeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'purpose');
    });
  }

  QueryBuilder<AnimalLocalModel, String?, QQueryOperations> sireIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sireId');
    });
  }

  QueryBuilder<AnimalLocalModel, String, QQueryOperations> speciesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'species');
    });
  }

  QueryBuilder<AnimalLocalModel, String, QQueryOperations>
      speciesAttributesJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'speciesAttributesJson');
    });
  }

  QueryBuilder<AnimalLocalModel, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<AnimalLocalModel, String, QQueryOperations>
      systemAnimalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'systemAnimalId');
    });
  }

  QueryBuilder<AnimalLocalModel, String, QQueryOperations>
      tagColorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagColorId');
    });
  }

  QueryBuilder<AnimalLocalModel, int, QQueryOperations> tagNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagNumber');
    });
  }

  QueryBuilder<AnimalLocalModel, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<AnimalLocalModel, int?, QQueryOperations>
      weaningFromDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weaningFromDays');
    });
  }

  QueryBuilder<AnimalLocalModel, int?, QQueryOperations>
      weaningToDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weaningToDays');
    });
  }

  QueryBuilder<AnimalLocalModel, double, QQueryOperations> weightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weight');
    });
  }
}
