## QUESTLINE
1. The other book
- Find a book titled "The Legendary Elusive Beast" by V. Ernaccus
- Reading the book triggers a cutscene: There was a Daedra so mighty, so fearsome that he earned the titles of The Elusive Beast and The Unpursuable One! Molag Bal himself recognised my , ahemm, his power for I *cough * he is fearsome and mighty."
- Text in the book: "This book is badly written and goes on about the prowess of a Daedra called The Elusive Beast. The is a map indication the loaction of a Shrine, with the usual promise for glory and power."
- Map a la Xero

2.  The Shrine and the Statue
- The exterior of the shrine is pathetic (even for a ruin) and smaller than any other shrines on the continent
- The interior is a large cave with a large statue (think Molag Bal-ish, but surrounded by corpses)
- The Statue speaks and says:
“My Champion, you have arrived at last! I am Vernaccus, the legendary Elusive beast, the Unpursuable One! Complete a task for me and you shall be rewarded richly. Find Horavatha in <insert Daedric RUIN>, a wily seducer and kill her. 

Journal: I have found a shrine where Vernaccus spoke to me. He called me his champion though I have a nagging feeling he’d call a rat his champion if a rat has walked in before me. He tasked me with killing Horavatha, a seducer in <insert RUINS>
> tooltips for the clutter in the shrine that show the place has never been great and has long been abandoned. Unusual amounts of stones

3.  Horavatha
- we need to make sure the player doesn’t kill her before they get a chance to speak with her (disabled + force greet until the player enters the cell?
    ```
  “What do you want mortal? I am not in the mood to play with your puny race today.”
  {1} I’ve come to fulfill my Master’s orders and kill you!
  {2} Vernaccus has better reward me well for this…
  “Master, hey? Let me guess… Is Xviliaresko still upset? No, that’s not it… Oh! Gharthium wants his black soulgems back? No, no… I have it! That pathetic excuse of a Daedra has found himself a foolish %PCRace willing to face me because he is too scared to do it himself!”
  “Vernaccus! *laughs uncontrollably*  That pathetic excuse for a Daedra has found a %PCRace willing to face me because he is too scared to do it himself!”
  {1} [stunned silence]
  “Look, ask him yourself, ask him about stones and arrows, see how he reacts.” [She vanishes]
  {goodbye}
    ```
4.  Shrine again
- the statue is silent. A note says ”Gone hunting big game in Hircine’s Hunting Grounds. <USE MY ARTIFACT>  with a mortal soul, the more souls we capture, the more power.
V.
PS: Leave offerings by Shrine
Journal: I am starting to have my doubts about Vernaccus. I could try to use his artifact/spell , and maybe see if I can find anything about him: a Daedra with a shrine cannot be totally unknown.

5.  Finding the other book (optional)
- Player just goes shopping!
- we need to check how common the book is.

6.  Capture souls
- cast the spell on the KO npc
- spell effect woosh
- npc gone
- message box “The soul has been captured and sent to Vernaccus’ shrine.”

7.  Shrine again
- Daedric golem welcomes the player
- it explains it was created from the soul we captured
- it explains how more souls will expand the shrine (“restore it to its former state, but better, hopefully)
- NEW: soul in pen, simple bedroom
- it gives a message from V for the next quest (maybe like a recorded message coming from the golem:
V is wants a worthy offering, he wants the leg of an important mer. 
Can we stun the npc, cut their leg and force equip a peg leg on them?

8.  Get a piece of the mayor

9. Molag Bal congratulates us, we’d make a fine Vernaccus. Are we interested?
Yes: re-enact V’s greatest achievement 
No: go back to serving him
Cutscene?
Trial: dodge arrows game (slow mo? Matrix?)

10. Shrine again
The hero is Bourlor's descendant who is on a quest to destroy all of Vernaccus' shrines across Tamriel. This is the last one. Because his ancestor died humiliated and he's seeking revenge. He shows up at the shrine and defiles the "Well of Fire" by messing up its roots deep in the earth. You have to go beneath the shrine into the caverns and kill him.

11. Shrine again
H congratulates the player on ascending
> cut scene, the player morphing into V.
With proof of H death. Statue congratulates  us and grants us an artifact. 



## Building the Shrine
- Spend souls to build out the shrine
- Direct Golem to build
- New areas can provide benefits to player, or aid in worship/faith
- Shrine cell name changes based on faith level:
  - Shrine of Impotence
  - Shrine of Limitations
  - Shrine of Vernaccus
  - Shrine of the Untouched
  - Shrine of the Elusive Beast

### Build Options:
- Carve out new area (does not cost souls, only direct the golem)
- Convert area
- Teleporting/Portal Room
- Living Quarters
- Alchemy Lab (Use my alchemy table script from Tel Raloran)
- Storage Room
- Enchanting Room
- Worshipping Room (+bonus to faith)
- Practice Room (Use my target dummy script)
- Soul pit
- Portal Chamber (streeeeetch)
- Sacrificial Chamber (eat a follower for a temporary boon?)
- Zen room (to reflect on what it means to be a demi-god)


## Soul gauge
- Controls room carving
- Controls room decorating
- Use a soul to activate powers (teleport to safety, 100% sanctuary for very short time)
- Use a soul to power the Zen room?
- Restocking soul quests - go fight a bunch of spawned enemies somewhere
- This is to avoid the player running out of NPCs to harvest

## Journal entries
### 1
I found a book about a little known Daedra of great power. There was a map to a Shrine in the Sheogorad Region. 
### 5
I have found a cave leading to the Shrine with difficulty: the place has clearly been deserted for a long time.
### 10
Vernaccus spoke to me. He called me his champion though I have a nagging feeling he’d call a rat his champion if a rat has walked in before me. He tasked me with killing Horavatha, a seducer in <RUIN>.
### 15
I have met Horavatha: she was positively underwhelmed with the idea that Vernaccus wanted a dead, in fact, she found the idea quite comical. She vanished before I could draw my weapon, but not before suggesting I confront Vernaccus. I just might.
### 20
Vernaccus would not talk to me, he did however, leave a note (what sort of Daedra leaves notes?) I am to use a power he's granted me on someone who's been incapacitated first. It is worth trying but I should see if they're any information I can find on Vernaccus.
### 21
I was told there was a book titled "Vernaccus and Bourlor". It is pretty common in bookshops.
### 25
I have successfully captured a soul. The effect was quite spectacular and there was no body left. I can only assumed it's been moved to the Shrine or destroyed. I'd better return to the Shrine to find out. Maybe this time Vernaccus will deign answer my questions.
### 30
There is a golem in the Shrine. He was able to communicate a surprising amount of information without saying a word: he seems to be animated by the power of the captured souls, he uses that power to dig tunnels and rooms and he requires more souls to do fill the rooms.
### 35
A scamp materialized out of the small portal and delivered a message from Vernaccus. The Elusive Beast (did he earn that title but never being there?) demands a grand offering: the leg of an important mer. As per the tradition, after an acceptable offering, the Daedra reveal themselves to mortals.
