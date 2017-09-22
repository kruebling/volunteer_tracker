# _Vocab Words_

#### _Storing local variables, 09.15.2017_

#### By _Keegan Ruebling_

## Description

_This app allows the user to store vocab words along with their definition. When the word is clicked on it brings you to a new page that displays the word, as well as it's definition. You can also remove the word from the array with the delete function on the words page._

## Specs

| name   | Describe                                  | Input                                                     | Output             |
|--------|-------------------------------------------|-----------------------------------------------------------|--------------------|
| .all   | initial array                             | []                                                        | []                 |
| clear  | empties the array                         | [word1, word2]                                            | []                 |
| id     | assigns each word a unique id             | [word1, word2]                                            | [1, 2]             |
| save   | adds variable to array                    | word  = Word.new("Ruby" "programing language")            | [word]             |
| delete | changes exisiting word to empty string    | word = Word.new("Michael") word.delete                    | [""]               |
| sort   | orders list alphabetically by last name   | word = Word.new("Michael" "Keegan") word.sort             | "Keegan" "Michael" |

## Setup/Installation Requirements

1. git clone https://github.com/kruebling/vocab_words.git into local directory
2. ruby app.rb inside directory
3. localhost://4567 in preferred browser

## Known Bugs

_App is currecntly a work in progress_

## Support and contact details

_keegan.ruebling@gmail.com_

### License

MIT License

Copyright (c) 2017 Keegan Ruebling
