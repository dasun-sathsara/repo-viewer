// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'github_repo_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GithubRepoDetail {
  String get fullName => throw _privateConstructorUsedError;
  String get html => throw _privateConstructorUsedError;
  bool get starred => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GithubRepoDetailCopyWith<GithubRepoDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GithubRepoDetailCopyWith<$Res> {
  factory $GithubRepoDetailCopyWith(
          GithubRepoDetail value, $Res Function(GithubRepoDetail) then) =
      _$GithubRepoDetailCopyWithImpl<$Res, GithubRepoDetail>;
  @useResult
  $Res call({String fullName, String html, bool starred});
}

/// @nodoc
class _$GithubRepoDetailCopyWithImpl<$Res, $Val extends GithubRepoDetail>
    implements $GithubRepoDetailCopyWith<$Res> {
  _$GithubRepoDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? html = null,
    Object? starred = null,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      html: null == html
          ? _value.html
          : html // ignore: cast_nullable_to_non_nullable
              as String,
      starred: null == starred
          ? _value.starred
          : starred // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GithubRepoDetailCopyWith<$Res>
    implements $GithubRepoDetailCopyWith<$Res> {
  factory _$$_GithubRepoDetailCopyWith(
          _$_GithubRepoDetail value, $Res Function(_$_GithubRepoDetail) then) =
      __$$_GithubRepoDetailCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fullName, String html, bool starred});
}

/// @nodoc
class __$$_GithubRepoDetailCopyWithImpl<$Res>
    extends _$GithubRepoDetailCopyWithImpl<$Res, _$_GithubRepoDetail>
    implements _$$_GithubRepoDetailCopyWith<$Res> {
  __$$_GithubRepoDetailCopyWithImpl(
      _$_GithubRepoDetail _value, $Res Function(_$_GithubRepoDetail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? html = null,
    Object? starred = null,
  }) {
    return _then(_$_GithubRepoDetail(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      html: null == html
          ? _value.html
          : html // ignore: cast_nullable_to_non_nullable
              as String,
      starred: null == starred
          ? _value.starred
          : starred // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_GithubRepoDetail extends _GithubRepoDetail {
  const _$_GithubRepoDetail(
      {required this.fullName, required this.html, required this.starred})
      : super._();

  @override
  final String fullName;
  @override
  final String html;
  @override
  final bool starred;

  @override
  String toString() {
    return 'GithubRepoDetail(fullName: $fullName, html: $html, starred: $starred)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GithubRepoDetail &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.html, html) || other.html == html) &&
            (identical(other.starred, starred) || other.starred == starred));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fullName, html, starred);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GithubRepoDetailCopyWith<_$_GithubRepoDetail> get copyWith =>
      __$$_GithubRepoDetailCopyWithImpl<_$_GithubRepoDetail>(this, _$identity);
}

abstract class _GithubRepoDetail extends GithubRepoDetail {
  const factory _GithubRepoDetail(
      {required final String fullName,
      required final String html,
      required final bool starred}) = _$_GithubRepoDetail;
  const _GithubRepoDetail._() : super._();

  @override
  String get fullName;
  @override
  String get html;
  @override
  bool get starred;
  @override
  @JsonKey(ignore: true)
  _$$_GithubRepoDetailCopyWith<_$_GithubRepoDetail> get copyWith =>
      throw _privateConstructorUsedError;
}
