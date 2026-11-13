import Kebab
import LowerCamel
import ShoutyKebab
import ShoutySnake
import Snake
import Title
import Train
import UpperCamel
import Utils exposing [is_alphanumeric, is_lowercase, is_uppercase]

## Case conversion functions, based on the Rust [heck](https://crates.io/crates/heck) crate.
Heck :: [].{

	## Convert a string to `kebab-case`.
	## ```
	## expect Heck.to_kebab_case("XMLHttpRequest") == "xml-http-request"
	## ```
	to_kebab_case : Str -> Str
	to_kebab_case = |s| transform(s, Kebab.with_word, Kebab.boundary)

	## Convert a string to `lowerCamelCase`.
	## ```
	## expect Heck.to_lower_camel_case("XMLHttpRequest") == "xmlHttpRequest"
	## ```
	to_lower_camel_case : Str -> Str
	to_lower_camel_case = |s| transform(s, LowerCamel.with_word, LowerCamel.boundary)

	## Convert a string to `PascalCase`. Alias of `to_upper_camel_case`.
	## ```
	## expect Heck.to_pascal_case("XMLHttpRequest") == "XmlHttpRequest"
	## ```
	to_pascal_case : Str -> Str
	to_pascal_case = |s| to_upper_camel_case(s)

	## Convert a string to `SHOUTY-KEBAB-CASE`.
	## ```
	## expect Heck.to_shouty_kebab_case("XMLHttpRequest") == "XML-HTTP-REQUEST"
	## ```
	to_shouty_kebab_case : Str -> Str
	to_shouty_kebab_case = |s| transform(s, ShoutyKebab.with_word, ShoutyKebab.boundary)

	## Convert a string to `SHOUTY_SNAKE_CASE`.
	## ```
	## expect Heck.to_shouty_snake_case("XMLHttpRequest") == "XML_HTTP_REQUEST"
	## ```
	to_shouty_snake_case : Str -> Str
	to_shouty_snake_case = |s| transform(s, ShoutySnake.with_word, ShoutySnake.boundary)

	## Convert a string to `SHOUTY_SNEK_CASE`. Alias of `to_shouty_snake_case`.
	## ```
	## expect Heck.to_shouty_snek_case("XMLHttpRequest") == "XML_HTTP_REQUEST"
	## ```
	to_shouty_snek_case : Str -> Str
	to_shouty_snek_case = |s| to_shouty_snake_case(s)

	## Convert a string to `snake_case`.
	## ```
	## expect Heck.to_snake_case("XMLHttpRequest") == "xml_http_request"
	## ```
	to_snake_case : Str -> Str
	to_snake_case = |s| transform(s, Snake.with_word, Snake.boundary)

	## Convert a string to `snek_case`. Alias of `to_snake_case`.
	## ```
	## expect Heck.to_snek_case("XMLHttpRequest") == "xml_http_request"
	## ```
	to_snek_case : Str -> Str
	to_snek_case = |s| to_snake_case(s)

	## Convert a string to `Title Case`.
	## ```
	## expect Heck.to_title_case("XMLHttpRequest") == "Xml Http Request"
	## ```
	to_title_case : Str -> Str
	to_title_case = |s| transform(s, Title.with_word, Title.boundary)

	## Convert a string to `Train-Case`.
	## ```
	## expect Heck.to_train_case("XMLHttpRequest") == "Xml-Http-Request"
	## ```
	to_train_case : Str -> Str
	to_train_case = |s| transform(s, Train.with_word, Train.boundary)

	## Convert a string to `UpperCamelCase`.
	## ```
	## expect Heck.to_upper_camel_case("XMLHttpRequest") == "XmlHttpRequest"
	## ```
	to_upper_camel_case : Str -> Str
	to_upper_camel_case = |s| transform(s, UpperCamel.with_word, UpperCamel.boundary)
}

## Appends a transformed word to the accumulated output.
## Receives the words so far, the raw word bytes, and whether this is the first word.
WithWord : List(List(U8)), List(U8), Bool -> List(List(U8))

## Appends a word separator to the accumulated output.
Boundary : List(List(U8)) -> List(List(U8))

Mode : [Boundary, Lowercase, Uppercase]

## Split `s` into words and rebuild it using the given `with_word` and `boundary` functions.
##
## Non-alphanumeric characters always separate words. Within a run of alphanumeric
## characters, a word boundary is inserted between a lowercase letter and an uppercase
## letter (`camelCase`), and before the last uppercase letter in a run of uppercase letters
## that is followed by a lowercase letter (`XMLHttp` -> `XML` `Http`).
transform : Str, WithWord, Boundary -> Str
transform = |s, with_word, boundary| {
	var $words : List(List(U8))
	var $words = []
	var $first_word = True

	for word in s.to_utf8().split_if(|c| !is_alphanumeric(c)) {
		var $mode : Mode
		var $mode = Boundary
		var $start = 0
		var $i = 0

		for c in word {
			next_i = $i + 1
			match word.get(next_i) {
				Ok(next) => {
					next_mode : Mode
					next_mode = if (is_lowercase(c)) Lowercase else if (is_uppercase(c)) Uppercase else $mode

					if next_mode == Lowercase and is_uppercase(next) {
						segment = word.sublist({ start: $start, len: next_i - $start })
						$words = push_word($words, segment, $first_word, with_word, boundary)
						$first_word = False
						$mode = Boundary
						$start = next_i
					} else if $mode == Uppercase and is_uppercase(c) and is_lowercase(next) {
						segment = word.sublist({ start: $start, len: $i - $start })
						$words = push_word($words, segment, $first_word, with_word, boundary)
						$first_word = False
						$mode = Boundary
						$start = $i
					} else {
						$mode = next_mode
					}
				}
				Err(OutOfBounds) => {
					segment = word.drop_first($start)
					$words = push_word($words, segment, $first_word, with_word, boundary)
					$first_word = False
				}
			}
			$i = next_i
		}
	}

	Str.from_utf8_lossy($words.join())
}

push_word : List(List(U8)), List(U8), Bool, WithWord, Boundary -> List(List(U8))
push_word = |words, segment, first_word, with_word, boundary| {
	separated = if (first_word) words else boundary(words)
	with_word(separated, segment, first_word)
}

expect Heck.to_kebab_case("CamelCase") == "camel-case"
expect Heck.to_kebab_case("This is Human case.") == "this-is-human-case"
expect Heck.to_kebab_case("MixedUP CamelCase, with some Spaces") == "mixed-up-camel-case-with-some-spaces"
expect Heck.to_kebab_case("mixed_up_ snake_case with some _spaces") == "mixed-up-snake-case-with-some-spaces"
expect Heck.to_kebab_case("kebab-case") == "kebab-case"
expect Heck.to_kebab_case("SHOUTY_SNAKE_CASE") == "shouty-snake-case"
expect Heck.to_kebab_case("snake_case") == "snake-case"
expect Heck.to_kebab_case("this-contains_ ALLKinds OfWord_Boundaries") == "this-contains-all-kinds-of-word-boundaries"
expect Heck.to_kebab_case("XMLHttpRequest") == "xml-http-request"
expect Heck.to_kebab_case("") == ""
expect Heck.to_kebab_case("  --__  ") == ""

expect Heck.to_lower_camel_case("CamelCase") == "camelCase"
expect Heck.to_lower_camel_case("This is Human case.") == "thisIsHumanCase"
expect Heck.to_lower_camel_case("MixedUP CamelCase, with some Spaces") == "mixedUpCamelCaseWithSomeSpaces"
expect Heck.to_lower_camel_case("mixed_up_ snake_case with some _spaces") == "mixedUpSnakeCaseWithSomeSpaces"
expect Heck.to_lower_camel_case("kebab-case") == "kebabCase"
expect Heck.to_lower_camel_case("SHOUTY_SNAKE_CASE") == "shoutySnakeCase"
expect Heck.to_lower_camel_case("snake_case") == "snakeCase"
expect Heck.to_lower_camel_case("this-contains_ ALLKinds OfWord_Boundaries") == "thisContainsAllKindsOfWordBoundaries"
expect Heck.to_lower_camel_case("XMLHttpRequest") == "xmlHttpRequest"

expect Heck.to_pascal_case("CamelCase") == "CamelCase"
expect Heck.to_pascal_case("This is Human case.") == "ThisIsHumanCase"
expect Heck.to_pascal_case("MixedUP CamelCase, with some Spaces") == "MixedUpCamelCaseWithSomeSpaces"
expect Heck.to_pascal_case("mixed_up_ snake_case with some _spaces") == "MixedUpSnakeCaseWithSomeSpaces"
expect Heck.to_pascal_case("kebab-case") == "KebabCase"
expect Heck.to_pascal_case("SHOUTY_SNAKE_CASE") == "ShoutySnakeCase"
expect Heck.to_pascal_case("snake_case") == "SnakeCase"
expect Heck.to_pascal_case("this-contains_ ALLKinds OfWord_Boundaries") == "ThisContainsAllKindsOfWordBoundaries"
expect Heck.to_pascal_case("XMLHttpRequest") == "XmlHttpRequest"

expect Heck.to_shouty_kebab_case("CamelCase") == "CAMEL-CASE"
expect Heck.to_shouty_kebab_case("This is Human case.") == "THIS-IS-HUMAN-CASE"
expect Heck.to_shouty_kebab_case("MixedUP CamelCase, with some Spaces") == "MIXED-UP-CAMEL-CASE-WITH-SOME-SPACES"
expect Heck.to_shouty_kebab_case("mixed_up_ snake_case with some _spaces") == "MIXED-UP-SNAKE-CASE-WITH-SOME-SPACES"
expect Heck.to_shouty_kebab_case("kebab-case") == "KEBAB-CASE"
expect Heck.to_shouty_kebab_case("SHOUTY_SNAKE_CASE") == "SHOUTY-SNAKE-CASE"
expect Heck.to_shouty_kebab_case("snake_case") == "SNAKE-CASE"
expect Heck.to_shouty_kebab_case("this-contains_ ALLKinds OfWord_Boundaries") == "THIS-CONTAINS-ALL-KINDS-OF-WORD-BOUNDARIES"
expect Heck.to_shouty_kebab_case("XMLHttpRequest") == "XML-HTTP-REQUEST"

expect Heck.to_shouty_snake_case("CamelCase") == "CAMEL_CASE"
expect Heck.to_shouty_snake_case("This is Human case.") == "THIS_IS_HUMAN_CASE"
expect Heck.to_shouty_snake_case("MixedUP CamelCase, with some Spaces") == "MIXED_UP_CAMEL_CASE_WITH_SOME_SPACES"
expect Heck.to_shouty_snake_case("mixed_up_ snake_case with some _spaces") == "MIXED_UP_SNAKE_CASE_WITH_SOME_SPACES"
expect Heck.to_shouty_snake_case("kebab-case") == "KEBAB_CASE"
expect Heck.to_shouty_snake_case("SHOUTY_SNAKE_CASE") == "SHOUTY_SNAKE_CASE"
expect Heck.to_shouty_snake_case("snake_case") == "SNAKE_CASE"
expect Heck.to_shouty_snake_case("this-contains_ ALLKinds OfWord_Boundaries") == "THIS_CONTAINS_ALL_KINDS_OF_WORD_BOUNDARIES"
expect Heck.to_shouty_snake_case("XMLHttpRequest") == "XML_HTTP_REQUEST"

expect Heck.to_shouty_snek_case("CamelCase") == "CAMEL_CASE"
expect Heck.to_shouty_snek_case("This is Human case.") == "THIS_IS_HUMAN_CASE"
expect Heck.to_shouty_snek_case("MixedUP CamelCase, with some Spaces") == "MIXED_UP_CAMEL_CASE_WITH_SOME_SPACES"
expect Heck.to_shouty_snek_case("mixed_up_ snake_case with some _spaces") == "MIXED_UP_SNAKE_CASE_WITH_SOME_SPACES"
expect Heck.to_shouty_snek_case("kebab-case") == "KEBAB_CASE"
expect Heck.to_shouty_snek_case("SHOUTY_SNAKE_CASE") == "SHOUTY_SNAKE_CASE"
expect Heck.to_shouty_snek_case("snake_case") == "SNAKE_CASE"
expect Heck.to_shouty_snek_case("this-contains_ ALLKinds OfWord_Boundaries") == "THIS_CONTAINS_ALL_KINDS_OF_WORD_BOUNDARIES"
expect Heck.to_shouty_snek_case("XMLHttpRequest") == "XML_HTTP_REQUEST"

expect Heck.to_snake_case("CamelCase") == "camel_case"
expect Heck.to_snake_case("This is Human case.") == "this_is_human_case"
expect Heck.to_snake_case("MixedUP CamelCase, with some Spaces") == "mixed_up_camel_case_with_some_spaces"
expect Heck.to_snake_case("mixed_up_ snake_case with some _spaces") == "mixed_up_snake_case_with_some_spaces"
expect Heck.to_snake_case("kebab-case") == "kebab_case"
expect Heck.to_snake_case("SHOUTY_SNAKE_CASE") == "shouty_snake_case"
expect Heck.to_snake_case("snake_case") == "snake_case"
expect Heck.to_snake_case("this-contains_ ALLKinds OfWord_Boundaries") == "this_contains_all_kinds_of_word_boundaries"
expect Heck.to_snake_case("XMLHttpRequest") == "xml_http_request"

expect Heck.to_snek_case("CamelCase") == "camel_case"
expect Heck.to_snek_case("This is Human case.") == "this_is_human_case"
expect Heck.to_snek_case("MixedUP CamelCase, with some Spaces") == "mixed_up_camel_case_with_some_spaces"
expect Heck.to_snek_case("mixed_up_ snake_case with some _spaces") == "mixed_up_snake_case_with_some_spaces"
expect Heck.to_snek_case("kebab-case") == "kebab_case"
expect Heck.to_snek_case("SHOUTY_SNAKE_CASE") == "shouty_snake_case"
expect Heck.to_snek_case("snake_case") == "snake_case"
expect Heck.to_snek_case("this-contains_ ALLKinds OfWord_Boundaries") == "this_contains_all_kinds_of_word_boundaries"
expect Heck.to_snek_case("XMLHttpRequest") == "xml_http_request"

expect Heck.to_title_case("CamelCase") == "Camel Case"
expect Heck.to_title_case("This is Human case.") == "This Is Human Case"
expect Heck.to_title_case("MixedUP CamelCase, with some Spaces") == "Mixed Up Camel Case With Some Spaces"
expect Heck.to_title_case("mixed_up_ snake_case with some _spaces") == "Mixed Up Snake Case With Some Spaces"
expect Heck.to_title_case("kebab-case") == "Kebab Case"
expect Heck.to_title_case("SHOUTY_SNAKE_CASE") == "Shouty Snake Case"
expect Heck.to_title_case("snake_case") == "Snake Case"
expect Heck.to_title_case("this-contains_ ALLKinds OfWord_Boundaries") == "This Contains All Kinds Of Word Boundaries"
expect Heck.to_title_case("XMLHttpRequest") == "Xml Http Request"

expect Heck.to_train_case("CamelCase") == "Camel-Case"
expect Heck.to_train_case("This is Human case.") == "This-Is-Human-Case"
expect Heck.to_train_case("MixedUP CamelCase, with some Spaces") == "Mixed-Up-Camel-Case-With-Some-Spaces"
expect Heck.to_train_case("mixed_up_ snake_case with some _spaces") == "Mixed-Up-Snake-Case-With-Some-Spaces"
expect Heck.to_train_case("kebab-case") == "Kebab-Case"
expect Heck.to_train_case("SHOUTY_SNAKE_CASE") == "Shouty-Snake-Case"
expect Heck.to_train_case("snake_case") == "Snake-Case"
expect Heck.to_train_case("this-contains_ ALLKinds OfWord_Boundaries") == "This-Contains-All-Kinds-Of-Word-Boundaries"
expect Heck.to_train_case("XMLHttpRequest") == "Xml-Http-Request"

expect Heck.to_upper_camel_case("CamelCase") == "CamelCase"
expect Heck.to_upper_camel_case("This is Human case.") == "ThisIsHumanCase"
expect Heck.to_upper_camel_case("MixedUP CamelCase, with some Spaces") == "MixedUpCamelCaseWithSomeSpaces"
expect Heck.to_upper_camel_case("mixed_up_ snake_case with some _spaces") == "MixedUpSnakeCaseWithSomeSpaces"
expect Heck.to_upper_camel_case("kebab-case") == "KebabCase"
expect Heck.to_upper_camel_case("SHOUTY_SNAKE_CASE") == "ShoutySnakeCase"
expect Heck.to_upper_camel_case("snake_case") == "SnakeCase"
expect Heck.to_upper_camel_case("this-contains_ ALLKinds OfWord_Boundaries") == "ThisContainsAllKindsOfWordBoundaries"
expect Heck.to_upper_camel_case("XMLHttpRequest") == "XmlHttpRequest"
