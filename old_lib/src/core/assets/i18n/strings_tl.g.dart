///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsTl with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsTl({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.tl,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <tl>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsTl _root = this; // ignore: unused_field

	@override 
	TranslationsTl $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsTl(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAuthenticationTl authentication = _TranslationsAuthenticationTl._(_root);
	@override late final _TranslationsCommonTl common = _TranslationsCommonTl._(_root);
	@override late final _TranslationsFieldsTl fields = _TranslationsFieldsTl._(_root);
}

// Path: authentication
class _TranslationsAuthenticationTl implements TranslationsAuthenticationEn {
	_TranslationsAuthenticationTl._(this._root);

	final TranslationsTl _root; // ignore: unused_field

	// Translations
	@override String get login => 'Mag-log in';
	@override List<String> get loginAsAdminList => [
		'Hindi ka user?',
		'Mag-log in bilang Tagapamahala',
	];
	@override List<String> get returnToLoginAsUser => [
		'Hindi ka tagapamahala? ',
		'Mag-log in bilang User',
	];
	@override String get loginSuccess => 'Nagtagumpay sa pag-log in';
}

// Path: common
class _TranslationsCommonTl implements TranslationsCommonEn {
	_TranslationsCommonTl._(this._root);

	final TranslationsTl _root; // ignore: unused_field

	// Translations
	@override String get appName => 'SannJoseVet';
	@override String get placeholderText => 'N/A';
}

// Path: fields
class _TranslationsFieldsTl implements TranslationsFieldsEn {
	_TranslationsFieldsTl._(this._root);

	final TranslationsTl _root; // ignore: unused_field

	// Translations
	@override String get email => 'Email';
	@override String get password => 'Password';
	@override String get passwordConfirmation => 'Password confirmation';
	@override String get name => 'Name';
}

/// The flat map containing all translations for locale <tl>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsTl {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'authentication.login' => 'Mag-log in',
			'authentication.loginAsAdminList.0' => 'Hindi ka user?',
			'authentication.loginAsAdminList.1' => 'Mag-log in bilang Tagapamahala',
			'authentication.returnToLoginAsUser.0' => 'Hindi ka tagapamahala? ',
			'authentication.returnToLoginAsUser.1' => 'Mag-log in bilang User',
			'authentication.loginSuccess' => 'Nagtagumpay sa pag-log in',
			'common.appName' => 'SannJoseVet',
			'common.placeholderText' => 'N/A',
			'fields.email' => 'Email',
			'fields.password' => 'Password',
			'fields.passwordConfirmation' => 'Password confirmation',
			'fields.name' => 'Name',
			_ => null,
		};
	}
}
