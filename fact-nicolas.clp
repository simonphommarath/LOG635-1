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
	(victim-wound burn)
	(victim-temperature-is-at-phase 1)
	(victim-coagulation-is-at-phase 2)
	(victim-skin-detoriation-is-at-phase 2)

	;haire
	(hair-lenght-on-crime short)
	(hair-color-on-crime blue)
	(hair-age-on-crime 20 to 30)

	;smells
	(place-smell-like cheese)

	;place
	(crime-location Naboo)
	(current-time-is 19)

	;receipt
	(receipt-on-crime 1800)

  ;footprint
	(footprint-on-crime rebel)
)


;;;======================================================
;;; FACT OF SUSPECT
;;;======================================================

(deffacts facts-suspect

  ;Killer
	(suspect Anakin-Skywalker)
	(has-age-of Anakin-Skywalker 24)
	(hair-lenght-of Anakin-Skywalker short)
	(hair-color-of Anakin-Skywalker green)
	(hair-color-is-dyed Anakin-Skywalker)
	(has-footprint Anakin-Skywalker rebel)
	(like-to-eat Anakin-Skywalker sandwich)
	(like-to-eat Anakin-Skywalker crunchy)
	(was-at Anakin-Skywalker Endor from-t 14 to-t 16)
	(travel Anakin-Skywalker by V-Wings)
	(travel Anakin-Skywalker by ATT)
	(travel Anakin-Skywalker by AT-AT)


  (suspect Han-Solo)
	(has-age-of Han-Solo 24)
	(hair-lenght-of Han-Solo short)
	(hair-color-of Han-Solo green)
	(has-footprint Han-Solo rebel)
	(like-to-eat Han-Solo sandwich)
	(like-to-eat Han-Solo crunchy)
	(was-at Han-Solo Alderaan from-t 8 to-t 10)
	(travel Han-Solo by Millennium-Falcon)

  (suspect Obi-Wan-Kenobi)
	(has-age-of Obi-Wan-Kenobi 24)
	(hair-lenght-of Obi-Wan-Kenobi long)
	(hair-color-of Obi-Wan-Kenobi red)
	(hair-color-is-dyed Obi-Wan-Kenobi)
	(has-footprint Obi-Wan-Kenobi rebel)
	(like-to-eat Obi-Wan-Kenobi super-snack)
	(was-at Obi-Wan-Kenobi Aquilae from-t 12 to-t 13)
	(travel Obi-Wan-Kenobi by X-Wings)
	(travel Obi-Wan-Kenobi by U-Wings)

  (suspect Jyn-Erso)
	(has-age-of Jyn-Erso 24)
	(hair-lenght-of Jyn-Erso short)
	(hair-color-of Jyn-Erso red)
	(has-footprint Jyn-Erso rebel)
	(like-to-eat Jyn-Erso sandwich)
	(like-to-eat Jyn-Erso crunchy)
	(was-at Jyn-Erso Alderaan from-t 14 to-t 16)
	(travel Jyn-Erso by V-Wings)

)


;;;======================================================
;;; FACT OF ARMS 
;;;======================================================

(deffacts wound-types
  (wound-type laceration)
	(wound-type burn)
	(wound-type ice)
	(wound-type fracture)
	(wound-type internal)
)

(deffacts weapon-types
  (weapon-type blade laceration)
	(weapon-type laser laceration)
	(weapon-type laser burn)
	(weapon-type fire burn)
	(weapon-type ice-canon ice)
	(weapon-type blunt fracture)
	(weapon-type poison internal)
)

(deffacts temperature-affected-weapon-types
  (temperature-phase-modification burn 1)
	(temperature-phase-modification ice -1)
)

(deffacts coagulation-affected-weapon-types
  (coagulation-phase-modification burn -2)
)

(deffacts skin-detoriation-affected-weapon-types
  (skin-detoriation-phase-modification internal 1)
)

(deffacts weapons
  (weapon lightsaber laser)
	(weapon blaster laser)

  (weapon flame-thrower fire)
	(weapon napalme-thrower fire)

  (weapon ice-gun ice)
	(weapon mace blunt)
	(weapon flail blunt)

  (weapon sword blade)
	(weapon knife blade)

  (weapon cyanide poison)
	(weapon strychnine poison)
	(weapon rodians poison)
)

(deffacts weapons
  (weapon-price lightsaber 2000)
	(weapon-price blaster 1000)
	(weapon-price flame-thrower 1200)
	(weapon-price napalme-thrower 1450)
	(weapon-price ice-gun 1300)
	(weapon-price mace 600)
	(weapon-price flail 800)
	(weapon-price sword 1400)
	(weapon-price knife 200)
	(weapon-price cyanide 300)
	(weapon-price strychnine 100)
	(weapon-price rodians 500)
)

;;;======================================================
;;; FACT OF PLACE 
;;;======================================================

(deffacts fact-distance
  (distance-between Naboo Tatooine is-t 10000)
	(distance-between Naboo Aquilae is-t 23000)
	(distance-between Naboo Endor is-t 1200)
	(distance-between Naboo Alderaan is-t 250)
)

;;;======================================================
;;; FACT OF VEICHUL
;;;======================================================

(deffacts fact-mobility
  (travel-by X-Wings 995 gas 5.5)
	(travel-by U-Wings 940 gas 4.5)
	(travel-by V-Wings 930 gas 12)
	(travel-by ATT 800 gas 23)
	(travel-by AT-AT 30 gas 50)
	(travel-by Millennium-Falcon 1050 gas 25)
)

(deffacts fact-gas
  (gas-price 4.53)
)

;;;======================================================
;;; FACT OF LUNCH
;;;======================================================

(deffacts lunch
  (lunch sandwich 10)
	(lunch-smell sandwich cheese)
	(lunch-smell sandwich ham)

  (lunch super-snack 600)
	(lunch-smell snack cheese)

  (lunch nutelas 5)
	(lunch-smell chocolate)

  (lunch crunchy 4)
	(lunch-smell chocolate)
)

;;;======================================================
;;; FACT OF LUNCH
;;;======================================================
(deffacts fact-dye-price
  (dye-price-is red 100)
	(dye-price-is green 150)
	(dye-price-is blue 200)
)

(batch "main.clp")
