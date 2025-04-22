///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsAuthenticationEn authentication = TranslationsAuthenticationEn._(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
	late final TranslationsFailuresEn failures = TranslationsFailuresEn._(_root);
	late final TranslationsFieldsEn fields = TranslationsFieldsEn._(_root);
}

// Path: authentication
class TranslationsAuthenticationEn {
	TranslationsAuthenticationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get login => 'Login';
	List<String> get loginAsAdminList => [
		'Not a user?',
		'Login as Administrator',
	];
	String get loginSuccess => 'Logged in successfully';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
}

// Path: failures
class TranslationsFailuresEn {
	TranslationsFailuresEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
}

// Path: fields
class TranslationsFieldsEn {
	TranslationsFieldsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get email => 'Email';
	String get password => 'Password';
	String get passwordConfirmation => 'Password confirmation';
	String get name => 'Name';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'authentication.login': return 'Login';
			case 'authentication.loginAsAdminList.0': return 'Not a user?';
			case 'authentication.loginAsAdminList.1': return 'Login as Administrator';
			case 'authentication.loginSuccess': return 'Logged in successfully';
			case 'fields.email': return 'Email';
			case 'fields.password': return 'Password';
			case 'fields.passwordConfirmation': return 'Password confirmation';
			case 'fields.name': return 'Name';
			default: return null;
		}
	}
}

