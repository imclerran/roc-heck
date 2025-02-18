module [
    to_kebab_case,
    to_lower_camel_case,
    to_pascal_case,
    to_shouty_kebab_case,
    to_shouty_snake_case,
    to_shouty_snek_case,
    to_snake_case,
    to_snek_case,
    to_title_case,
    to_train_case,
    to_upper_camel_case,
]

import Kebab
import LowerCamel
import ShoutyKebab
import ShoutySnake
import Snake
import Title
import Train
import UpperCamel

to_kebab_case : Str -> Str
to_kebab_case = |s|
    transform(s, Kebab.with_word, Kebab.boundary)

expect to_kebab_case("CamelCase") == "camel-case"
expect to_kebab_case("This is Human case.") == "this-is-human-case"
expect to_kebab_case("MixedUP CamelCase, with some Spaces") == "mixed-up-camel-case-with-some-spaces"
expect to_kebab_case("mixed_up_ snake_case with some _spaces") == "mixed-up-snake-case-with-some-spaces"
expect to_kebab_case("kebab-case") == "kebab-case"
expect to_kebab_case("SHOUTY_SNAKE_CASE") == "shouty-snake-case"
expect to_kebab_case("snake_case") == "snake-case"
expect to_kebab_case("this-contains_ ALLKinds OfWord_Boundaries") == "this-contains-all-kinds-of-word-boundaries"
expect to_kebab_case("XMLHttpRequest") == "xml-http-request"

to_lower_camel_case : Str -> Str
to_lower_camel_case = |s|
    transform(s, LowerCamel.with_word, LowerCamel.boundary)

expect to_lower_camel_case("CamelCase") == "camelCase"
expect to_lower_camel_case("This is Human case.") == "thisIsHumanCase"
expect to_lower_camel_case("MixedUP CamelCase, with some Spaces") == "mixedUpCamelCaseWithSomeSpaces"
expect to_lower_camel_case("mixed_up_ snake_case with some _spaces") == "mixedUpSnakeCaseWithSomeSpaces"
expect to_lower_camel_case("kebab-case") == "kebabCase"
expect to_lower_camel_case("SHOUTY_SNAKE_CASE") == "shoutySnakeCase"
expect to_lower_camel_case("snake_case") == "snakeCase"
expect to_lower_camel_case("this-contains_ ALLKinds OfWord_Boundaries") == "thisContainsAllKindsOfWordBoundaries"
expect to_lower_camel_case("XMLHttpRequest") == "xmlHttpRequest"

to_pascal_case : Str -> Str
to_pascal_case = to_upper_camel_case

expect to_pascal_case("CamelCase") == "CamelCase"
expect to_pascal_case("This is Human case.") == "ThisIsHumanCase"
expect to_pascal_case("MixedUP CamelCase, with some Spaces") == "MixedUpCamelCaseWithSomeSpaces"
expect to_pascal_case("mixed_up_ snake_case with some _spaces") == "MixedUpSnakeCaseWithSomeSpaces"
expect to_pascal_case("kebab-case") == "KebabCase"
expect to_pascal_case("SHOUTY_SNAKE_CASE") == "ShoutySnakeCase"
expect to_pascal_case("snake_case") == "SnakeCase"
expect to_pascal_case("this-contains_ ALLKinds OfWord_Boundaries") == "ThisContainsAllKindsOfWordBoundaries"
expect to_pascal_case("XMLHttpRequest") == "XmlHttpRequest"

to_shouty_kebab_case : Str -> Str
to_shouty_kebab_case = |s|
    transform(s, ShoutyKebab.with_word, ShoutyKebab.boundary)

expect to_shouty_kebab_case("CamelCase") == "CAMEL-CASE"
expect to_shouty_kebab_case("This is Human case.") == "THIS-IS-HUMAN-CASE"
expect to_shouty_kebab_case("MixedUP CamelCase, with some Spaces") == "MIXED-UP-CAMEL-CASE-WITH-SOME-SPACES"
expect to_shouty_kebab_case("mixed_up_ snake_case with some _spaces") == "MIXED-UP-SNAKE-CASE-WITH-SOME-SPACES"
expect to_shouty_kebab_case("kebab-case") == "KEBAB-CASE"
expect to_shouty_kebab_case("SHOUTY_SNAKE_CASE") == "SHOUTY-SNAKE-CASE"
expect to_shouty_kebab_case("snake_case") == "SNAKE-CASE"
expect to_shouty_kebab_case("this-contains_ ALLKinds OfWord_Boundaries") == "THIS-CONTAINS-ALL-KINDS-OF-WORD-BOUNDARIES"
expect to_shouty_kebab_case("XMLHttpRequest") == "XML-HTTP-REQUEST"

to_shouty_snake_case : Str -> Str
to_shouty_snake_case = |s|
    transform(s, ShoutySnake.with_word, ShoutySnake.boundary)

expect to_shouty_snake_case("CamelCase") == "CAMEL_CASE"
expect to_shouty_snake_case("This is Human case.") == "THIS_IS_HUMAN_CASE"
expect to_shouty_snake_case("MixedUP CamelCase, with some Spaces") == "MIXED_UP_CAMEL_CASE_WITH_SOME_SPACES"
expect to_shouty_snake_case("mixed_up_ snake_case with some _spaces") == "MIXED_UP_SNAKE_CASE_WITH_SOME_SPACES"
expect to_shouty_snake_case("kebab-case") == "KEBAB_CASE"
expect to_shouty_snake_case("SHOUTY_SNAKE_CASE") == "SHOUTY_SNAKE_CASE"
expect to_shouty_snake_case("snake_case") == "SNAKE_CASE"
expect to_shouty_snake_case("this-contains_ ALLKinds OfWord_Boundaries") == "THIS_CONTAINS_ALL_KINDS_OF_WORD_BOUNDARIES"
expect to_shouty_snake_case("XMLHttpRequest") == "XML_HTTP_REQUEST"

to_shouty_snek_case : Str -> Str
to_shouty_snek_case = to_shouty_snake_case

expect to_shouty_snek_case("CamelCase") == "CAMEL_CASE"
expect to_shouty_snek_case("This is Human case.") == "THIS_IS_HUMAN_CASE"
expect to_shouty_snek_case("MixedUP CamelCase, with some Spaces") == "MIXED_UP_CAMEL_CASE_WITH_SOME_SPACES"
expect to_shouty_snek_case("mixed_up_ snake_case with some _spaces") == "MIXED_UP_SNAKE_CASE_WITH_SOME_SPACES"
expect to_shouty_snek_case("kebab-case") == "KEBAB_CASE"
expect to_shouty_snek_case("SHOUTY_SNAKE_CASE") == "SHOUTY_SNAKE_CASE"
expect to_shouty_snek_case("snake_case") == "SNAKE_CASE"
expect to_shouty_snek_case("this-contains_ ALLKinds OfWord_Boundaries") == "THIS_CONTAINS_ALL_KINDS_OF_WORD_BOUNDARIES"
expect to_shouty_snek_case("XMLHttpRequest") == "XML_HTTP_REQUEST"

to_snake_case : Str -> Str
to_snake_case = |s|
    transform(s, Snake.with_word, Snake.boundary)

expect to_snake_case("CamelCase") == "camel_case"
expect to_snake_case("This is Human case.") == "this_is_human_case"
expect to_snake_case("MixedUP CamelCase, with some Spaces") == "mixed_up_camel_case_with_some_spaces"
expect to_snake_case("mixed_up_ snake_case with some _spaces") == "mixed_up_snake_case_with_some_spaces"
expect to_snake_case("kebab-case") == "kebab_case"
expect to_snake_case("SHOUTY_SNAKE_CASE") == "shouty_snake_case"
expect to_snake_case("snake_case") == "snake_case"
expect to_snake_case("this-contains_ ALLKinds OfWord_Boundaries") == "this_contains_all_kinds_of_word_boundaries"
expect to_snake_case("XMLHttpRequest") == "xml_http_request"

to_snek_case : Str -> Str
to_snek_case = to_snake_case

expect to_snek_case("CamelCase") == "camel_case"
expect to_snek_case("This is Human case.") == "this_is_human_case"
expect to_snek_case("MixedUP CamelCase, with some Spaces") == "mixed_up_camel_case_with_some_spaces"
expect to_snek_case("mixed_up_ snake_case with some _spaces") == "mixed_up_snake_case_with_some_spaces"
expect to_snek_case("kebab-case") == "kebab_case"
expect to_snek_case("SHOUTY_SNAKE_CASE") == "shouty_snake_case"
expect to_snek_case("snake_case") == "snake_case"
expect to_snek_case("this-contains_ ALLKinds OfWord_Boundaries") == "this_contains_all_kinds_of_word_boundaries"
expect to_snek_case("XMLHttpRequest") == "xml_http_request"

to_title_case : Str -> Str
to_title_case = |s|
    transform(s, Title.with_word, Title.boundary)

expect to_title_case("CamelCase") == "Camel Case"
expect to_title_case("This is Human case.") == "This Is Human Case"
expect to_title_case("MixedUP CamelCase, with some Spaces") == "Mixed Up Camel Case With Some Spaces"
expect to_title_case("mixed_up_ snake_case with some _spaces") == "Mixed Up Snake Case With Some Spaces"
expect to_title_case("kebab-case") == "Kebab Case"
expect to_title_case("SHOUTY_SNAKE_CASE") == "Shouty Snake Case"
expect to_title_case("snake_case") == "Snake Case"
expect to_title_case("this-contains_ ALLKinds OfWord_Boundaries") == "This Contains All Kinds Of Word Boundaries"
expect to_title_case("XMLHttpRequest") == "Xml Http Request"

to_train_case : Str -> Str
to_train_case = |s|
    transform(s, Train.with_word, Train.boundary)

expect to_train_case("CamelCase") == "Camel-Case"
expect to_train_case("This is Human case.") == "This-Is-Human-Case"
expect to_train_case("MixedUP CamelCase, with some Spaces") == "Mixed-Up-Camel-Case-With-Some-Spaces"
expect to_train_case("mixed_up_ snake_case with some _spaces") == "Mixed-Up-Snake-Case-With-Some-Spaces"
expect to_train_case("kebab-case") == "Kebab-Case"
expect to_train_case("SHOUTY_SNAKE_CASE") == "Shouty-Snake-Case"
expect to_train_case("snake_case") == "Snake-Case"
expect to_train_case("this-contains_ ALLKinds OfWord_Boundaries") == "This-Contains-All-Kinds-Of-Word-Boundaries"
expect to_train_case("XMLHttpRequest") == "Xml-Http-Request"

to_upper_camel_case : Str -> Str
to_upper_camel_case = |s|
    transform(s, UpperCamel.with_word, UpperCamel.boundary)

expect to_upper_camel_case("CamelCase") == "CamelCase"
expect to_upper_camel_case("This is Human case.") == "ThisIsHumanCase"
expect to_upper_camel_case("MixedUP CamelCase, with some Spaces") == "MixedUpCamelCaseWithSomeSpaces"
expect to_upper_camel_case("mixed_up_ snake_case with some _spaces") == "MixedUpSnakeCaseWithSomeSpaces"
expect to_upper_camel_case("kebab-case") == "KebabCase"
expect to_upper_camel_case("SHOUTY_SNAKE_CASE") == "ShoutySnakeCase"
expect to_upper_camel_case("snake_case") == "SnakeCase"
expect to_upper_camel_case("this-contains_ ALLKinds OfWord_Boundaries") == "ThisContainsAllKindsOfWordBoundaries"
expect to_upper_camel_case("XMLHttpRequest") == "XmlHttpRequest"

WithWord : List (List U8), List U8, Bool -> List (List U8)
Boundary : List (List U8) -> List (List U8)

import Utils exposing [is_alphanumeric, is_uppercase, is_lowercase]

transform : Str, WithWord, Boundary -> Str
transform = |s, with_word, boundary|
    Str.to_utf8(s)
    |> Utils.split_if(|c| !is_alphanumeric(c))
    |> List.map_with_index(
        |word, j|
            word
            |> List.walk_with_index(
                { words: [], mode: Boundary, first_word: (j == 0), start: 0 },
                |{ words, mode, first_word, start }, c, i|
                    next_i = i + 1
                    when List.get(word, next_i) is
                        Ok(next) ->
                            next_mode = if is_lowercase(c) then Lowercase else if Utils.is_uppercase(c) then Uppercase else mode

                            if next_mode == Lowercase and is_uppercase(next) then
                                new_words =
                                    (if !first_word then boundary(words) else words)
                                    |> with_word(List.sublist(word, { start, len: next_i - start }), first_word)

                                { words: new_words, mode: Boundary, first_word: Bool.false, start: next_i }
                            else if mode == Uppercase and Utils.is_uppercase(c) and Utils.is_lowercase(next) then
                                new_words =
                                    (if !first_word then boundary(words) else words)
                                    |> with_word(List.sublist(word, { start, len: i - start }), first_word)

                                { words: new_words, mode: Boundary, first_word: Bool.false, start: i }
                            else
                                { words, mode: next_mode, first_word, start }

                        Err _ ->
                            new_words =
                                (if !first_word then boundary(words) else words)
                                |> with_word(List.split_at(word, start) |> .others, first_word)

                            { words: new_words, mode: Boundary, first_word: Bool.false, start: next_i },
            ),
    )
    |> List.map(.words)
    |> List.join
    |> List.join
    |> Str.from_utf8_lossy
