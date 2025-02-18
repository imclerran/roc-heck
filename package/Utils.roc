module [is_alphanumeric, is_lowercase, is_uppercase, is_numeric, split_if, capitalize, uppercase, lowercase]

is_alphanumeric = |c| is_lowercase(c) or is_uppercase(c) or is_numeric(c)

is_lowercase = |c| c >= 'a' and c <= 'z'

is_uppercase = |c| c >= 'A' and c <= 'Z'

is_numeric = |c| c >= '0' and c <= '9'

split_if : List a, (a -> Bool) -> List (List a)
split_if = |list, predicate|
    List.walk(
        list,
        { acc: [], current: [] },
        |{ acc, current }, item|
            if predicate(item) then
                if !List.is_empty(current) then
                    { acc: List.append(acc, current), current: [] }
                else
                    { acc, current }
            else
                { acc, current: List.append(current, item) },
    )
    |> |{ acc, current }| if !List.is_empty(current) then List.append(acc, current) else acc

expect
    chars = "abc!def(ghi]jkl-mno/pqr,stu.vwx?yz" |> Str.to_utf8
    res = chars |> split_if(|c| !is_alphanumeric(c)) |> List.map(Str.from_utf8_lossy)
    res == ["abc", "def", "ghi", "jkl", "mno", "pqr", "stu", "vwx", "yz"]

expect
    chars = ['a', 'b', 'c']
    res = chars |> split_if(|c| c == 'a')
    res == [['b', 'c']]

expect
    chars = ['a', 'b', 'c']
    res = chars |> split_if(|c| c == 'd')
    res == [['a', 'b', 'c']]

capitalize : List U8 -> List U8
capitalize = |word|
    when word is
        [first, .. as rest] -> 
            if first >= 'a' and first <= 'z' then
                List.join([[first - 32], lowercase(rest)])
            else
                List.join([[first], lowercase(rest)])
        [] -> []

uppercase : List U8 -> List U8
uppercase = |word|
    when word is
        [first, .. as rest] -> 
            if first >= 'a' and first <= 'z' then
                List.join([[first - 32], uppercase(rest)])
            else
                List.join([[first], uppercase(rest)])
        [] -> []

lowercase : List U8 -> List U8
lowercase = |word|
    when word is
        [first, .. as rest] -> 
            if first >= 'A' and first <= 'Z' then
                List.join([[first + 32], lowercase(rest)])
            else
                List.join([[first], lowercase(rest)])
        [] -> []