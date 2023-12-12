# Cheating at Wordle
I like to play Wordle. It makes for a nice little brainteaser to get the juices going in the morning. I don't mind the challenge, but sometimes I just get stumped, and low on time, so I cheat.

Wordle being a word game, we'll need a dictionary. If you have a spellchecker installed, then somewhere on your computer is a file that is simply a big list of words. On my laptop running Arch Linux, that's located at `/usr/share/dict/words`. This does include many words that are not accepted in World, but this thing is just meant to give a hint, not solve the entire thing, so getting a copy of the game's wordlist is left as an exercise to the reader. Now we can start building a filter to whittle them down.

There is quite a variety of text processing tools available, but all we really need is grep. Our first stage is
```
$ grep '^.....$' /usr/share/dict/words
```

This will get us down to five letter words. The real meat is in replacing the dots with known letters. To exclude the unused letters, pipe the list through grep again, this time with the -v flag to invert the match:
```
$ grep '^.....$' /usr/share/dict/words | grep -v '[abcd]`
```


