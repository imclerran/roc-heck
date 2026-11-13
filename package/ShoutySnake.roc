import Utils exposing [uppercase]

ShoutySnake :: [].{
	with_word : List(List(U8)), List(U8), Bool -> List(List(U8))
	with_word = |words, word, _first_word| words.append(uppercase(word))

	boundary : List(List(U8)) -> List(List(U8))
	boundary = |words| words.append(['_'])
}
