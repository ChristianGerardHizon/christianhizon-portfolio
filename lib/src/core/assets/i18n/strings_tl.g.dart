///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsTl implements Translations {
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
	@override late final _TranslationsFailuresTl failures = _TranslationsFailuresTl._(_root);
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
}

// Path: failures
class _TranslationsFailuresTl implements TranslationsFailuresEn {
	_TranslationsFailuresTl._(this._root);

	final TranslationsTl _root; // ignore: unused_field

	// Translations
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

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsTl {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'authentication.login': return 'Mag-log in';
			case 'authentication.loginAsAdminList.0': return 'Hindi ka user?';
			case 'authentication.loginAsAdminList.1': return 'Mag-log in bilang Tagapamahala';
			case 'authentication.returnToLoginAsUser.0': return 'Hindi ka tagapamahala? ';
			case 'authentication.returnToLoginAsUser.1': return 'Mag-log in bilang User';
			case 'authentication.loginSuccess': return 'Nagtagumpay sa pag-log in';
			case 'fields.email': return 'Email';
			case 'fields.password': return 'Password';
			case 'fields.passwordConfirmation': return 'Password confirmation';
			case 'fields.name': return 'Name';
			default: return null;
		}
	}
}

