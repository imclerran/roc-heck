Utils :: [].{
	is_alphanumeric : U8 -> Bool
	is_alphanumeric = |c| is_lowercase(c) or is_uppercase(c) or is_numeric(c)

	is_lowercase : U8 -> Bool
	is_lowercase = |c| c >= 'a' and c <= 'z'

	is_uppercase : U8 -> Bool
	is_uppercase = |c| c >= 'A' and c <= 'Z'

	is_numeric : U8 -> Bool
	is_numeric = |c| c >= '0' and c <= '9'

	## Uppercase the first ASCII letter of a word and lowercase the rest.
	capitalize : List(U8) -> List(U8)
	capitalize = |word| match word {
		[first, .. as rest] => lowercase(rest).prepend(to_upper(first))
		[] => []
	}

	## Convert all ASCII letters in a word to uppercase.
	uppercase : List(U8) -> List(U8)
	uppercase = |word| word.map(to_upper)

	## Convert all ASCII letters in a word to lowercase.
	lowercase : List(U8) -> List(U8)
	lowercase = |word| word.map(to_lower)
}

to_upper : U8 -> U8
to_upper = |c| if (Utils.is_lowercase(c)) c - 32 else c

to_lower : U8 -> U8
to_lower = |c| if (Utils.is_uppercase(c)) c + 32 else c

expect Utils.capitalize("hELLO".to_utf8()) == "Hello".to_utf8()
expect Utils.capitalize([]) == []
expect Utils.uppercase("Hello1".to_utf8()) == "HELLO1".to_utf8()
expect Utils.lowercase("Hello1".to_utf8()) == "hello1".to_utf8()
