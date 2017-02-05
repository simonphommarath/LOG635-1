;;;======================================================
;;; LOG-635 Laboratoire 1
;;; Author:
;;; 	Simon Phommarath
;;; 	Nicolas Arsenault
;;; 	Yannick Maringo
;;; 
;;;======================================================

(clear)

;;;======================================================
;;; FACT OF CRIME SCENE
;;;======================================================

(deffacts facts-crime-sceen
	;victim
	(victim-wound pure)
	(victim-temperature-is-at-phase 3)
	(victim-coagulation-is-at-phase 3)
	(victim-skin-detoriation-is-at-phase 3)

	;hair
	(hair-lenght-on-crime short)
	(hair-color-on-crime skin-3)
	(hair-age-on-crime 30 to 60)

	;smells
	(place-smell-like health)

	;place
	(crime-location mid-lane)
	(current-time-is 19)

	;receipt
	(receipt-on-crime 6000)

	;footprint
	(footprint-on-crime dire)
)


;;;======================================================
;;; FACT OF SUSPECT
;;;======================================================

(deffacts facts-suspect
	;Killer
	(suspect Pudge)
		(has-age-of Pudge 50)
		(hair-lenght-of Pudge short)
		(hair-color-of Pudge skin-1)
		(hair-color-is-dyed Pudge)
		(has-footprint Pudge dire)
		(like-to-eat Pudge salve)
		(was-at Pudge roshan from-t 12 to-t 13)
		(travel Pudge by tp-scroll)
		(travel Pudge by walking)

	(suspect Drow-Ranger)
		(has-age-of Drow-Ranger 25)
		(hair-lenght-of Drow-Ranger long)
		(hair-color-of Drow-Ranger skin-2)
		(hair-color-is-dyed Drow-Ranger)
		(has-footprint Drow-Ranger dire)
		(like-to-eat Drow-Ranger aegis)
		(like-to-eat Drow-Ranger tango)
		(was-at Drow-Ranger top-lane from-t 14 to-t 16)
		(travel Drow-Ranger by tp-ult)

	(suspect Huskar)
		(has-age-of Huskar 41)
		(hair-lenght-of Huskar short)
		(hair-color-of Huskar skin-3)
		(has-footprint Huskar radiant)
		(like-to-eat Huskar cheese)
		(like-to-eat Huskar tango)
		(was-at Huskar bot-lane from-t 8 to-t 10)
		(travel Huskar by tp-spell)
		(travel Huskar by walking)

	(suspect Invoker)
		(has-age-of Invoker 32)
		(hair-lenght-of Invoker short)
		(hair-color-of Invoker skin-4)
		(hair-color-is-dyed Invoker)
		(has-footprint Invoker dire)
		(like-to-eat Invoker mango)
		(was-at Invoker ennemy-fountain from-t 14 to-t 16)
		(travel Invoker by tp-scroll)
)

;;;======================================================
;;; FACT OF ARMS 
;;;======================================================

(deffacts wound-types
	(wound-type slash)
	(wound-type bash)
	(wound-type pierce)
	(wound-type magical)
	(wound-type pure)
)

(deffacts weapon-types
  	(weapon-type blade slash)
  	(weapon-type spear slash)
  	(weapon-type spear pierce)
	(weapon-type hammer bash)
	(weapon-type staff bash)
	(weapon-type wand magical)
	(weapon-type book magical)
	(weapon-type book pure)
	(weapon-type curse pure)
	(weapon-type holy pure)
)

(deffacts temperature-affected-weapon-types
  	(temperature-phase-modification curse 1)
	(temperature-phase-modification holy -1)
)

(deffacts coagulation-affected-weapon-types
  	(coagulation-phase-modification blade 1)
)

(deffacts skin-detoriation-affected-weapon-types
  	(skin-detoriation-phase-modification spear -1)
)

(deffacts weapons
  	(weapon shadow-blade blade)
	(weapon echo-saber blade)
  	(weapon javelin spear)
  	(weapon malestrom hammer)
	(weapon monkey-king-bar staff)
	(weapon quarter-staff staff)
  	(weapon dagon wand)
	(weapon necronomicon book)
  	(weapon atos curse)
	(weapon ghost-scepter curse)
	(weapon divine-rapier holy)
)

(deffacts weapons
	(weapon-price shadow-blade 2700)
	(weapon-price echo-saber 2650)
  	(weapon-price javelin 1550)
  	(weapon-price malestrom 2800)
	(weapon-price monkey-king-bar 5400)
	(weapon-price quarter-staff 900)
  	(weapon-price dagon 2720)
	(weapon-price necronomicon 2650)
  	(weapon-price atos 3100)
	(weapon-price ghost-scepter 1550)
	(weapon-price divine-rapier 6200)
)

;;;======================================================
;;; FACT OF PLACE 
;;;======================================================

(deffacts fact-distance
  	(distance-between mid-lane roshan is-t 10000)
	(distance-between mid-lane top-lane is-t 6000)
	(distance-between mid-lane bot-lane is-t 5000)
	(distance-between mid-lane ennemy-fountain is-t 2000)
)

;;;======================================================
;;; FACT OF VEICHUL
;;;======================================================

(deffacts fact-mobility
  	(travel-by tp-scroll 2000 gas 50)
	(travel-by walking 500 gas 5)
	(travel-by tp-spell 2000 gas 70)
	(travel-by tp-ult 2000 gas 100)
)

(deffacts fact-gas
  (gas-price 10)
)

;;;======================================================
;;; FACT OF LUNCH
;;;======================================================

(deffacts lunch
	(lunch aegis 1000)
	(lunch-smell aegis health)
	(lunch-smell aegis mana)

	(lunch cheese 400)
	(lunch-smell cheese health)
	(lunch-smell cheese mana)

	(lunch mango 110)
	(lunch-smell mango mana)

	(lunch tango 125)
	(lunch-smell tango health)

	(lunch salve 110)
	(lunch-smell salve health)
)

;;;======================================================
;;; FACT OF LUNCH
;;;======================================================

(deffacts fact-dye-price
	(dye-price-is skin-1 250)
	(dye-price-is skin-2 300)
	(dye-price-is skin-3 500)
	(dye-price-is skin-4 600)
)

(batch "main.clp")
