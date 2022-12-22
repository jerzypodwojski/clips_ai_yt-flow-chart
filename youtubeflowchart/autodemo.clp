
;;;======================================================
;;;     Choose a channel to watch on YouTube - System
;;;
;;;     Based on CLIPS Version 6.3 Example: Auto
;;;
;;;		Made by: 148374 and 145268
;;;======================================================

;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate UI-state
   (slot id (default-dynamic (gensym*)))
   (slot display)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))
   
(deftemplate state-list
   (slot current)
   (multislot sequence))
  
(deffacts startup
   (state-list))
   
;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""

  =>
  
  (assert (UI-state (display WelcomeMessage)
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))

;;;***************
;;;* QUERY RULES *
;;;***************

(defrule determine-youtube-channel-type ""

   (logical (start))

   =>

   (assert (UI-state (display StartQuestion)
                     (relation-asserted youtube-channel-type)
                     (response Vlogger)
                     (valid-answers Vlogger SomeoneElse))))
   
(defrule determine-collab-single ""

   (logical (youtube-channel-type Vlogger))

   =>

   (assert (UI-state (display DoYouWantACollabOrSingleChannel)
                     (relation-asserted collab-single)
                     (response Collab)
                     (valid-answers Collab Single))))

(defrule determine-new-old-videos ""

   (logical (collab-single Collab))

   =>

   (assert (UI-state (display DoYouWantToWatchNewVideosOrTwoYearOldVideos)
                     (relation-asserted new-old-videos)
                     (response Old)
                     (valid-answers Old New))))
					 
(defrule determine-kind-of-accent ""

   (logical (collab-single Single))

   =>

   (assert (UI-state (display WhatKindOfAccentDoYouLike)
                     (relation-asserted kind-of-accent)
                     (response SomethingElse)
                     (valid-answers SomethingElse British American))))

(defrule determine-david-attcrative ""

   (logical (kind-of-accent British))

   =>

   (assert (UI-state (display DoYouFindDavidTennantAttractive)
                     (relation-asserted david-attcrative)
                     (response Duh)
                     (valid-answers Duh No))))

(defrule determine-boys-who-play-instument-hot ""

   (logical (david-attcrative No))

   =>

   (assert (UI-state (display WellThenAreBoysWhoPlayAnInstrumentHot)
                     (relation-asserted boys-who-play-instument-hot)
                     (response Yes)
                     (valid-answers Yes No))))

(defrule determine-hate-twilight ""

   (logical (boys-who-play-instument-hot Yes))

   =>

   (assert (UI-state (display DoYouHateTwilight)
                     (relation-asserted hate-twilight)
                     (response Yes)
                     (valid-answers Yes No DontCare))))

(defrule determine-scripted-spontaneous ""

   (logical (boys-who-play-instument-hot No))

   =>

   (assert (UI-state (display DoYouPreferScriptedOrSpontaneousVideos)
                     (relation-asserted scripted-spontaneous)
                     (response Spontaneous)
                     (valid-answers Spontaneous Scripted))))

(defrule determine-sings-or-not ""

   (logical (kind-of-accent American))

   =>

   (assert (UI-state (display SomeoneWhoSometimesSingsOrNeverSings)
                     (relation-asserted sings-or-not)
                     (response SometimesSings)
                     (valid-answers SometimesSings NeverSings))))

(defrule determine-like-rapping ""

   (logical (sings-or-not SometimesSings))

   =>

   (assert (UI-state (display DoYouLikeRapping)
                     (relation-asserted like-rapping)
                     (response Yes)
                     (valid-answers Yes No))))

(defrule determine-like-songs-breakfast ""

   (logical (like-rapping No))

   =>

   (assert (UI-state (display DoYouOnlyLikeSongsAboutBreakfast)
                     (relation-asserted like-songs-breakfast)
                     (response OfCourse)
                     (valid-answers OfCourse UmNo))))

(defrule determine-like-charts-graphs ""

   (logical (like-songs-breakfast UmNo))

   =>

   (assert (UI-state (display DoYouReallyLikeChartsAndGraphs)
                     (relation-asserted like-charts-graphs)
                     (response Yes)
                     (valid-answers Yes NotReally))))

(defrule determine-love-allcaps ""

   (logical (like-charts-graphs NotReally))

   =>

   (assert (UI-state (display DoYouLoveAllCaps)
                     (relation-asserted love-allcaps)
                     (response Yes)
                     (valid-answers Yes NotMyStyle))))					 
					 
(defrule determine-girls-boys-rule ""

   (logical (love-allcaps Yes))

   =>

   (assert (UI-state (display DoGirlsOrBoysRule)
                     (relation-asserted girls-boys-rule)
                     (response Girls)
                     (valid-answers Girls Boys))))

(defrule determine-watch-fiveawesomegirl ""

   (logical (love-allcaps NotMyStyle))

   =>

   (assert (UI-state (display DoYouInsistOnWatchingAFiveawesomegirl)
                     (relation-asserted watch-fiveawesomegirl)
                     (response Yes)
                     (valid-answers Yes No))))
					 
(defrule determine-like-happy-people ""

   (logical (watch-fiveawesomegirl No))

   =>

   (assert (UI-state (display DoYouLikeReallyReallyHappyPeople)
                     (relation-asserted like-happy-people)
                     (response Smile)
                     (valid-answers Smile NotSmile))))
					 
(defrule determine-want-vlogger-to ""

   (logical (like-happy-people NotSmile))

   =>

   (assert (UI-state (display WhenNotSingingYouWantYourVloggerTo)
                     (relation-asserted want-vlogger-to)
                     (response TalkFast)
                     (valid-answers TalkFast TalkSlow))))

(defrule determine-prefer-review ""

   (logical (want-vlogger-to TalkSlow))

   =>

   (assert (UI-state (display YouPreferYourVloggerToReview)
                     (relation-asserted prefer-review)
                     (response Technology)
                     (valid-answers Technology Books))))

(defrule determine-want-daily-videos ""

   (logical (sings-or-not NeverSings))

   =>

   (assert (UI-state (display DoYouWantDailyVideos)
                     (relation-asserted want-daily-videos)
                     (response Yes)
                     (valid-answers Yes No))))

(defrule determine-need-avice ""

   (logical (want-daily-videos No))

   =>

   (assert (UI-state (display DoYouNeedAvice)
                     (relation-asserted need-avice)
                     (response YesPlease)
                     (valid-answers YesPlease No))))

(defrule determine-play-different-versions ""

   (logical (need-avice No))

   =>

   (assert (UI-state (display DoYouLikeSeeingPeoplePlayDifferentVersionsOfThemselves)
                     (relation-asserted play-different-versions)
                     (response Yes)
                     (valid-answers Yes NoThatsWeird))))
					 
(defrule determine-how-many-subscribers ""

   (logical (play-different-versions NoThatsWeird))

   =>

   (assert (UI-state (display HowManySubscribersDoYouPreferTheyHave)
                     (relation-asserted how-many-subscribers)
                     (response MoreThan100k)
                     (valid-answers MoreThan100k LessThan100k))))
					 
(defrule determine-want-watch-someone ""

   (logical (how-many-subscribers MoreThan100k))

   =>

   (assert (UI-state (display DoYouWantToWatchSomeone)
                     (relation-asserted want-watch-someone)
                     (response TalkWorldIssues)
                     (valid-answers TalkWorldIssues PutOnMakeUp RantAndBeAdorable))))
					 
(defrule determine-typography ""

   (logical (how-many-subscribers LessThan100k))

   =>

   (assert (UI-state (display TypographyIsCool)
                     (relation-asserted typography)
                     (response Agreed)
                     (valid-answers Agreed WhatsTypography))))
					 
(defrule determine-watch-fiveawesomes ""

   (logical (typography WhatsTypography))

   =>

   (assert (UI-state (display DoYouOnlyWatchFiveawesomes)
                     (relation-asserted watch-fiveawesomes)
                     (response Yes)
                     (valid-answers Yes WhoAreThey))))

(defrule determine-picky ""

   (logical (watch-fiveawesomes WhoAreThey))

   =>

   (assert (UI-state (display YouSureArePicky)
                     (relation-asserted picky)
                     (response Yup)
                     (valid-answers Yup))))

(defrule determine-girls-or-boys ""

   (logical (watch-fiveawesomes Yes))

   =>

   (assert (UI-state (display GirlsOrBoys)
                     (relation-asserted girls-or-boys)
                     (response Girls)
                     (valid-answers Girls Boys))))
					 
					 
					 
					 
					 


					
(defrule determine-canada-cool ""

   (logical (kind-of-accent SomethingElse))

   =>

   (assert (UI-state (display CanadasCoolRight)
                     (relation-asserted canada-cool)
                     (response Yeah)
                     (valid-answers Yeah CanadaSucks))))

(defrule determine-which-funny ""

   (logical (canada-cool CanadaSucks))

   =>

   (assert (UI-state (display WhichIsFunnier)
                     (relation-asserted which-funny)
                     (response JokesAboutChickens)
                     (valid-answers JokesAboutChickens SelfDepricatingHumor))))

(defrule determine-people-in-relationships-makes-you ""

   (logical (new-old-videos New))

   =>

   (assert (UI-state (display PeopleInRelationshipsMakeYou)
                     (relation-asserted people-in-relationships-makes-you)
                     (response Sick)
                     (valid-answers Sick Happy))))

(defrule determine-are-you-obsessed-dr-who ""

   (logical (people-in-relationships-makes-you Sick))

   =>

   (assert (UI-state (display AreYouObsessedWithDoctorWho)
                     (relation-asserted are-you-obsessed-dr-who)
                     (response Absolutely)
                     (valid-answers Absolutely WhatsThat))))
					 				 
(defrule determine-how-many-people-watch ""

   (logical (are-you-obsessed-dr-who WhatsThat))

   =>

   (assert (UI-state (display HowManyPeopleDoYouWantToWatch)
                     (relation-asserted how-many-people-watch)
                     (response Five)
                     (valid-answers Five Two))))

(defrule determine-short-tall-people ""

   (logical (how-many-people-watch Two))

   =>

   (assert (UI-state (display DoYouWantToWatchShortOrTallPeople)
                     (relation-asserted short-tall-people)
                     (response Tall)
                     (valid-answers Tall Short))))

(defrule determine-girls-boys ""

   (logical (short-tall-people Tall))

   =>

   (assert (UI-state (display GirlsOrBoys)
                     (relation-asserted girls-boys)
                     (response Girls)
                     (valid-answers Girls Boys))))

(defrule determine-which-watch ""

   (logical (youtube-channel-type SomeoneElse))

   =>

   (assert (UI-state (display WhichDoYouWantToWatch)
                     (relation-asserted which-watch)
                     (response WeeklyShow)
                     (valid-answers WeeklyShow WebSeries SomethingElse))))

(defrule determine-which-fantasy-cooler ""

   (logical (which-watch WebSeries))

   =>

   (assert (UI-state (display WhichFantasyIsCooler)
                     (relation-asserted which-fantasy-cooler)
                     (response HarryPotter)
                     (valid-answers HarryPotter WorldOfWarcraft))))

(defrule determine-which-more-interesting ""

   (logical (which-watch WeeklyShow))

   =>

   (assert (UI-state (display WhichDoYouFindMoreInteresting)
                     (relation-asserted which-more-interesting)
                     (response ViralVideos)
                     (valid-answers ViralVideos CelebrityGossip))))
					 
(defrule determine-dominos-awesome ""

   (logical (which-watch SomethingElse))

   =>

   (assert (UI-state (display DominosAreAwsome)
                     (relation-asserted dominos-awesome)
                     (response True)
                     (valid-answers True False))))
					 
(defrule determine-like-destroyed ""

   (logical (dominos-awesome False))

   =>

   (assert (UI-state (display DoYouLikeSeeingThingsGetDestroyed)
                     (relation-asserted like-destroyed)
                     (response Absolutely)
                     (valid-answers Absolutely NotReally))))
					 
(defrule determine-blender-microwave ""

   (logical (like-destroyed Absolutely))

   =>

   (assert (UI-state (display InTheBlenderOrMicrowave)
                     (relation-asserted blender-microwave)
                     (response Absolutely)
                     (valid-answers Blender Microwave))))

(defrule determine-special-effects ""

   (logical (like-destroyed NotReally))

   =>

   (assert (UI-state (display HowAboutSpecialEffects)
                     (relation-asserted special-effects)
                     (response BringItOn)
                     (valid-answers BringItOn NoThanks))))

(defrule determine-would-you-rather-they-be ""

   (logical (special-effects BringItOn))

   =>

   (assert (UI-state (display WouldYouRatherTheyBe)
                     (relation-asserted would-you-rather-they-be)
                     (response ArtBased)
                     (valid-answers ArtBased MusicBased Explosive))))

(defrule determine-want-skit ""

   (logical (special-effects NoThanks))

   =>

   (assert (UI-state (display DoYouWantToWatchASkit)
                     (relation-asserted want-skit)
                     (response No)
                     (valid-answers No Sure))))

(defrule determine-easily-offended ""

   (logical (want-skit Sure))

   =>

   (assert (UI-state (display AreYouEasilyOffended)
                     (relation-asserted easily-offended)
                     (response No)
                     (valid-answers No Yes))))
					 
(defrule determine-would-you-rather-asian-white ""

   (logical (easily-offended Yes))

   =>

   (assert (UI-state (display WouldYouRatherWatchAsianBoysOrWhiteBoys)
                     (relation-asserted would-you-rather-asian-white)
                     (response Asian)
                     (valid-answers Asian White))))

(defrule determine-want-to-play ""

   (logical (want-skit No))

   =>

   (assert (UI-state (display WantToPlayAGame)
                     (relation-asserted want-to-play)
                     (response Yes)
                     (valid-answers Yes No))))

(defrule determine-like-statistics ""

   (logical (want-to-play No))

   =>

   (assert (UI-state (display DoYouLikeStatistics)
                     (relation-asserted like-statistics)
                     (response Yes)
                     (valid-answers Yes No))))

(defrule determine-public-pranks ""

   (logical (like-statistics No))

   =>

   (assert (UI-state (display HowAboutPublicPranks)
                     (relation-asserted public-pranks)
                     (response Yes)
                     (valid-answers Yes No))))

(defrule determine-help-charity ""

   (logical (public-pranks No))

   =>

   (assert (UI-state (display WantToHelpCharity)
                     (relation-asserted help-charity)
                     (response Yes)
                     (valid-answers Yes No))))

;;;****************
;;;* CHOSEN CHANNELS RULES *
;;;****************

(defrule conclusions-which-fantasy-cooler=hp ""

   (logical (which-fantasy-cooler HarryPotter))
   
   =>

   (assert (UI-state (display AnswerScarheadshow)
                     (state final))))

(defrule conclusions-which-fantasy-cooler-wow ""

   (logical (which-fantasy-cooler WorldOfWarcraft))
   
   =>

   (assert (UI-state (display AnswerWatchtheguild)
                     (state final))))

(defrule conclusions-which-more-interesting-vw ""

   (logical (which-more-interesting ViralVideos))
   
   =>

   (assert (UI-state (display AnswerRaywilliamjohnson)
                     (state final))))

(defrule conclusions-which-more-interesting-cg ""

   (logical (which-more-interesting CelebrityGossip))
   
   =>

   (assert (UI-state (display AnswerWhatthebuckshow)
                     (state final))))

(defrule conclusions-dominos-awesome ""

   (logical (dominos-awesome True))
   
   =>

   (assert (UI-state (display AnswerFlippycat)
                     (state final))))

(defrule conclusions-blender-microwave-blender ""

   (logical (blender-microwave Blender))
   
   =>

   (assert (UI-state (display AnswerBlendtec)
                     (state final))))

(defrule conclusions-blender-microwave-mv ""

   (logical (blender-microwave Microwave))
   
   =>

   (assert (UI-state (display AnswerJpizzle1122)
                     (state final))))

(defrule conclusions-would-you-rather-they-be-ab ""

   (logical (would-you-rather-they-be ArtBased))
   
   =>

   (assert (UI-state (display AnswerKickthepj)
                     (state final))))

(defrule conclusions-would-you-rather-they-be-mb ""

   (logical (would-you-rather-they-be MusicBased))
   
   =>

   (assert (UI-state (display AnswerMysteryguitarman)
                     (state final))))

(defrule conclusions-would-you-rather-they-be-ex ""

   (logical (would-you-rather-they-be Explosive))
   
   =>

   (assert (UI-state (display AnswerFreddiew)
                     (state final))))


(defrule conclusions-easily-offended ""

   (logical (easily-offended No))
   
   =>

   (assert (UI-state (display AnswerShanedawsontv)
                     (state final))))

(defrule conclusions-would-you-rather-asian-white-white ""

   (logical (would-you-rather-asian-white White))
   
   =>

   (assert (UI-state (display AnswerSmosh)
                     (state final))))

(defrule conclusions-would-you-rather-asian-white-asian ""

   (logical (would-you-rather-asian-white Asian))
   
   =>

   (assert (UI-state (display AnswerNigahiga)
                     (state final))))

(defrule conclusions-want-to-play ""

   (logical (want-to-play Yes))
   
   =>

   (assert (UI-state (display AnswerTruthorfail)
                     (state final))))

(defrule conclusions-like-statistics ""

   (logical (like-statistics Yes))
   
   =>

   (assert (UI-state (display AnswerTheWillofdc)
                     (state final))))

(defrule conclusions-public-pranks ""

   (logical (public-pranks Yes))
   
   =>

   (assert (UI-state (display AnswerImproveverywhere)
                     (state final))))

(defrule conclusions-help-charity-yes ""

   (logical (help-charity Yes))
   
   =>

   (assert (UI-state (display AnswerUnculturedproject)
                     (state final))))

(defrule conclusions-help-charity-no ""

   (logical (help-charity No))
   
   =>

   (assert (UI-state (display AnswerDecepticonYourPunishmentIsFred)
                     (state final))))




(defrule conclusions-girls ""

   (logical (girls-boys Girls))
   
   =>

   (assert (UI-state (display AnswerSistersalad)
                     (state final))))

(defrule conclusions-boys ""

   (logical (girls-boys Boys))
   
   =>

   (assert (UI-state (display AnswerVlogbrothers)
                     (state final))))

(defrule conclusions-old-videos ""

   (logical (new-old-videos Old))
   
   =>

   (assert (UI-state (display AnswerTardistacular)
                     (state final))))

(defrule conclusions-happy-relationships ""

   (logical (people-in-relationships-makes-you Happy))
   
   =>

   (assert (UI-state (display AnswerVloglovers)
                     (state final))))

(defrule conclusions-obsessed-dr-who ""

   (logical (are-you-obsessed-dr-who Absolutely))
   
   =>

   (assert (UI-state (display AnswerTardistacular)
                     (state final))))

(defrule conclusions-how-many-people-watch ""

   (logical (how-many-people-watch Five))
   
   =>

   (assert (UI-state (display AnswerFiveawesomegirls)
                     (state final))))

(defrule conclusions-short-people ""

   (logical (short-tall-people Short))
   
   =>

   (assert (UI-state (display AnswerShortsisters756)
                     (state final))))

(defrule conclusions-canada-is-cool ""

   (logical (canada-cool Yeah))
   
   =>

   (assert (UI-state (display AnswerGunarolla)
                     (state final))))

(defrule conclusions-which-funny ""

   (logical (which-funny JokesAboutChickens))
   
   =>

   (assert (UI-state (display AnswerRobofillet)
                     (state final))))

(defrule conclusions-which-funny ""

   (logical (which-funny SelfDepricatingHumor))
   
   =>

   (assert (UI-state (display AnswerCommunitychannel)
                     (state final))))

(defrule conclusions-david-attcrative ""

   (logical (david-attcrative Duh))
   
   =>

   (assert (UI-state (display AnswerLittleradge)
                     (state final))))

(defrule conclusions-twilight-no ""

   (logical (hate-twilight No))
   
   =>

   (assert (UI-state (display GetOutOfMyFlowchart)
                     (state final))))

(defrule conclusions-twilight-yes ""

   (logical (hate-twilight Yes))
   
   =>

   (assert (UI-state (display AnswerNerimon)
                     (state final))))

(defrule conclusions-twilight-dont-care ""

   (logical (hate-twilight DontCare))
   
   =>

   (assert (UI-state (display AnswerCharlieissocoollike)
                     (state final))))

(defrule conclusions-scripted ""

   (logical (scripted-spontaneous Scripted))
   
   =>

   (assert (UI-state (display AnswerElectricfaeriedust)
                     (state final))))
					 
(defrule conclusions-spontaneous ""

   (logical (scripted-spontaneous Spontaneous))
   
   =>

   (assert (UI-state (display AnswerMissxrojas)
                     (state final))))					 
					 
(defrule conclusions-like-rapping ""

   (logical (like-rapping Yes))
   
   =>

   (assert (UI-state (display AnswerHayleyghoover)
                     (state final))))							 
					 
(defrule conclusions-like-songs-breakfast ""

   (logical (like-songs-breakfast OfCourse))
   
   =>

   (assert (UI-state (display AnswerWheezywaiter)
                     (state final))))		

(defrule conclusions-like-charts-graphs ""

   (logical (like-charts-graphs Yes))
   
   =>

   (assert (UI-state (display AnswerMickeleh)
                     (state final))))		

(defrule conclusions-girls-boys-rule-boys ""

   (logical (girls-boys-rule Boys))
   
   =>

   (assert (UI-state (display AnswerLukeConard)
                     (state final))))	

(defrule conclusions-girls-boys-rule-girls ""

   (logical (girls-boys-rule Girls))
   
   =>

   (assert (UI-state (display AnswerItalktosnakes)
                     (state final))))	

(defrule conclusions-watch-fiveawesomegirl ""

   (logical (watch-fiveawesomegirl Yes))
   
   =>

   (assert (UI-state (display AnswerDevilishlypure)
                     (state final))))
					 
(defrule conclusions-like-happy-people ""

   (logical (like-happy-people Smile))
   
   =>

   (assert (UI-state (display AnswerHopeonatenspeed)
                     (state final))))
					 
(defrule conclusions-want-vlogger-to ""

   (logical (want-vlogger-to TalkFast))
   
   =>

   (assert (UI-state (display AnswerFizzylimon)
                     (state final))))
					 
(defrule conclusions-prefer-review ""

   (logical (prefer-review Technology))
   
   =>

   (assert (UI-state (display AnswerIjustine)
                     (state final))))

(defrule conclusions-prefer-review-books ""

   (logical (prefer-review Books))
   
   =>

   (assert (UI-state (display AnswerBandgeek8408)
                     (state final))))

(defrule conclusions-want-daily-videos ""

   (logical (want-daily-videos Yes))
   
   =>

   (assert (UI-state (display AnswerBreakingnyc)
                     (state final))))

(defrule conclusions-need-avice ""

   (logical (need-avice YesPlease))
   
   =>

   (assert (UI-state (display AnswerPeron75)
                     (state final))))

(defrule conclusions-play-different-versions ""

   (logical (play-different-versions Yes))
   
   =>

   (assert (UI-state (display AnswerElmify)
                     (state final))))

(defrule conclusions-want-watch-someone-world ""

   (logical (want-watch-someone TalkWorldIssues))
   
   =>

   (assert (UI-state (display AnswerPogobat)
                     (state final))))

(defrule conclusions-want-watch-someone-makeup ""

   (logical (want-watch-someone PutOnMakeUp))
   
   =>

   (assert (UI-state (display AnswerMichellephan)
                     (state final))))

(defrule conclusions-want-watch-someone-rant ""

   (logical (want-watch-someone RantAndBeAdorable))
   
   =>

   (assert (UI-state (display AnswerMeekakitty)
                     (state final))))

(defrule conclusions-typography ""

   (logical (typography Agreed))
   
   =>

   (assert (UI-state (display AnswerXperpetualmotion)
                     (state final))))

(defrule conclusions-girls-or-boys-boys ""

   (logical (girls-or-boys Boys))
   
   =>

   (assert (UI-state (display AnswerAlanvlogs)
                     (state final))))

(defrule conclusions-girls-or-boys-girls ""

   (logical (girls-or-boys Girls))
   
   =>

   (assert (UI-state (display AnswerOwlssayhooot)
                     (state final))))

(defrule conclusions-picky ""

   (logical (picky Yup))
   
   =>

   (assert (UI-state (display AnswerTryThatzakEveryoneLikesHim)
                     (state final))))















(defrule no-repairs ""

   (declare (salience -10))
  
   (logical (UI-state (id ?id)))
   
   (state-list (current ?id))
     
   =>
  
   (assert (UI-state (display NoResult)
                     (state final))))
                     
;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question

   (declare (salience 5))
   
   (UI-state (id ?id))
   
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
             
   =>
   
   (modify ?f (current ?id)
              (sequence ?id ?s))
   
   (halt))

(defrule handle-next-no-change-none-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
                      
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-response-none-end-of-chain

   (declare (salience 10))
   
   ?f <- (next ?id)

   (state-list (sequence ?id $?))
   
   (UI-state (id ?id)
             (relation-asserted ?relation))
                   
   =>
      
   (retract ?f)

   (assert (add-response ?id)))   

(defrule handle-next-no-change-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
     
   (UI-state (id ?id) (response ?response))
   
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-change-middle-of-chain

   (declare (salience 10))
   
   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
     
   (UI-state (id ?id) (response ~?response))
   
   ?f2 <- (UI-state (id ?nid))
   
   =>
         
   (modify ?f1 (sequence ?b ?id ?e))
   
   (retract ?f2))
   
(defrule handle-next-response-end-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)
   
   (state-list (sequence ?id $?))
   
   ?f2 <- (UI-state (id ?id)
                    (response ?expected)
                    (relation-asserted ?relation))
                
   =>
      
   (retract ?f1)

   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))
      
   (assert (add-response ?id ?response)))   

(defrule handle-add-response

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id ?response)
                
   =>
      
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   
   (retract ?f1))   

(defrule handle-add-response-none

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id)
                
   =>
      
   (str-assert (str-cat "(" ?relation ")"))
   
   (retract ?f1))   

(defrule handle-prev

   (declare (salience 10))
      
   ?f1 <- (prev ?id)
   
   ?f2 <- (state-list (sequence $?b ?id ?p $?e))
                
   =>
   
   (retract ?f1)
   
   (modify ?f2 (current ?p))
   
   (halt))
   
