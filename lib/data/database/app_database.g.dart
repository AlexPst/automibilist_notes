// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CarsTable extends Cars with TableInfo<$CarsTable, CarRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CarsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plateNumberMeta = const VerificationMeta(
    'plateNumber',
  );
  @override
  late final GeneratedColumn<String> plateNumber = GeneratedColumn<String>(
    'plate_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<FuelType, String> fuelType =
      GeneratedColumn<String>(
        'fuel_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FuelType>($CarsTable.$converterfuelType);
  static const VerificationMeta _tankVolumeMeta = const VerificationMeta(
    'tankVolume',
  );
  @override
  late final GeneratedColumn<double> tankVolume = GeneratedColumn<double>(
    'tank_volume',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _initialMileageMeta = const VerificationMeta(
    'initialMileage',
  );
  @override
  late final GeneratedColumn<int> initialMileage = GeneratedColumn<int>(
    'initial_mileage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoFileNameMeta = const VerificationMeta(
    'photoFileName',
  );
  @override
  late final GeneratedColumn<String> photoFileName = GeneratedColumn<String>(
    'photo_file_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    brand,
    model,
    year,
    plateNumber,
    fuelType,
    tankVolume,
    initialMileage,
    photoFileName,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cars';
  @override
  VerificationContext validateIntegrity(
    Insertable<CarRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    }
    if (data.containsKey('plate_number')) {
      context.handle(
        _plateNumberMeta,
        plateNumber.isAcceptableOrUnknown(
          data['plate_number']!,
          _plateNumberMeta,
        ),
      );
    }
    if (data.containsKey('tank_volume')) {
      context.handle(
        _tankVolumeMeta,
        tankVolume.isAcceptableOrUnknown(data['tank_volume']!, _tankVolumeMeta),
      );
    }
    if (data.containsKey('initial_mileage')) {
      context.handle(
        _initialMileageMeta,
        initialMileage.isAcceptableOrUnknown(
          data['initial_mileage']!,
          _initialMileageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_initialMileageMeta);
    }
    if (data.containsKey('photo_file_name')) {
      context.handle(
        _photoFileNameMeta,
        photoFileName.isAcceptableOrUnknown(
          data['photo_file_name']!,
          _photoFileNameMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CarRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CarRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      ),
      plateNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plate_number'],
      ),
      fuelType: $CarsTable.$converterfuelType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fuel_type'],
        )!,
      ),
      tankVolume: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tank_volume'],
      ),
      initialMileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}initial_mileage'],
      )!,
      photoFileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_file_name'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CarsTable createAlias(String alias) {
    return $CarsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FuelType, String, String> $converterfuelType =
      const EnumNameConverter<FuelType>(FuelType.values);
}

class CarRecord extends DataClass implements Insertable<CarRecord> {
  final int id;
  final String brand;
  final String model;
  final int? year;
  final String? plateNumber;
  final FuelType fuelType;

  /// Объём бака, л.
  final double? tankVolume;

  /// Начальный пробег, км.
  final int initialMileage;

  /// Имя файла фото в папке фотографий приложения.
  final String? photoFileName;
  final DateTime createdAt;
  const CarRecord({
    required this.id,
    required this.brand,
    required this.model,
    this.year,
    this.plateNumber,
    required this.fuelType,
    this.tankVolume,
    required this.initialMileage,
    this.photoFileName,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['brand'] = Variable<String>(brand);
    map['model'] = Variable<String>(model);
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
    }
    if (!nullToAbsent || plateNumber != null) {
      map['plate_number'] = Variable<String>(plateNumber);
    }
    {
      map['fuel_type'] = Variable<String>(
        $CarsTable.$converterfuelType.toSql(fuelType),
      );
    }
    if (!nullToAbsent || tankVolume != null) {
      map['tank_volume'] = Variable<double>(tankVolume);
    }
    map['initial_mileage'] = Variable<int>(initialMileage);
    if (!nullToAbsent || photoFileName != null) {
      map['photo_file_name'] = Variable<String>(photoFileName);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CarsCompanion toCompanion(bool nullToAbsent) {
    return CarsCompanion(
      id: Value(id),
      brand: Value(brand),
      model: Value(model),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      plateNumber: plateNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(plateNumber),
      fuelType: Value(fuelType),
      tankVolume: tankVolume == null && nullToAbsent
          ? const Value.absent()
          : Value(tankVolume),
      initialMileage: Value(initialMileage),
      photoFileName: photoFileName == null && nullToAbsent
          ? const Value.absent()
          : Value(photoFileName),
      createdAt: Value(createdAt),
    );
  }

  factory CarRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CarRecord(
      id: serializer.fromJson<int>(json['id']),
      brand: serializer.fromJson<String>(json['brand']),
      model: serializer.fromJson<String>(json['model']),
      year: serializer.fromJson<int?>(json['year']),
      plateNumber: serializer.fromJson<String?>(json['plateNumber']),
      fuelType: $CarsTable.$converterfuelType.fromJson(
        serializer.fromJson<String>(json['fuelType']),
      ),
      tankVolume: serializer.fromJson<double?>(json['tankVolume']),
      initialMileage: serializer.fromJson<int>(json['initialMileage']),
      photoFileName: serializer.fromJson<String?>(json['photoFileName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'brand': serializer.toJson<String>(brand),
      'model': serializer.toJson<String>(model),
      'year': serializer.toJson<int?>(year),
      'plateNumber': serializer.toJson<String?>(plateNumber),
      'fuelType': serializer.toJson<String>(
        $CarsTable.$converterfuelType.toJson(fuelType),
      ),
      'tankVolume': serializer.toJson<double?>(tankVolume),
      'initialMileage': serializer.toJson<int>(initialMileage),
      'photoFileName': serializer.toJson<String?>(photoFileName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CarRecord copyWith({
    int? id,
    String? brand,
    String? model,
    Value<int?> year = const Value.absent(),
    Value<String?> plateNumber = const Value.absent(),
    FuelType? fuelType,
    Value<double?> tankVolume = const Value.absent(),
    int? initialMileage,
    Value<String?> photoFileName = const Value.absent(),
    DateTime? createdAt,
  }) => CarRecord(
    id: id ?? this.id,
    brand: brand ?? this.brand,
    model: model ?? this.model,
    year: year.present ? year.value : this.year,
    plateNumber: plateNumber.present ? plateNumber.value : this.plateNumber,
    fuelType: fuelType ?? this.fuelType,
    tankVolume: tankVolume.present ? tankVolume.value : this.tankVolume,
    initialMileage: initialMileage ?? this.initialMileage,
    photoFileName: photoFileName.present
        ? photoFileName.value
        : this.photoFileName,
    createdAt: createdAt ?? this.createdAt,
  );
  CarRecord copyWithCompanion(CarsCompanion data) {
    return CarRecord(
      id: data.id.present ? data.id.value : this.id,
      brand: data.brand.present ? data.brand.value : this.brand,
      model: data.model.present ? data.model.value : this.model,
      year: data.year.present ? data.year.value : this.year,
      plateNumber: data.plateNumber.present
          ? data.plateNumber.value
          : this.plateNumber,
      fuelType: data.fuelType.present ? data.fuelType.value : this.fuelType,
      tankVolume: data.tankVolume.present
          ? data.tankVolume.value
          : this.tankVolume,
      initialMileage: data.initialMileage.present
          ? data.initialMileage.value
          : this.initialMileage,
      photoFileName: data.photoFileName.present
          ? data.photoFileName.value
          : this.photoFileName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CarRecord(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('plateNumber: $plateNumber, ')
          ..write('fuelType: $fuelType, ')
          ..write('tankVolume: $tankVolume, ')
          ..write('initialMileage: $initialMileage, ')
          ..write('photoFileName: $photoFileName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    brand,
    model,
    year,
    plateNumber,
    fuelType,
    tankVolume,
    initialMileage,
    photoFileName,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CarRecord &&
          other.id == this.id &&
          other.brand == this.brand &&
          other.model == this.model &&
          other.year == this.year &&
          other.plateNumber == this.plateNumber &&
          other.fuelType == this.fuelType &&
          other.tankVolume == this.tankVolume &&
          other.initialMileage == this.initialMileage &&
          other.photoFileName == this.photoFileName &&
          other.createdAt == this.createdAt);
}

class CarsCompanion extends UpdateCompanion<CarRecord> {
  final Value<int> id;
  final Value<String> brand;
  final Value<String> model;
  final Value<int?> year;
  final Value<String?> plateNumber;
  final Value<FuelType> fuelType;
  final Value<double?> tankVolume;
  final Value<int> initialMileage;
  final Value<String?> photoFileName;
  final Value<DateTime> createdAt;
  const CarsCompanion({
    this.id = const Value.absent(),
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.year = const Value.absent(),
    this.plateNumber = const Value.absent(),
    this.fuelType = const Value.absent(),
    this.tankVolume = const Value.absent(),
    this.initialMileage = const Value.absent(),
    this.photoFileName = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CarsCompanion.insert({
    this.id = const Value.absent(),
    required String brand,
    required String model,
    this.year = const Value.absent(),
    this.plateNumber = const Value.absent(),
    required FuelType fuelType,
    this.tankVolume = const Value.absent(),
    required int initialMileage,
    this.photoFileName = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : brand = Value(brand),
       model = Value(model),
       fuelType = Value(fuelType),
       initialMileage = Value(initialMileage);
  static Insertable<CarRecord> custom({
    Expression<int>? id,
    Expression<String>? brand,
    Expression<String>? model,
    Expression<int>? year,
    Expression<String>? plateNumber,
    Expression<String>? fuelType,
    Expression<double>? tankVolume,
    Expression<int>? initialMileage,
    Expression<String>? photoFileName,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (brand != null) 'brand': brand,
      if (model != null) 'model': model,
      if (year != null) 'year': year,
      if (plateNumber != null) 'plate_number': plateNumber,
      if (fuelType != null) 'fuel_type': fuelType,
      if (tankVolume != null) 'tank_volume': tankVolume,
      if (initialMileage != null) 'initial_mileage': initialMileage,
      if (photoFileName != null) 'photo_file_name': photoFileName,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CarsCompanion copyWith({
    Value<int>? id,
    Value<String>? brand,
    Value<String>? model,
    Value<int?>? year,
    Value<String?>? plateNumber,
    Value<FuelType>? fuelType,
    Value<double?>? tankVolume,
    Value<int>? initialMileage,
    Value<String?>? photoFileName,
    Value<DateTime>? createdAt,
  }) {
    return CarsCompanion(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      plateNumber: plateNumber ?? this.plateNumber,
      fuelType: fuelType ?? this.fuelType,
      tankVolume: tankVolume ?? this.tankVolume,
      initialMileage: initialMileage ?? this.initialMileage,
      photoFileName: photoFileName ?? this.photoFileName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (plateNumber.present) {
      map['plate_number'] = Variable<String>(plateNumber.value);
    }
    if (fuelType.present) {
      map['fuel_type'] = Variable<String>(
        $CarsTable.$converterfuelType.toSql(fuelType.value),
      );
    }
    if (tankVolume.present) {
      map['tank_volume'] = Variable<double>(tankVolume.value);
    }
    if (initialMileage.present) {
      map['initial_mileage'] = Variable<int>(initialMileage.value);
    }
    if (photoFileName.present) {
      map['photo_file_name'] = Variable<String>(photoFileName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CarsCompanion(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('plateNumber: $plateNumber, ')
          ..write('fuelType: $fuelType, ')
          ..write('tankVolume: $tankVolume, ')
          ..write('initialMileage: $initialMileage, ')
          ..write('photoFileName: $photoFileName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FuelEntriesTable extends FuelEntries
    with TableInfo<$FuelEntriesTable, FuelEntryRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FuelEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _carIdMeta = const VerificationMeta('carId');
  @override
  late final GeneratedColumn<int> carId = GeneratedColumn<int>(
    'car_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cars (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mileageMeta = const VerificationMeta(
    'mileage',
  );
  @override
  late final GeneratedColumn<int> mileage = GeneratedColumn<int>(
    'mileage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _litersMeta = const VerificationMeta('liters');
  @override
  late final GeneratedColumn<double> liters = GeneratedColumn<double>(
    'liters',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pricePerLiterMeta = const VerificationMeta(
    'pricePerLiter',
  );
  @override
  late final GeneratedColumn<double> pricePerLiter = GeneratedColumn<double>(
    'price_per_liter',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCostMeta = const VerificationMeta(
    'totalCost',
  );
  @override
  late final GeneratedColumn<double> totalCost = GeneratedColumn<double>(
    'total_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFullTankMeta = const VerificationMeta(
    'isFullTank',
  );
  @override
  late final GeneratedColumn<bool> isFullTank = GeneratedColumn<bool>(
    'is_full_tank',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_full_tank" IN (0, 1))',
    ),
  );
  static const VerificationMeta _stationMeta = const VerificationMeta(
    'station',
  );
  @override
  late final GeneratedColumn<String> station = GeneratedColumn<String>(
    'station',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    carId,
    date,
    mileage,
    liters,
    pricePerLiter,
    totalCost,
    isFullTank,
    station,
    comment,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fuel_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<FuelEntryRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('car_id')) {
      context.handle(
        _carIdMeta,
        carId.isAcceptableOrUnknown(data['car_id']!, _carIdMeta),
      );
    } else if (isInserting) {
      context.missing(_carIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('mileage')) {
      context.handle(
        _mileageMeta,
        mileage.isAcceptableOrUnknown(data['mileage']!, _mileageMeta),
      );
    } else if (isInserting) {
      context.missing(_mileageMeta);
    }
    if (data.containsKey('liters')) {
      context.handle(
        _litersMeta,
        liters.isAcceptableOrUnknown(data['liters']!, _litersMeta),
      );
    } else if (isInserting) {
      context.missing(_litersMeta);
    }
    if (data.containsKey('price_per_liter')) {
      context.handle(
        _pricePerLiterMeta,
        pricePerLiter.isAcceptableOrUnknown(
          data['price_per_liter']!,
          _pricePerLiterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pricePerLiterMeta);
    }
    if (data.containsKey('total_cost')) {
      context.handle(
        _totalCostMeta,
        totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCostMeta);
    }
    if (data.containsKey('is_full_tank')) {
      context.handle(
        _isFullTankMeta,
        isFullTank.isAcceptableOrUnknown(
          data['is_full_tank']!,
          _isFullTankMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isFullTankMeta);
    }
    if (data.containsKey('station')) {
      context.handle(
        _stationMeta,
        station.isAcceptableOrUnknown(data['station']!, _stationMeta),
      );
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FuelEntryRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FuelEntryRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      carId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}car_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      mileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mileage'],
      )!,
      liters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}liters'],
      )!,
      pricePerLiter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_per_liter'],
      )!,
      totalCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_cost'],
      )!,
      isFullTank: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_full_tank'],
      )!,
      station: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}station'],
      ),
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
    );
  }

  @override
  $FuelEntriesTable createAlias(String alias) {
    return $FuelEntriesTable(attachedDatabase, alias);
  }
}

class FuelEntryRecord extends DataClass implements Insertable<FuelEntryRecord> {
  final int id;

  /// При удалении автомобиля его заправки удаляются.
  final int carId;
  final DateTime date;

  /// Показание одометра, км.
  final int mileage;
  final double liters;
  final double pricePerLiter;
  final double totalCost;
  final bool isFullTank;
  final String? station;
  final String? comment;
  const FuelEntryRecord({
    required this.id,
    required this.carId,
    required this.date,
    required this.mileage,
    required this.liters,
    required this.pricePerLiter,
    required this.totalCost,
    required this.isFullTank,
    this.station,
    this.comment,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['car_id'] = Variable<int>(carId);
    map['date'] = Variable<DateTime>(date);
    map['mileage'] = Variable<int>(mileage);
    map['liters'] = Variable<double>(liters);
    map['price_per_liter'] = Variable<double>(pricePerLiter);
    map['total_cost'] = Variable<double>(totalCost);
    map['is_full_tank'] = Variable<bool>(isFullTank);
    if (!nullToAbsent || station != null) {
      map['station'] = Variable<String>(station);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    return map;
  }

  FuelEntriesCompanion toCompanion(bool nullToAbsent) {
    return FuelEntriesCompanion(
      id: Value(id),
      carId: Value(carId),
      date: Value(date),
      mileage: Value(mileage),
      liters: Value(liters),
      pricePerLiter: Value(pricePerLiter),
      totalCost: Value(totalCost),
      isFullTank: Value(isFullTank),
      station: station == null && nullToAbsent
          ? const Value.absent()
          : Value(station),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
    );
  }

  factory FuelEntryRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FuelEntryRecord(
      id: serializer.fromJson<int>(json['id']),
      carId: serializer.fromJson<int>(json['carId']),
      date: serializer.fromJson<DateTime>(json['date']),
      mileage: serializer.fromJson<int>(json['mileage']),
      liters: serializer.fromJson<double>(json['liters']),
      pricePerLiter: serializer.fromJson<double>(json['pricePerLiter']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
      isFullTank: serializer.fromJson<bool>(json['isFullTank']),
      station: serializer.fromJson<String?>(json['station']),
      comment: serializer.fromJson<String?>(json['comment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'carId': serializer.toJson<int>(carId),
      'date': serializer.toJson<DateTime>(date),
      'mileage': serializer.toJson<int>(mileage),
      'liters': serializer.toJson<double>(liters),
      'pricePerLiter': serializer.toJson<double>(pricePerLiter),
      'totalCost': serializer.toJson<double>(totalCost),
      'isFullTank': serializer.toJson<bool>(isFullTank),
      'station': serializer.toJson<String?>(station),
      'comment': serializer.toJson<String?>(comment),
    };
  }

  FuelEntryRecord copyWith({
    int? id,
    int? carId,
    DateTime? date,
    int? mileage,
    double? liters,
    double? pricePerLiter,
    double? totalCost,
    bool? isFullTank,
    Value<String?> station = const Value.absent(),
    Value<String?> comment = const Value.absent(),
  }) => FuelEntryRecord(
    id: id ?? this.id,
    carId: carId ?? this.carId,
    date: date ?? this.date,
    mileage: mileage ?? this.mileage,
    liters: liters ?? this.liters,
    pricePerLiter: pricePerLiter ?? this.pricePerLiter,
    totalCost: totalCost ?? this.totalCost,
    isFullTank: isFullTank ?? this.isFullTank,
    station: station.present ? station.value : this.station,
    comment: comment.present ? comment.value : this.comment,
  );
  FuelEntryRecord copyWithCompanion(FuelEntriesCompanion data) {
    return FuelEntryRecord(
      id: data.id.present ? data.id.value : this.id,
      carId: data.carId.present ? data.carId.value : this.carId,
      date: data.date.present ? data.date.value : this.date,
      mileage: data.mileage.present ? data.mileage.value : this.mileage,
      liters: data.liters.present ? data.liters.value : this.liters,
      pricePerLiter: data.pricePerLiter.present
          ? data.pricePerLiter.value
          : this.pricePerLiter,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      isFullTank: data.isFullTank.present
          ? data.isFullTank.value
          : this.isFullTank,
      station: data.station.present ? data.station.value : this.station,
      comment: data.comment.present ? data.comment.value : this.comment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FuelEntryRecord(')
          ..write('id: $id, ')
          ..write('carId: $carId, ')
          ..write('date: $date, ')
          ..write('mileage: $mileage, ')
          ..write('liters: $liters, ')
          ..write('pricePerLiter: $pricePerLiter, ')
          ..write('totalCost: $totalCost, ')
          ..write('isFullTank: $isFullTank, ')
          ..write('station: $station, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    carId,
    date,
    mileage,
    liters,
    pricePerLiter,
    totalCost,
    isFullTank,
    station,
    comment,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FuelEntryRecord &&
          other.id == this.id &&
          other.carId == this.carId &&
          other.date == this.date &&
          other.mileage == this.mileage &&
          other.liters == this.liters &&
          other.pricePerLiter == this.pricePerLiter &&
          other.totalCost == this.totalCost &&
          other.isFullTank == this.isFullTank &&
          other.station == this.station &&
          other.comment == this.comment);
}

class FuelEntriesCompanion extends UpdateCompanion<FuelEntryRecord> {
  final Value<int> id;
  final Value<int> carId;
  final Value<DateTime> date;
  final Value<int> mileage;
  final Value<double> liters;
  final Value<double> pricePerLiter;
  final Value<double> totalCost;
  final Value<bool> isFullTank;
  final Value<String?> station;
  final Value<String?> comment;
  const FuelEntriesCompanion({
    this.id = const Value.absent(),
    this.carId = const Value.absent(),
    this.date = const Value.absent(),
    this.mileage = const Value.absent(),
    this.liters = const Value.absent(),
    this.pricePerLiter = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.isFullTank = const Value.absent(),
    this.station = const Value.absent(),
    this.comment = const Value.absent(),
  });
  FuelEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int carId,
    required DateTime date,
    required int mileage,
    required double liters,
    required double pricePerLiter,
    required double totalCost,
    required bool isFullTank,
    this.station = const Value.absent(),
    this.comment = const Value.absent(),
  }) : carId = Value(carId),
       date = Value(date),
       mileage = Value(mileage),
       liters = Value(liters),
       pricePerLiter = Value(pricePerLiter),
       totalCost = Value(totalCost),
       isFullTank = Value(isFullTank);
  static Insertable<FuelEntryRecord> custom({
    Expression<int>? id,
    Expression<int>? carId,
    Expression<DateTime>? date,
    Expression<int>? mileage,
    Expression<double>? liters,
    Expression<double>? pricePerLiter,
    Expression<double>? totalCost,
    Expression<bool>? isFullTank,
    Expression<String>? station,
    Expression<String>? comment,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carId != null) 'car_id': carId,
      if (date != null) 'date': date,
      if (mileage != null) 'mileage': mileage,
      if (liters != null) 'liters': liters,
      if (pricePerLiter != null) 'price_per_liter': pricePerLiter,
      if (totalCost != null) 'total_cost': totalCost,
      if (isFullTank != null) 'is_full_tank': isFullTank,
      if (station != null) 'station': station,
      if (comment != null) 'comment': comment,
    });
  }

  FuelEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? carId,
    Value<DateTime>? date,
    Value<int>? mileage,
    Value<double>? liters,
    Value<double>? pricePerLiter,
    Value<double>? totalCost,
    Value<bool>? isFullTank,
    Value<String?>? station,
    Value<String?>? comment,
  }) {
    return FuelEntriesCompanion(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      date: date ?? this.date,
      mileage: mileage ?? this.mileage,
      liters: liters ?? this.liters,
      pricePerLiter: pricePerLiter ?? this.pricePerLiter,
      totalCost: totalCost ?? this.totalCost,
      isFullTank: isFullTank ?? this.isFullTank,
      station: station ?? this.station,
      comment: comment ?? this.comment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (carId.present) {
      map['car_id'] = Variable<int>(carId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (mileage.present) {
      map['mileage'] = Variable<int>(mileage.value);
    }
    if (liters.present) {
      map['liters'] = Variable<double>(liters.value);
    }
    if (pricePerLiter.present) {
      map['price_per_liter'] = Variable<double>(pricePerLiter.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (isFullTank.present) {
      map['is_full_tank'] = Variable<bool>(isFullTank.value);
    }
    if (station.present) {
      map['station'] = Variable<String>(station.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FuelEntriesCompanion(')
          ..write('id: $id, ')
          ..write('carId: $carId, ')
          ..write('date: $date, ')
          ..write('mileage: $mileage, ')
          ..write('liters: $liters, ')
          ..write('pricePerLiter: $pricePerLiter, ')
          ..write('totalCost: $totalCost, ')
          ..write('isFullTank: $isFullTank, ')
          ..write('station: $station, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses
    with TableInfo<$ExpensesTable, ExpenseRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _carIdMeta = const VerificationMeta('carId');
  @override
  late final GeneratedColumn<int> carId = GeneratedColumn<int>(
    'car_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cars (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ExpenseCategory, String>
  category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<ExpenseCategory>($ExpensesTable.$convertercategory);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mileageMeta = const VerificationMeta(
    'mileage',
  );
  @override
  late final GeneratedColumn<int> mileage = GeneratedColumn<int>(
    'mileage',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    carId,
    date,
    category,
    amount,
    mileage,
    comment,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('car_id')) {
      context.handle(
        _carIdMeta,
        carId.isAcceptableOrUnknown(data['car_id']!, _carIdMeta),
      );
    } else if (isInserting) {
      context.missing(_carIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('mileage')) {
      context.handle(
        _mileageMeta,
        mileage.isAcceptableOrUnknown(data['mileage']!, _mileageMeta),
      );
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      carId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}car_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      category: $ExpensesTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category'],
        )!,
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      mileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mileage'],
      ),
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ExpenseCategory, String, String>
  $convertercategory = const EnumNameConverter<ExpenseCategory>(
    ExpenseCategory.values,
  );
}

class ExpenseRecord extends DataClass implements Insertable<ExpenseRecord> {
  final int id;

  /// При удалении автомобиля его расходы удаляются.
  final int carId;
  final DateTime date;
  final ExpenseCategory category;
  final double amount;

  /// Пробег на момент расхода, км (необязательно).
  final int? mileage;
  final String? comment;
  const ExpenseRecord({
    required this.id,
    required this.carId,
    required this.date,
    required this.category,
    required this.amount,
    this.mileage,
    this.comment,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['car_id'] = Variable<int>(carId);
    map['date'] = Variable<DateTime>(date);
    {
      map['category'] = Variable<String>(
        $ExpensesTable.$convertercategory.toSql(category),
      );
    }
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || mileage != null) {
      map['mileage'] = Variable<int>(mileage);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      carId: Value(carId),
      date: Value(date),
      category: Value(category),
      amount: Value(amount),
      mileage: mileage == null && nullToAbsent
          ? const Value.absent()
          : Value(mileage),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
    );
  }

  factory ExpenseRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseRecord(
      id: serializer.fromJson<int>(json['id']),
      carId: serializer.fromJson<int>(json['carId']),
      date: serializer.fromJson<DateTime>(json['date']),
      category: $ExpensesTable.$convertercategory.fromJson(
        serializer.fromJson<String>(json['category']),
      ),
      amount: serializer.fromJson<double>(json['amount']),
      mileage: serializer.fromJson<int?>(json['mileage']),
      comment: serializer.fromJson<String?>(json['comment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'carId': serializer.toJson<int>(carId),
      'date': serializer.toJson<DateTime>(date),
      'category': serializer.toJson<String>(
        $ExpensesTable.$convertercategory.toJson(category),
      ),
      'amount': serializer.toJson<double>(amount),
      'mileage': serializer.toJson<int?>(mileage),
      'comment': serializer.toJson<String?>(comment),
    };
  }

  ExpenseRecord copyWith({
    int? id,
    int? carId,
    DateTime? date,
    ExpenseCategory? category,
    double? amount,
    Value<int?> mileage = const Value.absent(),
    Value<String?> comment = const Value.absent(),
  }) => ExpenseRecord(
    id: id ?? this.id,
    carId: carId ?? this.carId,
    date: date ?? this.date,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    mileage: mileage.present ? mileage.value : this.mileage,
    comment: comment.present ? comment.value : this.comment,
  );
  ExpenseRecord copyWithCompanion(ExpensesCompanion data) {
    return ExpenseRecord(
      id: data.id.present ? data.id.value : this.id,
      carId: data.carId.present ? data.carId.value : this.carId,
      date: data.date.present ? data.date.value : this.date,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      mileage: data.mileage.present ? data.mileage.value : this.mileage,
      comment: data.comment.present ? data.comment.value : this.comment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseRecord(')
          ..write('id: $id, ')
          ..write('carId: $carId, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('mileage: $mileage, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, carId, date, category, amount, mileage, comment);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseRecord &&
          other.id == this.id &&
          other.carId == this.carId &&
          other.date == this.date &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.mileage == this.mileage &&
          other.comment == this.comment);
}

class ExpensesCompanion extends UpdateCompanion<ExpenseRecord> {
  final Value<int> id;
  final Value<int> carId;
  final Value<DateTime> date;
  final Value<ExpenseCategory> category;
  final Value<double> amount;
  final Value<int?> mileage;
  final Value<String?> comment;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.carId = const Value.absent(),
    this.date = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.mileage = const Value.absent(),
    this.comment = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required int carId,
    required DateTime date,
    required ExpenseCategory category,
    required double amount,
    this.mileage = const Value.absent(),
    this.comment = const Value.absent(),
  }) : carId = Value(carId),
       date = Value(date),
       category = Value(category),
       amount = Value(amount);
  static Insertable<ExpenseRecord> custom({
    Expression<int>? id,
    Expression<int>? carId,
    Expression<DateTime>? date,
    Expression<String>? category,
    Expression<double>? amount,
    Expression<int>? mileage,
    Expression<String>? comment,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carId != null) 'car_id': carId,
      if (date != null) 'date': date,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (mileage != null) 'mileage': mileage,
      if (comment != null) 'comment': comment,
    });
  }

  ExpensesCompanion copyWith({
    Value<int>? id,
    Value<int>? carId,
    Value<DateTime>? date,
    Value<ExpenseCategory>? category,
    Value<double>? amount,
    Value<int?>? mileage,
    Value<String?>? comment,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      date: date ?? this.date,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      mileage: mileage ?? this.mileage,
      comment: comment ?? this.comment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (carId.present) {
      map['car_id'] = Variable<int>(carId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
        $ExpensesTable.$convertercategory.toSql(category.value),
      );
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (mileage.present) {
      map['mileage'] = Variable<int>(mileage.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('carId: $carId, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('mileage: $mileage, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, ReminderRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _carIdMeta = const VerificationMeta('carId');
  @override
  late final GeneratedColumn<int> carId = GeneratedColumn<int>(
    'car_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cars (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalKmMeta = const VerificationMeta(
    'intervalKm',
  );
  @override
  late final GeneratedColumn<int> intervalKm = GeneratedColumn<int>(
    'interval_km',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intervalMonthsMeta = const VerificationMeta(
    'intervalMonths',
  );
  @override
  late final GeneratedColumn<int> intervalMonths = GeneratedColumn<int>(
    'interval_months',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastDoneDateMeta = const VerificationMeta(
    'lastDoneDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastDoneDate = GeneratedColumn<DateTime>(
    'last_done_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastDoneMileageMeta = const VerificationMeta(
    'lastDoneMileage',
  );
  @override
  late final GeneratedColumn<int> lastDoneMileage = GeneratedColumn<int>(
    'last_done_mileage',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _advanceDaysMeta = const VerificationMeta(
    'advanceDays',
  );
  @override
  late final GeneratedColumn<int> advanceDays = GeneratedColumn<int>(
    'advance_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(7),
  );
  static const VerificationMeta _advanceKmMeta = const VerificationMeta(
    'advanceKm',
  );
  @override
  late final GeneratedColumn<int> advanceKm = GeneratedColumn<int>(
    'advance_km',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(500),
  );
  static const VerificationMeta _notifiedDueMileageMeta =
      const VerificationMeta('notifiedDueMileage');
  @override
  late final GeneratedColumn<int> notifiedDueMileage = GeneratedColumn<int>(
    'notified_due_mileage',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    carId,
    title,
    intervalKm,
    intervalMonths,
    lastDoneDate,
    lastDoneMileage,
    advanceDays,
    advanceKm,
    notifiedDueMileage,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('car_id')) {
      context.handle(
        _carIdMeta,
        carId.isAcceptableOrUnknown(data['car_id']!, _carIdMeta),
      );
    } else if (isInserting) {
      context.missing(_carIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('interval_km')) {
      context.handle(
        _intervalKmMeta,
        intervalKm.isAcceptableOrUnknown(data['interval_km']!, _intervalKmMeta),
      );
    }
    if (data.containsKey('interval_months')) {
      context.handle(
        _intervalMonthsMeta,
        intervalMonths.isAcceptableOrUnknown(
          data['interval_months']!,
          _intervalMonthsMeta,
        ),
      );
    }
    if (data.containsKey('last_done_date')) {
      context.handle(
        _lastDoneDateMeta,
        lastDoneDate.isAcceptableOrUnknown(
          data['last_done_date']!,
          _lastDoneDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastDoneDateMeta);
    }
    if (data.containsKey('last_done_mileage')) {
      context.handle(
        _lastDoneMileageMeta,
        lastDoneMileage.isAcceptableOrUnknown(
          data['last_done_mileage']!,
          _lastDoneMileageMeta,
        ),
      );
    }
    if (data.containsKey('advance_days')) {
      context.handle(
        _advanceDaysMeta,
        advanceDays.isAcceptableOrUnknown(
          data['advance_days']!,
          _advanceDaysMeta,
        ),
      );
    }
    if (data.containsKey('advance_km')) {
      context.handle(
        _advanceKmMeta,
        advanceKm.isAcceptableOrUnknown(data['advance_km']!, _advanceKmMeta),
      );
    }
    if (data.containsKey('notified_due_mileage')) {
      context.handle(
        _notifiedDueMileageMeta,
        notifiedDueMileage.isAcceptableOrUnknown(
          data['notified_due_mileage']!,
          _notifiedDueMileageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      carId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}car_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      intervalKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_km'],
      ),
      intervalMonths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_months'],
      ),
      lastDoneDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_done_date'],
      )!,
      lastDoneMileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_done_mileage'],
      ),
      advanceDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}advance_days'],
      )!,
      advanceKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}advance_km'],
      )!,
      notifiedDueMileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notified_due_mileage'],
      ),
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class ReminderRecord extends DataClass implements Insertable<ReminderRecord> {
  final int id;

  /// При удалении автомобиля его напоминания удаляются.
  final int carId;

  /// Вид работ.
  final String title;

  /// Интервал по пробегу, км (может не быть).
  final int? intervalKm;

  /// Интервал по времени, месяцы (может не быть).
  final int? intervalMonths;

  /// Когда работу делали последний раз — от этого считается следующий срок.
  final DateTime lastDoneDate;
  final int? lastDoneMileage;

  /// За сколько дней до срока предупредить.
  final int advanceDays;

  /// За сколько км до срока предупредить.
  final int advanceKm;

  /// Срок по пробегу, о котором уже сообщили (чтобы не повторяться).
  final int? notifiedDueMileage;
  const ReminderRecord({
    required this.id,
    required this.carId,
    required this.title,
    this.intervalKm,
    this.intervalMonths,
    required this.lastDoneDate,
    this.lastDoneMileage,
    required this.advanceDays,
    required this.advanceKm,
    this.notifiedDueMileage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['car_id'] = Variable<int>(carId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || intervalKm != null) {
      map['interval_km'] = Variable<int>(intervalKm);
    }
    if (!nullToAbsent || intervalMonths != null) {
      map['interval_months'] = Variable<int>(intervalMonths);
    }
    map['last_done_date'] = Variable<DateTime>(lastDoneDate);
    if (!nullToAbsent || lastDoneMileage != null) {
      map['last_done_mileage'] = Variable<int>(lastDoneMileage);
    }
    map['advance_days'] = Variable<int>(advanceDays);
    map['advance_km'] = Variable<int>(advanceKm);
    if (!nullToAbsent || notifiedDueMileage != null) {
      map['notified_due_mileage'] = Variable<int>(notifiedDueMileage);
    }
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      carId: Value(carId),
      title: Value(title),
      intervalKm: intervalKm == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalKm),
      intervalMonths: intervalMonths == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalMonths),
      lastDoneDate: Value(lastDoneDate),
      lastDoneMileage: lastDoneMileage == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDoneMileage),
      advanceDays: Value(advanceDays),
      advanceKm: Value(advanceKm),
      notifiedDueMileage: notifiedDueMileage == null && nullToAbsent
          ? const Value.absent()
          : Value(notifiedDueMileage),
    );
  }

  factory ReminderRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderRecord(
      id: serializer.fromJson<int>(json['id']),
      carId: serializer.fromJson<int>(json['carId']),
      title: serializer.fromJson<String>(json['title']),
      intervalKm: serializer.fromJson<int?>(json['intervalKm']),
      intervalMonths: serializer.fromJson<int?>(json['intervalMonths']),
      lastDoneDate: serializer.fromJson<DateTime>(json['lastDoneDate']),
      lastDoneMileage: serializer.fromJson<int?>(json['lastDoneMileage']),
      advanceDays: serializer.fromJson<int>(json['advanceDays']),
      advanceKm: serializer.fromJson<int>(json['advanceKm']),
      notifiedDueMileage: serializer.fromJson<int?>(json['notifiedDueMileage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'carId': serializer.toJson<int>(carId),
      'title': serializer.toJson<String>(title),
      'intervalKm': serializer.toJson<int?>(intervalKm),
      'intervalMonths': serializer.toJson<int?>(intervalMonths),
      'lastDoneDate': serializer.toJson<DateTime>(lastDoneDate),
      'lastDoneMileage': serializer.toJson<int?>(lastDoneMileage),
      'advanceDays': serializer.toJson<int>(advanceDays),
      'advanceKm': serializer.toJson<int>(advanceKm),
      'notifiedDueMileage': serializer.toJson<int?>(notifiedDueMileage),
    };
  }

  ReminderRecord copyWith({
    int? id,
    int? carId,
    String? title,
    Value<int?> intervalKm = const Value.absent(),
    Value<int?> intervalMonths = const Value.absent(),
    DateTime? lastDoneDate,
    Value<int?> lastDoneMileage = const Value.absent(),
    int? advanceDays,
    int? advanceKm,
    Value<int?> notifiedDueMileage = const Value.absent(),
  }) => ReminderRecord(
    id: id ?? this.id,
    carId: carId ?? this.carId,
    title: title ?? this.title,
    intervalKm: intervalKm.present ? intervalKm.value : this.intervalKm,
    intervalMonths: intervalMonths.present
        ? intervalMonths.value
        : this.intervalMonths,
    lastDoneDate: lastDoneDate ?? this.lastDoneDate,
    lastDoneMileage: lastDoneMileage.present
        ? lastDoneMileage.value
        : this.lastDoneMileage,
    advanceDays: advanceDays ?? this.advanceDays,
    advanceKm: advanceKm ?? this.advanceKm,
    notifiedDueMileage: notifiedDueMileage.present
        ? notifiedDueMileage.value
        : this.notifiedDueMileage,
  );
  ReminderRecord copyWithCompanion(RemindersCompanion data) {
    return ReminderRecord(
      id: data.id.present ? data.id.value : this.id,
      carId: data.carId.present ? data.carId.value : this.carId,
      title: data.title.present ? data.title.value : this.title,
      intervalKm: data.intervalKm.present
          ? data.intervalKm.value
          : this.intervalKm,
      intervalMonths: data.intervalMonths.present
          ? data.intervalMonths.value
          : this.intervalMonths,
      lastDoneDate: data.lastDoneDate.present
          ? data.lastDoneDate.value
          : this.lastDoneDate,
      lastDoneMileage: data.lastDoneMileage.present
          ? data.lastDoneMileage.value
          : this.lastDoneMileage,
      advanceDays: data.advanceDays.present
          ? data.advanceDays.value
          : this.advanceDays,
      advanceKm: data.advanceKm.present ? data.advanceKm.value : this.advanceKm,
      notifiedDueMileage: data.notifiedDueMileage.present
          ? data.notifiedDueMileage.value
          : this.notifiedDueMileage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderRecord(')
          ..write('id: $id, ')
          ..write('carId: $carId, ')
          ..write('title: $title, ')
          ..write('intervalKm: $intervalKm, ')
          ..write('intervalMonths: $intervalMonths, ')
          ..write('lastDoneDate: $lastDoneDate, ')
          ..write('lastDoneMileage: $lastDoneMileage, ')
          ..write('advanceDays: $advanceDays, ')
          ..write('advanceKm: $advanceKm, ')
          ..write('notifiedDueMileage: $notifiedDueMileage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    carId,
    title,
    intervalKm,
    intervalMonths,
    lastDoneDate,
    lastDoneMileage,
    advanceDays,
    advanceKm,
    notifiedDueMileage,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderRecord &&
          other.id == this.id &&
          other.carId == this.carId &&
          other.title == this.title &&
          other.intervalKm == this.intervalKm &&
          other.intervalMonths == this.intervalMonths &&
          other.lastDoneDate == this.lastDoneDate &&
          other.lastDoneMileage == this.lastDoneMileage &&
          other.advanceDays == this.advanceDays &&
          other.advanceKm == this.advanceKm &&
          other.notifiedDueMileage == this.notifiedDueMileage);
}

class RemindersCompanion extends UpdateCompanion<ReminderRecord> {
  final Value<int> id;
  final Value<int> carId;
  final Value<String> title;
  final Value<int?> intervalKm;
  final Value<int?> intervalMonths;
  final Value<DateTime> lastDoneDate;
  final Value<int?> lastDoneMileage;
  final Value<int> advanceDays;
  final Value<int> advanceKm;
  final Value<int?> notifiedDueMileage;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.carId = const Value.absent(),
    this.title = const Value.absent(),
    this.intervalKm = const Value.absent(),
    this.intervalMonths = const Value.absent(),
    this.lastDoneDate = const Value.absent(),
    this.lastDoneMileage = const Value.absent(),
    this.advanceDays = const Value.absent(),
    this.advanceKm = const Value.absent(),
    this.notifiedDueMileage = const Value.absent(),
  });
  RemindersCompanion.insert({
    this.id = const Value.absent(),
    required int carId,
    required String title,
    this.intervalKm = const Value.absent(),
    this.intervalMonths = const Value.absent(),
    required DateTime lastDoneDate,
    this.lastDoneMileage = const Value.absent(),
    this.advanceDays = const Value.absent(),
    this.advanceKm = const Value.absent(),
    this.notifiedDueMileage = const Value.absent(),
  }) : carId = Value(carId),
       title = Value(title),
       lastDoneDate = Value(lastDoneDate);
  static Insertable<ReminderRecord> custom({
    Expression<int>? id,
    Expression<int>? carId,
    Expression<String>? title,
    Expression<int>? intervalKm,
    Expression<int>? intervalMonths,
    Expression<DateTime>? lastDoneDate,
    Expression<int>? lastDoneMileage,
    Expression<int>? advanceDays,
    Expression<int>? advanceKm,
    Expression<int>? notifiedDueMileage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carId != null) 'car_id': carId,
      if (title != null) 'title': title,
      if (intervalKm != null) 'interval_km': intervalKm,
      if (intervalMonths != null) 'interval_months': intervalMonths,
      if (lastDoneDate != null) 'last_done_date': lastDoneDate,
      if (lastDoneMileage != null) 'last_done_mileage': lastDoneMileage,
      if (advanceDays != null) 'advance_days': advanceDays,
      if (advanceKm != null) 'advance_km': advanceKm,
      if (notifiedDueMileage != null)
        'notified_due_mileage': notifiedDueMileage,
    });
  }

  RemindersCompanion copyWith({
    Value<int>? id,
    Value<int>? carId,
    Value<String>? title,
    Value<int?>? intervalKm,
    Value<int?>? intervalMonths,
    Value<DateTime>? lastDoneDate,
    Value<int?>? lastDoneMileage,
    Value<int>? advanceDays,
    Value<int>? advanceKm,
    Value<int?>? notifiedDueMileage,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      title: title ?? this.title,
      intervalKm: intervalKm ?? this.intervalKm,
      intervalMonths: intervalMonths ?? this.intervalMonths,
      lastDoneDate: lastDoneDate ?? this.lastDoneDate,
      lastDoneMileage: lastDoneMileage ?? this.lastDoneMileage,
      advanceDays: advanceDays ?? this.advanceDays,
      advanceKm: advanceKm ?? this.advanceKm,
      notifiedDueMileage: notifiedDueMileage ?? this.notifiedDueMileage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (carId.present) {
      map['car_id'] = Variable<int>(carId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (intervalKm.present) {
      map['interval_km'] = Variable<int>(intervalKm.value);
    }
    if (intervalMonths.present) {
      map['interval_months'] = Variable<int>(intervalMonths.value);
    }
    if (lastDoneDate.present) {
      map['last_done_date'] = Variable<DateTime>(lastDoneDate.value);
    }
    if (lastDoneMileage.present) {
      map['last_done_mileage'] = Variable<int>(lastDoneMileage.value);
    }
    if (advanceDays.present) {
      map['advance_days'] = Variable<int>(advanceDays.value);
    }
    if (advanceKm.present) {
      map['advance_km'] = Variable<int>(advanceKm.value);
    }
    if (notifiedDueMileage.present) {
      map['notified_due_mileage'] = Variable<int>(notifiedDueMileage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('carId: $carId, ')
          ..write('title: $title, ')
          ..write('intervalKm: $intervalKm, ')
          ..write('intervalMonths: $intervalMonths, ')
          ..write('lastDoneDate: $lastDoneDate, ')
          ..write('lastDoneMileage: $lastDoneMileage, ')
          ..write('advanceDays: $advanceDays, ')
          ..write('advanceKm: $advanceKm, ')
          ..write('notifiedDueMileage: $notifiedDueMileage')
          ..write(')'))
        .toString();
  }
}

class $ServiceRecordsTable extends ServiceRecords
    with TableInfo<$ServiceRecordsTable, ServiceRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _carIdMeta = const VerificationMeta('carId');
  @override
  late final GeneratedColumn<int> carId = GeneratedColumn<int>(
    'car_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cars (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _reminderIdMeta = const VerificationMeta(
    'reminderId',
  );
  @override
  late final GeneratedColumn<int> reminderId = GeneratedColumn<int>(
    'reminder_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES reminders (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mileageMeta = const VerificationMeta(
    'mileage',
  );
  @override
  late final GeneratedColumn<int> mileage = GeneratedColumn<int>(
    'mileage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stationMeta = const VerificationMeta(
    'station',
  );
  @override
  late final GeneratedColumn<String> station = GeneratedColumn<String>(
    'station',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    carId,
    reminderId,
    title,
    date,
    mileage,
    cost,
    station,
    comment,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServiceRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('car_id')) {
      context.handle(
        _carIdMeta,
        carId.isAcceptableOrUnknown(data['car_id']!, _carIdMeta),
      );
    } else if (isInserting) {
      context.missing(_carIdMeta);
    }
    if (data.containsKey('reminder_id')) {
      context.handle(
        _reminderIdMeta,
        reminderId.isAcceptableOrUnknown(data['reminder_id']!, _reminderIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('mileage')) {
      context.handle(
        _mileageMeta,
        mileage.isAcceptableOrUnknown(data['mileage']!, _mileageMeta),
      );
    } else if (isInserting) {
      context.missing(_mileageMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('station')) {
      context.handle(
        _stationMeta,
        station.isAcceptableOrUnknown(data['station']!, _stationMeta),
      );
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      carId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}car_id'],
      )!,
      reminderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      mileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mileage'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      ),
      station: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}station'],
      ),
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
    );
  }

  @override
  $ServiceRecordsTable createAlias(String alias) {
    return $ServiceRecordsTable(attachedDatabase, alias);
  }
}

class ServiceRecordRow extends DataClass
    implements Insertable<ServiceRecordRow> {
  final int id;

  /// При удалении автомобиля его записи ТО удаляются.
  final int carId;

  /// Напоминание, которое продлила эта запись; при удалении
  /// напоминания запись остаётся.
  final int? reminderId;

  /// Вид работ.
  final String title;
  final DateTime date;
  final int mileage;
  final double? cost;

  /// СТО.
  final String? station;
  final String? comment;
  const ServiceRecordRow({
    required this.id,
    required this.carId,
    this.reminderId,
    required this.title,
    required this.date,
    required this.mileage,
    this.cost,
    this.station,
    this.comment,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['car_id'] = Variable<int>(carId);
    if (!nullToAbsent || reminderId != null) {
      map['reminder_id'] = Variable<int>(reminderId);
    }
    map['title'] = Variable<String>(title);
    map['date'] = Variable<DateTime>(date);
    map['mileage'] = Variable<int>(mileage);
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<double>(cost);
    }
    if (!nullToAbsent || station != null) {
      map['station'] = Variable<String>(station);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    return map;
  }

  ServiceRecordsCompanion toCompanion(bool nullToAbsent) {
    return ServiceRecordsCompanion(
      id: Value(id),
      carId: Value(carId),
      reminderId: reminderId == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderId),
      title: Value(title),
      date: Value(date),
      mileage: Value(mileage),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
      station: station == null && nullToAbsent
          ? const Value.absent()
          : Value(station),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
    );
  }

  factory ServiceRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceRecordRow(
      id: serializer.fromJson<int>(json['id']),
      carId: serializer.fromJson<int>(json['carId']),
      reminderId: serializer.fromJson<int?>(json['reminderId']),
      title: serializer.fromJson<String>(json['title']),
      date: serializer.fromJson<DateTime>(json['date']),
      mileage: serializer.fromJson<int>(json['mileage']),
      cost: serializer.fromJson<double?>(json['cost']),
      station: serializer.fromJson<String?>(json['station']),
      comment: serializer.fromJson<String?>(json['comment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'carId': serializer.toJson<int>(carId),
      'reminderId': serializer.toJson<int?>(reminderId),
      'title': serializer.toJson<String>(title),
      'date': serializer.toJson<DateTime>(date),
      'mileage': serializer.toJson<int>(mileage),
      'cost': serializer.toJson<double?>(cost),
      'station': serializer.toJson<String?>(station),
      'comment': serializer.toJson<String?>(comment),
    };
  }

  ServiceRecordRow copyWith({
    int? id,
    int? carId,
    Value<int?> reminderId = const Value.absent(),
    String? title,
    DateTime? date,
    int? mileage,
    Value<double?> cost = const Value.absent(),
    Value<String?> station = const Value.absent(),
    Value<String?> comment = const Value.absent(),
  }) => ServiceRecordRow(
    id: id ?? this.id,
    carId: carId ?? this.carId,
    reminderId: reminderId.present ? reminderId.value : this.reminderId,
    title: title ?? this.title,
    date: date ?? this.date,
    mileage: mileage ?? this.mileage,
    cost: cost.present ? cost.value : this.cost,
    station: station.present ? station.value : this.station,
    comment: comment.present ? comment.value : this.comment,
  );
  ServiceRecordRow copyWithCompanion(ServiceRecordsCompanion data) {
    return ServiceRecordRow(
      id: data.id.present ? data.id.value : this.id,
      carId: data.carId.present ? data.carId.value : this.carId,
      reminderId: data.reminderId.present
          ? data.reminderId.value
          : this.reminderId,
      title: data.title.present ? data.title.value : this.title,
      date: data.date.present ? data.date.value : this.date,
      mileage: data.mileage.present ? data.mileage.value : this.mileage,
      cost: data.cost.present ? data.cost.value : this.cost,
      station: data.station.present ? data.station.value : this.station,
      comment: data.comment.present ? data.comment.value : this.comment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceRecordRow(')
          ..write('id: $id, ')
          ..write('carId: $carId, ')
          ..write('reminderId: $reminderId, ')
          ..write('title: $title, ')
          ..write('date: $date, ')
          ..write('mileage: $mileage, ')
          ..write('cost: $cost, ')
          ..write('station: $station, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    carId,
    reminderId,
    title,
    date,
    mileage,
    cost,
    station,
    comment,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceRecordRow &&
          other.id == this.id &&
          other.carId == this.carId &&
          other.reminderId == this.reminderId &&
          other.title == this.title &&
          other.date == this.date &&
          other.mileage == this.mileage &&
          other.cost == this.cost &&
          other.station == this.station &&
          other.comment == this.comment);
}

class ServiceRecordsCompanion extends UpdateCompanion<ServiceRecordRow> {
  final Value<int> id;
  final Value<int> carId;
  final Value<int?> reminderId;
  final Value<String> title;
  final Value<DateTime> date;
  final Value<int> mileage;
  final Value<double?> cost;
  final Value<String?> station;
  final Value<String?> comment;
  const ServiceRecordsCompanion({
    this.id = const Value.absent(),
    this.carId = const Value.absent(),
    this.reminderId = const Value.absent(),
    this.title = const Value.absent(),
    this.date = const Value.absent(),
    this.mileage = const Value.absent(),
    this.cost = const Value.absent(),
    this.station = const Value.absent(),
    this.comment = const Value.absent(),
  });
  ServiceRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int carId,
    this.reminderId = const Value.absent(),
    required String title,
    required DateTime date,
    required int mileage,
    this.cost = const Value.absent(),
    this.station = const Value.absent(),
    this.comment = const Value.absent(),
  }) : carId = Value(carId),
       title = Value(title),
       date = Value(date),
       mileage = Value(mileage);
  static Insertable<ServiceRecordRow> custom({
    Expression<int>? id,
    Expression<int>? carId,
    Expression<int>? reminderId,
    Expression<String>? title,
    Expression<DateTime>? date,
    Expression<int>? mileage,
    Expression<double>? cost,
    Expression<String>? station,
    Expression<String>? comment,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carId != null) 'car_id': carId,
      if (reminderId != null) 'reminder_id': reminderId,
      if (title != null) 'title': title,
      if (date != null) 'date': date,
      if (mileage != null) 'mileage': mileage,
      if (cost != null) 'cost': cost,
      if (station != null) 'station': station,
      if (comment != null) 'comment': comment,
    });
  }

  ServiceRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? carId,
    Value<int?>? reminderId,
    Value<String>? title,
    Value<DateTime>? date,
    Value<int>? mileage,
    Value<double?>? cost,
    Value<String?>? station,
    Value<String?>? comment,
  }) {
    return ServiceRecordsCompanion(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      reminderId: reminderId ?? this.reminderId,
      title: title ?? this.title,
      date: date ?? this.date,
      mileage: mileage ?? this.mileage,
      cost: cost ?? this.cost,
      station: station ?? this.station,
      comment: comment ?? this.comment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (carId.present) {
      map['car_id'] = Variable<int>(carId.value);
    }
    if (reminderId.present) {
      map['reminder_id'] = Variable<int>(reminderId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (mileage.present) {
      map['mileage'] = Variable<int>(mileage.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (station.present) {
      map['station'] = Variable<String>(station.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceRecordsCompanion(')
          ..write('id: $id, ')
          ..write('carId: $carId, ')
          ..write('reminderId: $reminderId, ')
          ..write('title: $title, ')
          ..write('date: $date, ')
          ..write('mileage: $mileage, ')
          ..write('cost: $cost, ')
          ..write('station: $station, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, SettingEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingEntry(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class SettingEntry extends DataClass implements Insertable<SettingEntry> {
  final String key;
  final String value;
  const SettingEntry({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(key: Value(key), value: Value(value));
  }

  factory SettingEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingEntry(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SettingEntry copyWith({String? key, String? value}) =>
      SettingEntry(key: key ?? this.key, value: value ?? this.value);
  SettingEntry copyWithCompanion(SettingsCompanion data) {
    return SettingEntry(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingEntry(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingEntry &&
          other.key == this.key &&
          other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<SettingEntry> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SettingEntry> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CarsTable cars = $CarsTable(this);
  late final $FuelEntriesTable fuelEntries = $FuelEntriesTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $ServiceRecordsTable serviceRecords = $ServiceRecordsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final CarsDao carsDao = CarsDao(this as AppDatabase);
  late final FuelDao fuelDao = FuelDao(this as AppDatabase);
  late final ExpensesDao expensesDao = ExpensesDao(this as AppDatabase);
  late final RemindersDao remindersDao = RemindersDao(this as AppDatabase);
  late final ServiceRecordsDao serviceRecordsDao = ServiceRecordsDao(
    this as AppDatabase,
  );
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cars,
    fuelEntries,
    expenses,
    reminders,
    serviceRecords,
    settings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cars',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fuel_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cars',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('expenses', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cars',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reminders', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cars',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('service_records', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'reminders',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('service_records', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$CarsTableCreateCompanionBuilder = CarsCompanion Function({
  Value<int> id,
  required String brand,
  required String model,
  Value<int?> year,
  Value<String?> plateNumber,
  required FuelType fuelType,
  Value<double?> tankVolume,
  required int initialMileage,
  Value<String?> photoFileName,
  Value<DateTime> createdAt,
});
typedef $$CarsTableUpdateCompanionBuilder = CarsCompanion Function({
  Value<int> id,
  Value<String> brand,
  Value<String> model,
  Value<int?> year,
  Value<String?> plateNumber,
  Value<FuelType> fuelType,
  Value<double?> tankVolume,
  Value<int> initialMileage,
  Value<String?> photoFileName,
  Value<DateTime> createdAt,
});

final class $$CarsTableReferences
    extends BaseReferences<_$AppDatabase, $CarsTable, CarRecord> {
  $$CarsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FuelEntriesTable, List<FuelEntryRecord>>
  _fuelEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fuelEntries,
    aliasName: 'cars__id__fuel_entries__car_id',
  );

  $$FuelEntriesTableProcessedTableManager get fuelEntriesRefs {
    final manager = $$FuelEntriesTableTableManager(
      $_db,
      $_db.fuelEntries,
    ).filter((f) => f.carId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fuelEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesTable, List<ExpenseRecord>>
  _expensesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expenses,
    aliasName: 'cars__id__expenses__car_id',
  );

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager(
      $_db,
      $_db.expenses,
    ).filter((f) => f.carId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<ReminderRecord>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: 'cars__id__reminders__car_id',
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.carId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ServiceRecordsTable, List<ServiceRecordRow>>
  _serviceRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.serviceRecords,
    aliasName: 'cars__id__service_records__car_id',
  );

  $$ServiceRecordsTableProcessedTableManager get serviceRecordsRefs {
    final manager = $$ServiceRecordsTableTableManager(
      $_db,
      $_db.serviceRecords,
    ).filter((f) => f.carId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_serviceRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CarsTableFilterComposer extends Composer<_$AppDatabase, $CarsTable> {
  $$CarsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FuelType, FuelType, String> get fuelType =>
      $composableBuilder(
        column: $table.fuelType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get tankVolume => $composableBuilder(
    column: $table.tankVolume,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get initialMileage => $composableBuilder(
    column: $table.initialMileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoFileName => $composableBuilder(
    column: $table.photoFileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> fuelEntriesRefs(
    Expression<bool> Function($$FuelEntriesTableFilterComposer f) f,
  ) {
    final $$FuelEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelEntries,
      getReferencedColumn: (t) => t.carId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEntriesTableFilterComposer(
            $db: $db,
            $table: $db.fuelEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expensesRefs(
    Expression<bool> Function($$ExpensesTableFilterComposer f) f,
  ) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.carId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableFilterComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.carId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> serviceRecordsRefs(
    Expression<bool> Function($$ServiceRecordsTableFilterComposer f) f,
  ) {
    final $$ServiceRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.carId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableFilterComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CarsTableOrderingComposer extends Composer<_$AppDatabase, $CarsTable> {
  $$CarsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tankVolume => $composableBuilder(
    column: $table.tankVolume,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get initialMileage => $composableBuilder(
    column: $table.initialMileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoFileName => $composableBuilder(
    column: $table.photoFileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CarsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CarsTable> {
  $$CarsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<FuelType, String> get fuelType =>
      $composableBuilder(column: $table.fuelType, builder: (column) => column);

  GeneratedColumn<double> get tankVolume => $composableBuilder(
    column: $table.tankVolume,
    builder: (column) => column,
  );

  GeneratedColumn<int> get initialMileage => $composableBuilder(
    column: $table.initialMileage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoFileName => $composableBuilder(
    column: $table.photoFileName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> fuelEntriesRefs<T extends Object>(
    Expression<T> Function($$FuelEntriesTableAnnotationComposer a) f,
  ) {
    final $$FuelEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelEntries,
      getReferencedColumn: (t) => t.carId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.fuelEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expensesRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.carId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.carId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> serviceRecordsRefs<T extends Object>(
    Expression<T> Function($$ServiceRecordsTableAnnotationComposer a) f,
  ) {
    final $$ServiceRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.carId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CarsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CarsTable,
          CarRecord,
          $$CarsTableFilterComposer,
          $$CarsTableOrderingComposer,
          $$CarsTableAnnotationComposer,
          $$CarsTableCreateCompanionBuilder,
          $$CarsTableUpdateCompanionBuilder,
          (CarRecord, $$CarsTableReferences),
          CarRecord,
          PrefetchHooks Function({
            bool fuelEntriesRefs,
            bool expensesRefs,
            bool remindersRefs,
            bool serviceRecordsRefs,
          })
        > {
  $$CarsTableTableManager(_$AppDatabase db, $CarsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CarsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CarsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CarsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> brand = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<int?> year = const Value.absent(),
                Value<String?> plateNumber = const Value.absent(),
                Value<FuelType> fuelType = const Value.absent(),
                Value<double?> tankVolume = const Value.absent(),
                Value<int> initialMileage = const Value.absent(),
                Value<String?> photoFileName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CarsCompanion(
                id: id,
                brand: brand,
                model: model,
                year: year,
                plateNumber: plateNumber,
                fuelType: fuelType,
                tankVolume: tankVolume,
                initialMileage: initialMileage,
                photoFileName: photoFileName,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String brand,
                required String model,
                Value<int?> year = const Value.absent(),
                Value<String?> plateNumber = const Value.absent(),
                required FuelType fuelType,
                Value<double?> tankVolume = const Value.absent(),
                required int initialMileage,
                Value<String?> photoFileName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CarsCompanion.insert(
                id: id,
                brand: brand,
                model: model,
                year: year,
                plateNumber: plateNumber,
                fuelType: fuelType,
                tankVolume: tankVolume,
                initialMileage: initialMileage,
                photoFileName: photoFileName,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CarsTable, CarRecord>(table),
                  $$CarsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                fuelEntriesRefs = false,
                expensesRefs = false,
                remindersRefs = false,
                serviceRecordsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (fuelEntriesRefs) db.fuelEntries,
                    if (expensesRefs) db.expenses,
                    if (remindersRefs) db.reminders,
                    if (serviceRecordsRefs) db.serviceRecords,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (fuelEntriesRefs)
                        await $_getPrefetchedData<
                          CarRecord,
                          $CarsTable,
                          FuelEntryRecord
                        >(
                          currentTable: table,
                          referencedTable: $$CarsTableReferences
                              ._fuelEntriesRefsTable(db),
                          managerFromTypedResult: (p0) => $$CarsTableReferences(
                            db,
                            table,
                            p0,
                          ).fuelEntriesRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.carId == item.id),
                          typedResults: items,
                        ),
                      if (expensesRefs)
                        await $_getPrefetchedData<
                          CarRecord,
                          $CarsTable,
                          ExpenseRecord
                        >(
                          currentTable: table,
                          referencedTable: $$CarsTableReferences
                              ._expensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CarsTableReferences(db, table, p0).expensesRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.carId == item.id),
                          typedResults: items,
                        ),
                      if (remindersRefs)
                        await $_getPrefetchedData<
                          CarRecord,
                          $CarsTable,
                          ReminderRecord
                        >(
                          currentTable: table,
                          referencedTable: $$CarsTableReferences
                              ._remindersRefsTable(db),
                          managerFromTypedResult: (p0) => $$CarsTableReferences(
                            db,
                            table,
                            p0,
                          ).remindersRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.carId == item.id),
                          typedResults: items,
                        ),
                      if (serviceRecordsRefs)
                        await $_getPrefetchedData<
                          CarRecord,
                          $CarsTable,
                          ServiceRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $$CarsTableReferences
                              ._serviceRecordsRefsTable(db),
                          managerFromTypedResult: (p0) => $$CarsTableReferences(
                            db,
                            table,
                            p0,
                          ).serviceRecordsRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.carId == item.id),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CarsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CarsTable,
      CarRecord,
      $$CarsTableFilterComposer,
      $$CarsTableOrderingComposer,
      $$CarsTableAnnotationComposer,
      $$CarsTableCreateCompanionBuilder,
      $$CarsTableUpdateCompanionBuilder,
      (CarRecord, $$CarsTableReferences),
      CarRecord,
      PrefetchHooks Function({
        bool fuelEntriesRefs,
        bool expensesRefs,
        bool remindersRefs,
        bool serviceRecordsRefs,
      })
    >;
typedef $$FuelEntriesTableCreateCompanionBuilder =
    FuelEntriesCompanion Function({
      Value<int> id,
      required int carId,
      required DateTime date,
      required int mileage,
      required double liters,
      required double pricePerLiter,
      required double totalCost,
      required bool isFullTank,
      Value<String?> station,
      Value<String?> comment,
    });
typedef $$FuelEntriesTableUpdateCompanionBuilder =
    FuelEntriesCompanion Function({
      Value<int> id,
      Value<int> carId,
      Value<DateTime> date,
      Value<int> mileage,
      Value<double> liters,
      Value<double> pricePerLiter,
      Value<double> totalCost,
      Value<bool> isFullTank,
      Value<String?> station,
      Value<String?> comment,
    });

final class $$FuelEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $FuelEntriesTable, FuelEntryRecord> {
  $$FuelEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CarsTable _carIdTable(_$AppDatabase db) =>
      db.cars.createAlias('fuel_entries__car_id__cars__id');

  $$CarsTableProcessedTableManager get carId {
    final $_column = $_itemColumn<int>('car_id')!;

    final manager = $$CarsTableTableManager(
      $_db,
      $_db.cars,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_carIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FuelEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FuelEntriesTable> {
  $$FuelEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get liters => $composableBuilder(
    column: $table.liters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get station => $composableBuilder(
    column: $table.station,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  $$CarsTableFilterComposer get carId {
    final $$CarsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableFilterComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FuelEntriesTable> {
  $$FuelEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get liters => $composableBuilder(
    column: $table.liters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get station => $composableBuilder(
    column: $table.station,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  $$CarsTableOrderingComposer get carId {
    final $$CarsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableOrderingComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FuelEntriesTable> {
  $$FuelEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get mileage =>
      $composableBuilder(column: $table.mileage, builder: (column) => column);

  GeneratedColumn<double> get liters =>
      $composableBuilder(column: $table.liters, builder: (column) => column);

  GeneratedColumn<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);

  GeneratedColumn<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => column,
  );

  GeneratedColumn<String> get station =>
      $composableBuilder(column: $table.station, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  $$CarsTableAnnotationComposer get carId {
    final $$CarsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableAnnotationComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FuelEntriesTable,
          FuelEntryRecord,
          $$FuelEntriesTableFilterComposer,
          $$FuelEntriesTableOrderingComposer,
          $$FuelEntriesTableAnnotationComposer,
          $$FuelEntriesTableCreateCompanionBuilder,
          $$FuelEntriesTableUpdateCompanionBuilder,
          (FuelEntryRecord, $$FuelEntriesTableReferences),
          FuelEntryRecord,
          PrefetchHooks Function({bool carId})
        > {
  $$FuelEntriesTableTableManager(_$AppDatabase db, $FuelEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FuelEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FuelEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FuelEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> carId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> mileage = const Value.absent(),
                Value<double> liters = const Value.absent(),
                Value<double> pricePerLiter = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<bool> isFullTank = const Value.absent(),
                Value<String?> station = const Value.absent(),
                Value<String?> comment = const Value.absent(),
              }) => FuelEntriesCompanion(
                id: id,
                carId: carId,
                date: date,
                mileage: mileage,
                liters: liters,
                pricePerLiter: pricePerLiter,
                totalCost: totalCost,
                isFullTank: isFullTank,
                station: station,
                comment: comment,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int carId,
                required DateTime date,
                required int mileage,
                required double liters,
                required double pricePerLiter,
                required double totalCost,
                required bool isFullTank,
                Value<String?> station = const Value.absent(),
                Value<String?> comment = const Value.absent(),
              }) => FuelEntriesCompanion.insert(
                id: id,
                carId: carId,
                date: date,
                mileage: mileage,
                liters: liters,
                pricePerLiter: pricePerLiter,
                totalCost: totalCost,
                isFullTank: isFullTank,
                station: station,
                comment: comment,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FuelEntriesTable, FuelEntryRecord>(table),
                  $$FuelEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({carId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (carId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.carId,
                        referencedTable: $$FuelEntriesTableReferences
                            ._carIdTable(db),
                        referencedColumn: $$FuelEntriesTableReferences
                            ._carIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FuelEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FuelEntriesTable,
      FuelEntryRecord,
      $$FuelEntriesTableFilterComposer,
      $$FuelEntriesTableOrderingComposer,
      $$FuelEntriesTableAnnotationComposer,
      $$FuelEntriesTableCreateCompanionBuilder,
      $$FuelEntriesTableUpdateCompanionBuilder,
      (FuelEntryRecord, $$FuelEntriesTableReferences),
      FuelEntryRecord,
      PrefetchHooks Function({bool carId})
    >;
typedef $$ExpensesTableCreateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  required int carId,
  required DateTime date,
  required ExpenseCategory category,
  required double amount,
  Value<int?> mileage,
  Value<String?> comment,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  Value<int> carId,
  Value<DateTime> date,
  Value<ExpenseCategory> category,
  Value<double> amount,
  Value<int?> mileage,
  Value<String?> comment,
});

final class $$ExpensesTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTable, ExpenseRecord> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CarsTable _carIdTable(_$AppDatabase db) =>
      db.cars.createAlias('expenses__car_id__cars__id');

  $$CarsTableProcessedTableManager get carId {
    final $_column = $_itemColumn<int>('car_id')!;

    final manager = $$CarsTableTableManager(
      $_db,
      $_db.cars,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_carIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ExpenseCategory, ExpenseCategory, String>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  $$CarsTableFilterComposer get carId {
    final $$CarsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableFilterComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  $$CarsTableOrderingComposer get carId {
    final $$CarsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableOrderingComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ExpenseCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get mileage =>
      $composableBuilder(column: $table.mileage, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  $$CarsTableAnnotationComposer get carId {
    final $$CarsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableAnnotationComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          ExpenseRecord,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (ExpenseRecord, $$ExpensesTableReferences),
          ExpenseRecord,
          PrefetchHooks Function({bool carId})
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> carId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<ExpenseCategory> category = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<int?> mileage = const Value.absent(),
                Value<String?> comment = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                carId: carId,
                date: date,
                category: category,
                amount: amount,
                mileage: mileage,
                comment: comment,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int carId,
                required DateTime date,
                required ExpenseCategory category,
                required double amount,
                Value<int?> mileage = const Value.absent(),
                Value<String?> comment = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                carId: carId,
                date: date,
                category: category,
                amount: amount,
                mileage: mileage,
                comment: comment,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExpensesTable, ExpenseRecord>(table),
                  $$ExpensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({carId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (carId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.carId,
                        referencedTable: $$ExpensesTableReferences._carIdTable(
                          db,
                        ),
                        referencedColumn: $$ExpensesTableReferences
                            ._carIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      ExpenseRecord,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (ExpenseRecord, $$ExpensesTableReferences),
      ExpenseRecord,
      PrefetchHooks Function({bool carId})
    >;
typedef $$RemindersTableCreateCompanionBuilder = RemindersCompanion Function({
  Value<int> id,
  required int carId,
  required String title,
  Value<int?> intervalKm,
  Value<int?> intervalMonths,
  required DateTime lastDoneDate,
  Value<int?> lastDoneMileage,
  Value<int> advanceDays,
  Value<int> advanceKm,
  Value<int?> notifiedDueMileage,
});
typedef $$RemindersTableUpdateCompanionBuilder = RemindersCompanion Function({
  Value<int> id,
  Value<int> carId,
  Value<String> title,
  Value<int?> intervalKm,
  Value<int?> intervalMonths,
  Value<DateTime> lastDoneDate,
  Value<int?> lastDoneMileage,
  Value<int> advanceDays,
  Value<int> advanceKm,
  Value<int?> notifiedDueMileage,
});

final class $$RemindersTableReferences
    extends BaseReferences<_$AppDatabase, $RemindersTable, ReminderRecord> {
  $$RemindersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CarsTable _carIdTable(_$AppDatabase db) =>
      db.cars.createAlias('reminders__car_id__cars__id');

  $$CarsTableProcessedTableManager get carId {
    final $_column = $_itemColumn<int>('car_id')!;

    final manager = $$CarsTableTableManager(
      $_db,
      $_db.cars,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_carIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ServiceRecordsTable, List<ServiceRecordRow>>
  _serviceRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.serviceRecords,
    aliasName: 'reminders__id__service_records__reminder_id',
  );

  $$ServiceRecordsTableProcessedTableManager get serviceRecordsRefs {
    final manager = $$ServiceRecordsTableTableManager(
      $_db,
      $_db.serviceRecords,
    ).filter((f) => f.reminderId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_serviceRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalKm => $composableBuilder(
    column: $table.intervalKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalMonths => $composableBuilder(
    column: $table.intervalMonths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastDoneDate => $composableBuilder(
    column: $table.lastDoneDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastDoneMileage => $composableBuilder(
    column: $table.lastDoneMileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get advanceDays => $composableBuilder(
    column: $table.advanceDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get advanceKm => $composableBuilder(
    column: $table.advanceKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notifiedDueMileage => $composableBuilder(
    column: $table.notifiedDueMileage,
    builder: (column) => ColumnFilters(column),
  );

  $$CarsTableFilterComposer get carId {
    final $$CarsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableFilterComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> serviceRecordsRefs(
    Expression<bool> Function($$ServiceRecordsTableFilterComposer f) f,
  ) {
    final $$ServiceRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.reminderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableFilterComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalKm => $composableBuilder(
    column: $table.intervalKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalMonths => $composableBuilder(
    column: $table.intervalMonths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastDoneDate => $composableBuilder(
    column: $table.lastDoneDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastDoneMileage => $composableBuilder(
    column: $table.lastDoneMileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get advanceDays => $composableBuilder(
    column: $table.advanceDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get advanceKm => $composableBuilder(
    column: $table.advanceKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notifiedDueMileage => $composableBuilder(
    column: $table.notifiedDueMileage,
    builder: (column) => ColumnOrderings(column),
  );

  $$CarsTableOrderingComposer get carId {
    final $$CarsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableOrderingComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get intervalKm => $composableBuilder(
    column: $table.intervalKm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalMonths => $composableBuilder(
    column: $table.intervalMonths,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastDoneDate => $composableBuilder(
    column: $table.lastDoneDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastDoneMileage => $composableBuilder(
    column: $table.lastDoneMileage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get advanceDays => $composableBuilder(
    column: $table.advanceDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get advanceKm =>
      $composableBuilder(column: $table.advanceKm, builder: (column) => column);

  GeneratedColumn<int> get notifiedDueMileage => $composableBuilder(
    column: $table.notifiedDueMileage,
    builder: (column) => column,
  );

  $$CarsTableAnnotationComposer get carId {
    final $$CarsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableAnnotationComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> serviceRecordsRefs<T extends Object>(
    Expression<T> Function($$ServiceRecordsTableAnnotationComposer a) f,
  ) {
    final $$ServiceRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.reminderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          ReminderRecord,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (ReminderRecord, $$RemindersTableReferences),
          ReminderRecord,
          PrefetchHooks Function({bool carId, bool serviceRecordsRefs})
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> carId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int?> intervalKm = const Value.absent(),
                Value<int?> intervalMonths = const Value.absent(),
                Value<DateTime> lastDoneDate = const Value.absent(),
                Value<int?> lastDoneMileage = const Value.absent(),
                Value<int> advanceDays = const Value.absent(),
                Value<int> advanceKm = const Value.absent(),
                Value<int?> notifiedDueMileage = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                carId: carId,
                title: title,
                intervalKm: intervalKm,
                intervalMonths: intervalMonths,
                lastDoneDate: lastDoneDate,
                lastDoneMileage: lastDoneMileage,
                advanceDays: advanceDays,
                advanceKm: advanceKm,
                notifiedDueMileage: notifiedDueMileage,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int carId,
                required String title,
                Value<int?> intervalKm = const Value.absent(),
                Value<int?> intervalMonths = const Value.absent(),
                required DateTime lastDoneDate,
                Value<int?> lastDoneMileage = const Value.absent(),
                Value<int> advanceDays = const Value.absent(),
                Value<int> advanceKm = const Value.absent(),
                Value<int?> notifiedDueMileage = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                carId: carId,
                title: title,
                intervalKm: intervalKm,
                intervalMonths: intervalMonths,
                lastDoneDate: lastDoneDate,
                lastDoneMileage: lastDoneMileage,
                advanceDays: advanceDays,
                advanceKm: advanceKm,
                notifiedDueMileage: notifiedDueMileage,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RemindersTable, ReminderRecord>(table),
                  $$RemindersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({carId = false, serviceRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (serviceRecordsRefs) db.serviceRecords,
              ],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (carId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.carId,
                        referencedTable: $$RemindersTableReferences._carIdTable(
                          db,
                        ),
                        referencedColumn: $$RemindersTableReferences
                            ._carIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (serviceRecordsRefs)
                    await $_getPrefetchedData<
                      ReminderRecord,
                      $RemindersTable,
                      ServiceRecordRow
                    >(
                      currentTable: table,
                      referencedTable: $$RemindersTableReferences
                          ._serviceRecordsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RemindersTableReferences(
                            db,
                            table,
                            p0,
                          ).serviceRecordsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.reminderId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      ReminderRecord,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (ReminderRecord, $$RemindersTableReferences),
      ReminderRecord,
      PrefetchHooks Function({bool carId, bool serviceRecordsRefs})
    >;
typedef $$ServiceRecordsTableCreateCompanionBuilder =
    ServiceRecordsCompanion Function({
      Value<int> id,
      required int carId,
      Value<int?> reminderId,
      required String title,
      required DateTime date,
      required int mileage,
      Value<double?> cost,
      Value<String?> station,
      Value<String?> comment,
    });
typedef $$ServiceRecordsTableUpdateCompanionBuilder =
    ServiceRecordsCompanion Function({
      Value<int> id,
      Value<int> carId,
      Value<int?> reminderId,
      Value<String> title,
      Value<DateTime> date,
      Value<int> mileage,
      Value<double?> cost,
      Value<String?> station,
      Value<String?> comment,
    });

final class $$ServiceRecordsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ServiceRecordsTable, ServiceRecordRow> {
  $$ServiceRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CarsTable _carIdTable(_$AppDatabase db) =>
      db.cars.createAlias('service_records__car_id__cars__id');

  $$CarsTableProcessedTableManager get carId {
    final $_column = $_itemColumn<int>('car_id')!;

    final manager = $$CarsTableTableManager(
      $_db,
      $_db.cars,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_carIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RemindersTable _reminderIdTable(_$AppDatabase db) =>
      db.reminders.createAlias('service_records__reminder_id__reminders__id');

  $$RemindersTableProcessedTableManager? get reminderId {
    final $_column = $_itemColumn<int>('reminder_id');
    if ($_column == null) return null;
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reminderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ServiceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ServiceRecordsTable> {
  $$ServiceRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get station => $composableBuilder(
    column: $table.station,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  $$CarsTableFilterComposer get carId {
    final $$CarsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableFilterComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RemindersTableFilterComposer get reminderId {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reminderId,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServiceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ServiceRecordsTable> {
  $$ServiceRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get station => $composableBuilder(
    column: $table.station,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  $$CarsTableOrderingComposer get carId {
    final $$CarsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableOrderingComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RemindersTableOrderingComposer get reminderId {
    final $$RemindersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reminderId,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableOrderingComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServiceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServiceRecordsTable> {
  $$ServiceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get mileage =>
      $composableBuilder(column: $table.mileage, builder: (column) => column);

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<String> get station =>
      $composableBuilder(column: $table.station, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  $$CarsTableAnnotationComposer get carId {
    final $$CarsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carId,
      referencedTable: $db.cars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarsTableAnnotationComposer(
            $db: $db,
            $table: $db.cars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RemindersTableAnnotationComposer get reminderId {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reminderId,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServiceRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServiceRecordsTable,
          ServiceRecordRow,
          $$ServiceRecordsTableFilterComposer,
          $$ServiceRecordsTableOrderingComposer,
          $$ServiceRecordsTableAnnotationComposer,
          $$ServiceRecordsTableCreateCompanionBuilder,
          $$ServiceRecordsTableUpdateCompanionBuilder,
          (ServiceRecordRow, $$ServiceRecordsTableReferences),
          ServiceRecordRow,
          PrefetchHooks Function({bool carId, bool reminderId})
        > {
  $$ServiceRecordsTableTableManager(
    _$AppDatabase db,
    $ServiceRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServiceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServiceRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> carId = const Value.absent(),
                Value<int?> reminderId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> mileage = const Value.absent(),
                Value<double?> cost = const Value.absent(),
                Value<String?> station = const Value.absent(),
                Value<String?> comment = const Value.absent(),
              }) => ServiceRecordsCompanion(
                id: id,
                carId: carId,
                reminderId: reminderId,
                title: title,
                date: date,
                mileage: mileage,
                cost: cost,
                station: station,
                comment: comment,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int carId,
                Value<int?> reminderId = const Value.absent(),
                required String title,
                required DateTime date,
                required int mileage,
                Value<double?> cost = const Value.absent(),
                Value<String?> station = const Value.absent(),
                Value<String?> comment = const Value.absent(),
              }) => ServiceRecordsCompanion.insert(
                id: id,
                carId: carId,
                reminderId: reminderId,
                title: title,
                date: date,
                mileage: mileage,
                cost: cost,
                station: station,
                comment: comment,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ServiceRecordsTable, ServiceRecordRow>(table),
                  $$ServiceRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({carId = false, reminderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (carId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.carId,
                        referencedTable: $$ServiceRecordsTableReferences
                            ._carIdTable(db),
                        referencedColumn: $$ServiceRecordsTableReferences
                            ._carIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (reminderId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.reminderId,
                        referencedTable: $$ServiceRecordsTableReferences
                            ._reminderIdTable(db),
                        referencedColumn: $$ServiceRecordsTableReferences
                            ._reminderIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ServiceRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServiceRecordsTable,
      ServiceRecordRow,
      $$ServiceRecordsTableFilterComposer,
      $$ServiceRecordsTableOrderingComposer,
      $$ServiceRecordsTableAnnotationComposer,
      $$ServiceRecordsTableCreateCompanionBuilder,
      $$ServiceRecordsTableUpdateCompanionBuilder,
      (ServiceRecordRow, $$ServiceRecordsTableReferences),
      ServiceRecordRow,
      PrefetchHooks Function({bool carId, bool reminderId})
    >;
typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          SettingEntry,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (
            SettingEntry,
            BaseReferences<_$AppDatabase, $SettingsTable, SettingEntry>,
          ),
          SettingEntry,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => SettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) => SettingsCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsTable, SettingEntry>(table),
                  BaseReferences<_$AppDatabase, $SettingsTable, SettingEntry>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      SettingEntry,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (
        SettingEntry,
        BaseReferences<_$AppDatabase, $SettingsTable, SettingEntry>,
      ),
      SettingEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CarsTableTableManager get cars => $$CarsTableTableManager(_db, _db.cars);
  $$FuelEntriesTableTableManager get fuelEntries =>
      $$FuelEntriesTableTableManager(_db, _db.fuelEntries);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$ServiceRecordsTableTableManager get serviceRecords =>
      $$ServiceRecordsTableTableManager(_db, _db.serviceRecords);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
