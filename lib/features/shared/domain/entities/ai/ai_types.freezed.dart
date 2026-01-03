// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AIRequest _$AIRequestFromJson(Map<String, dynamic> json) {
  return _AIRequest.fromJson(json);
}

/// @nodoc
mixin _$AIRequest {
  String get systemPrompt => throw _privateConstructorUsedError;
  String get taskPrompt => throw _privateConstructorUsedError;
  Map<String, dynamic> get context => throw _privateConstructorUsedError;
  Map<String, dynamic>? get responseSchema =>
      throw _privateConstructorUsedError;
  List<FunctionDeclaration>? get tools => throw _privateConstructorUsedError;

  /// Serializes this AIRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIRequestCopyWith<AIRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIRequestCopyWith<$Res> {
  factory $AIRequestCopyWith(AIRequest value, $Res Function(AIRequest) then) =
      _$AIRequestCopyWithImpl<$Res, AIRequest>;
  @useResult
  $Res call(
      {String systemPrompt,
      String taskPrompt,
      Map<String, dynamic> context,
      Map<String, dynamic>? responseSchema,
      List<FunctionDeclaration>? tools});
}

/// @nodoc
class _$AIRequestCopyWithImpl<$Res, $Val extends AIRequest>
    implements $AIRequestCopyWith<$Res> {
  _$AIRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? systemPrompt = null,
    Object? taskPrompt = null,
    Object? context = null,
    Object? responseSchema = freezed,
    Object? tools = freezed,
  }) {
    return _then(_value.copyWith(
      systemPrompt: null == systemPrompt
          ? _value.systemPrompt
          : systemPrompt // ignore: cast_nullable_to_non_nullable
              as String,
      taskPrompt: null == taskPrompt
          ? _value.taskPrompt
          : taskPrompt // ignore: cast_nullable_to_non_nullable
              as String,
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      responseSchema: freezed == responseSchema
          ? _value.responseSchema
          : responseSchema // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      tools: freezed == tools
          ? _value.tools
          : tools // ignore: cast_nullable_to_non_nullable
              as List<FunctionDeclaration>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIRequestImplCopyWith<$Res>
    implements $AIRequestCopyWith<$Res> {
  factory _$$AIRequestImplCopyWith(
          _$AIRequestImpl value, $Res Function(_$AIRequestImpl) then) =
      __$$AIRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String systemPrompt,
      String taskPrompt,
      Map<String, dynamic> context,
      Map<String, dynamic>? responseSchema,
      List<FunctionDeclaration>? tools});
}

/// @nodoc
class __$$AIRequestImplCopyWithImpl<$Res>
    extends _$AIRequestCopyWithImpl<$Res, _$AIRequestImpl>
    implements _$$AIRequestImplCopyWith<$Res> {
  __$$AIRequestImplCopyWithImpl(
      _$AIRequestImpl _value, $Res Function(_$AIRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of AIRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? systemPrompt = null,
    Object? taskPrompt = null,
    Object? context = null,
    Object? responseSchema = freezed,
    Object? tools = freezed,
  }) {
    return _then(_$AIRequestImpl(
      systemPrompt: null == systemPrompt
          ? _value.systemPrompt
          : systemPrompt // ignore: cast_nullable_to_non_nullable
              as String,
      taskPrompt: null == taskPrompt
          ? _value.taskPrompt
          : taskPrompt // ignore: cast_nullable_to_non_nullable
              as String,
      context: null == context
          ? _value._context
          : context // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      responseSchema: freezed == responseSchema
          ? _value._responseSchema
          : responseSchema // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      tools: freezed == tools
          ? _value._tools
          : tools // ignore: cast_nullable_to_non_nullable
              as List<FunctionDeclaration>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIRequestImpl implements _AIRequest {
  const _$AIRequestImpl(
      {required this.systemPrompt,
      required this.taskPrompt,
      required final Map<String, dynamic> context,
      final Map<String, dynamic>? responseSchema,
      final List<FunctionDeclaration>? tools})
      : _context = context,
        _responseSchema = responseSchema,
        _tools = tools;

  factory _$AIRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIRequestImplFromJson(json);

  @override
  final String systemPrompt;
  @override
  final String taskPrompt;
  final Map<String, dynamic> _context;
  @override
  Map<String, dynamic> get context {
    if (_context is EqualUnmodifiableMapView) return _context;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_context);
  }

  final Map<String, dynamic>? _responseSchema;
  @override
  Map<String, dynamic>? get responseSchema {
    final value = _responseSchema;
    if (value == null) return null;
    if (_responseSchema is EqualUnmodifiableMapView) return _responseSchema;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<FunctionDeclaration>? _tools;
  @override
  List<FunctionDeclaration>? get tools {
    final value = _tools;
    if (value == null) return null;
    if (_tools is EqualUnmodifiableListView) return _tools;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AIRequest(systemPrompt: $systemPrompt, taskPrompt: $taskPrompt, context: $context, responseSchema: $responseSchema, tools: $tools)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIRequestImpl &&
            (identical(other.systemPrompt, systemPrompt) ||
                other.systemPrompt == systemPrompt) &&
            (identical(other.taskPrompt, taskPrompt) ||
                other.taskPrompt == taskPrompt) &&
            const DeepCollectionEquality().equals(other._context, _context) &&
            const DeepCollectionEquality()
                .equals(other._responseSchema, _responseSchema) &&
            const DeepCollectionEquality().equals(other._tools, _tools));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      systemPrompt,
      taskPrompt,
      const DeepCollectionEquality().hash(_context),
      const DeepCollectionEquality().hash(_responseSchema),
      const DeepCollectionEquality().hash(_tools));

  /// Create a copy of AIRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIRequestImplCopyWith<_$AIRequestImpl> get copyWith =>
      __$$AIRequestImplCopyWithImpl<_$AIRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIRequestImplToJson(
      this,
    );
  }
}

abstract class _AIRequest implements AIRequest {
  const factory _AIRequest(
      {required final String systemPrompt,
      required final String taskPrompt,
      required final Map<String, dynamic> context,
      final Map<String, dynamic>? responseSchema,
      final List<FunctionDeclaration>? tools}) = _$AIRequestImpl;

  factory _AIRequest.fromJson(Map<String, dynamic> json) =
      _$AIRequestImpl.fromJson;

  @override
  String get systemPrompt;
  @override
  String get taskPrompt;
  @override
  Map<String, dynamic> get context;
  @override
  Map<String, dynamic>? get responseSchema;
  @override
  List<FunctionDeclaration>? get tools;

  /// Create a copy of AIRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIRequestImplCopyWith<_$AIRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AIResponse<T> {
  T? get data => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  FunctionCall? get functionCall => throw _privateConstructorUsedError;
  int get tokensUsed => throw _privateConstructorUsedError;
  double? get totalCost => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Create a copy of AIResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIResponseCopyWith<T, AIResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIResponseCopyWith<T, $Res> {
  factory $AIResponseCopyWith(
          AIResponse<T> value, $Res Function(AIResponse<T>) then) =
      _$AIResponseCopyWithImpl<T, $Res, AIResponse<T>>;
  @useResult
  $Res call(
      {T? data,
      String? text,
      FunctionCall? functionCall,
      int tokensUsed,
      double? totalCost,
      DateTime timestamp});

  $FunctionCallCopyWith<$Res>? get functionCall;
}

/// @nodoc
class _$AIResponseCopyWithImpl<T, $Res, $Val extends AIResponse<T>>
    implements $AIResponseCopyWith<T, $Res> {
  _$AIResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? text = freezed,
    Object? functionCall = freezed,
    Object? tokensUsed = null,
    Object? totalCost = freezed,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      functionCall: freezed == functionCall
          ? _value.functionCall
          : functionCall // ignore: cast_nullable_to_non_nullable
              as FunctionCall?,
      tokensUsed: null == tokensUsed
          ? _value.tokensUsed
          : tokensUsed // ignore: cast_nullable_to_non_nullable
              as int,
      totalCost: freezed == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of AIResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FunctionCallCopyWith<$Res>? get functionCall {
    if (_value.functionCall == null) {
      return null;
    }

    return $FunctionCallCopyWith<$Res>(_value.functionCall!, (value) {
      return _then(_value.copyWith(functionCall: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AIResponseImplCopyWith<T, $Res>
    implements $AIResponseCopyWith<T, $Res> {
  factory _$$AIResponseImplCopyWith(
          _$AIResponseImpl<T> value, $Res Function(_$AIResponseImpl<T>) then) =
      __$$AIResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {T? data,
      String? text,
      FunctionCall? functionCall,
      int tokensUsed,
      double? totalCost,
      DateTime timestamp});

  @override
  $FunctionCallCopyWith<$Res>? get functionCall;
}

/// @nodoc
class __$$AIResponseImplCopyWithImpl<T, $Res>
    extends _$AIResponseCopyWithImpl<T, $Res, _$AIResponseImpl<T>>
    implements _$$AIResponseImplCopyWith<T, $Res> {
  __$$AIResponseImplCopyWithImpl(
      _$AIResponseImpl<T> _value, $Res Function(_$AIResponseImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of AIResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? text = freezed,
    Object? functionCall = freezed,
    Object? tokensUsed = null,
    Object? totalCost = freezed,
    Object? timestamp = null,
  }) {
    return _then(_$AIResponseImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      functionCall: freezed == functionCall
          ? _value.functionCall
          : functionCall // ignore: cast_nullable_to_non_nullable
              as FunctionCall?,
      tokensUsed: null == tokensUsed
          ? _value.tokensUsed
          : tokensUsed // ignore: cast_nullable_to_non_nullable
              as int,
      totalCost: freezed == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$AIResponseImpl<T> implements _AIResponse<T> {
  const _$AIResponseImpl(
      {this.data,
      this.text,
      this.functionCall,
      required this.tokensUsed,
      this.totalCost,
      required this.timestamp});

  @override
  final T? data;
  @override
  final String? text;
  @override
  final FunctionCall? functionCall;
  @override
  final int tokensUsed;
  @override
  final double? totalCost;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'AIResponse<$T>(data: $data, text: $text, functionCall: $functionCall, tokensUsed: $tokensUsed, totalCost: $totalCost, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIResponseImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.functionCall, functionCall) ||
                other.functionCall == functionCall) &&
            (identical(other.tokensUsed, tokensUsed) ||
                other.tokensUsed == tokensUsed) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      text,
      functionCall,
      tokensUsed,
      totalCost,
      timestamp);

  /// Create a copy of AIResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIResponseImplCopyWith<T, _$AIResponseImpl<T>> get copyWith =>
      __$$AIResponseImplCopyWithImpl<T, _$AIResponseImpl<T>>(this, _$identity);
}

abstract class _AIResponse<T> implements AIResponse<T> {
  const factory _AIResponse(
      {final T? data,
      final String? text,
      final FunctionCall? functionCall,
      required final int tokensUsed,
      final double? totalCost,
      required final DateTime timestamp}) = _$AIResponseImpl<T>;

  @override
  T? get data;
  @override
  String? get text;
  @override
  FunctionCall? get functionCall;
  @override
  int get tokensUsed;
  @override
  double? get totalCost;
  @override
  DateTime get timestamp;

  /// Create a copy of AIResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIResponseImplCopyWith<T, _$AIResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

FunctionDeclaration _$FunctionDeclarationFromJson(Map<String, dynamic> json) {
  return _FunctionDeclaration.fromJson(json);
}

/// @nodoc
mixin _$FunctionDeclaration {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, dynamic> get parameters => throw _privateConstructorUsedError;

  /// Serializes this FunctionDeclaration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FunctionDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FunctionDeclarationCopyWith<FunctionDeclaration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FunctionDeclarationCopyWith<$Res> {
  factory $FunctionDeclarationCopyWith(
          FunctionDeclaration value, $Res Function(FunctionDeclaration) then) =
      _$FunctionDeclarationCopyWithImpl<$Res, FunctionDeclaration>;
  @useResult
  $Res call({String name, String description, Map<String, dynamic> parameters});
}

/// @nodoc
class _$FunctionDeclarationCopyWithImpl<$Res, $Val extends FunctionDeclaration>
    implements $FunctionDeclarationCopyWith<$Res> {
  _$FunctionDeclarationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FunctionDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? parameters = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FunctionDeclarationImplCopyWith<$Res>
    implements $FunctionDeclarationCopyWith<$Res> {
  factory _$$FunctionDeclarationImplCopyWith(_$FunctionDeclarationImpl value,
          $Res Function(_$FunctionDeclarationImpl) then) =
      __$$FunctionDeclarationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String description, Map<String, dynamic> parameters});
}

/// @nodoc
class __$$FunctionDeclarationImplCopyWithImpl<$Res>
    extends _$FunctionDeclarationCopyWithImpl<$Res, _$FunctionDeclarationImpl>
    implements _$$FunctionDeclarationImplCopyWith<$Res> {
  __$$FunctionDeclarationImplCopyWithImpl(_$FunctionDeclarationImpl _value,
      $Res Function(_$FunctionDeclarationImpl) _then)
      : super(_value, _then);

  /// Create a copy of FunctionDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? parameters = null,
  }) {
    return _then(_$FunctionDeclarationImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FunctionDeclarationImpl implements _FunctionDeclaration {
  const _$FunctionDeclarationImpl(
      {required this.name,
      required this.description,
      required final Map<String, dynamic> parameters})
      : _parameters = parameters;

  factory _$FunctionDeclarationImpl.fromJson(Map<String, dynamic> json) =>
      _$$FunctionDeclarationImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  final Map<String, dynamic> _parameters;
  @override
  Map<String, dynamic> get parameters {
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parameters);
  }

  @override
  String toString() {
    return 'FunctionDeclaration(name: $name, description: $description, parameters: $parameters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FunctionDeclarationImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description,
      const DeepCollectionEquality().hash(_parameters));

  /// Create a copy of FunctionDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FunctionDeclarationImplCopyWith<_$FunctionDeclarationImpl> get copyWith =>
      __$$FunctionDeclarationImplCopyWithImpl<_$FunctionDeclarationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FunctionDeclarationImplToJson(
      this,
    );
  }
}

abstract class _FunctionDeclaration implements FunctionDeclaration {
  const factory _FunctionDeclaration(
          {required final String name,
          required final String description,
          required final Map<String, dynamic> parameters}) =
      _$FunctionDeclarationImpl;

  factory _FunctionDeclaration.fromJson(Map<String, dynamic> json) =
      _$FunctionDeclarationImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  Map<String, dynamic> get parameters;

  /// Create a copy of FunctionDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FunctionDeclarationImplCopyWith<_$FunctionDeclarationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
