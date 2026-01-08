///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
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
	late final TranslationsFieldsEn fields = TranslationsFieldsEn._(_root);
}

// Path: authentication
class TranslationsAuthenticationEn {
	TranslationsAuthenticationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Login'
	String get login => 'Login';

	List<String> get loginAsAdminList => [
		'Not a user? ',
		'Login as Administrator',
	];
	List<String> get returnToLoginAsUser => [
		'Not an administrator? ',
		'Login as User',
	];

	/// en: 'Logged in successfully'
	String get loginSuccess => 'Logged in successfully';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'SannJoseVet'
	String get appName => 'SannJoseVet';

	/// en: 'N/A'
	String get placeholderText => 'N/A';
}

// Path: fields
class TranslationsFieldsEn {
	TranslationsFieldsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Password confirmation'
	String get passwordConfirmation => 'Password confirmation';

	/// en: 'Name'
	String get name => 'Name';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'authentication.login' => 'Login',
			'authentication.loginAsAdminList.0' => 'Not a user? ',
			'authentication.loginAsAdminList.1' => 'Login as Administrator',
			'authentication.returnToLoginAsUser.0' => 'Not an administrator? ',
			'authentication.returnToLoginAsUser.1' => 'Login as User',
			'authentication.loginSuccess' => 'Logged in successfully',
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
