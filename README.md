# Palindrome

This is small tool that allow to find all palindromes in text or in any other document if you will use library.  
I already added apps that allow to find palindromes like "Was it a car or a cat I saw?" (palindrome-chars) and palindromes like "Is it crazy how saying sentences backwards creates backwards sentences saying how crazy it is?" (palindrome-words).  

## Installation

Apps are written on Haskell and uses stack, so to build them you need to have Haskell and Stack. How to install them you can find here:
https://www.haskell.org/downloads/  
https://docs.haskellstack.org/en/stable/README/#how-to-install  
Then you need to clone it, to build with `stack build` and then to launch with:  
```
echo "<filename>" | stack exec palindrome-char
```
or  
```
echo "<filename>" | stack exec palindrome-words
```

## Examples

### Ulysses : James Joyce
#### Sentences

Able was I ere I saw Elba
tattarrattat
Madam, I’m Adam
Wow wow wow
Hah, hah, hah

#### Paragraphs

Hoopsa boyaboy hoopsa! Hoopsa boyaboy hoopsa! Hoopsa boyaboy hoopsa
Tap. Tap. Tap. Tap. Tap. Tap. Tap. Tap
Ute ute ute ute ute ute ute ute
The ree the ra the ree the
the ra the ree the ra the
```
is coming.

Is coming! Is coming!! Is
```

### War and Peace : Tolstoy (in Russian)
#### Sentences

ого-го-го-го-го
еще, и еще, и еще
Ооооо!  о!  ооооо
```
казак?
           -- Казак
```
Non, non,  non
иди,  иди,  иди
Это сотэ
Но еще он
ого-го-го
умел  ему

#### Paragraphs

пити-пити-пити  и  ти-ти   -  и  пити-пити-пити
быстрее и слышнее, слышнее и быстрее
```
Электричество производит  тепло,  тепло  производит
      электричество
```
```
сказала она.
           Когда она  сказала
```

It can be also funny to check Palindrome article on WiKi:  
https://en.wikipedia.org/wiki/Palindrome  
You can try to do it with:  
```
echo "test-wiki-palindrome.txt" | stack exec palindrome-chars
echo "test-wiki-palindrome.txt" | stack exec palindrome-words
echo "test-wiki-palindrome-russian.txt" | stack exec palindrome-chars
echo "test-wiki-palindrome-russian.txt" | stack exec palindrome-words
```

Surely you can have fun with other language.

**Have fun!**
