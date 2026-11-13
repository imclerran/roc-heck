import Utils exposing [capitalize, lowercase]

LowerCamel :: [].{
	with_word : List(List(U8)), List(U8), Bool -> List(List(U8))
	with_word = |words, word, first_word|
		if (first_word) words.append(lowercase(word)) else words.append(capitalize(word))

	boundary : List(List(U8)) -> List(List(U8))
	boundary = |words| words
}
