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

(deffacts facts-crime-scene
	;victim
	(victim-wound burn)
	(victim-temperature-is-at-phase 1)
	(victim-coagulation-is-at-phase 2)
	(victim-skin-detoriation-is-at-phase 2)

	;hair
	(hair-lenght-on-crime short)
	(hair-color-on-crime brown)
	(hair-age-on-crime 20 to 28)

	;smells
	(place-smell-like cheese)

	;place
	(crime-location Yoshis-island)
	(current-time-is 19)

	;receipt
	(receipt-on-crime 200)

  ;footprint
	(footprint-on-crime average)
)


;;;======================================================
;;; FACT OF SUSPECT
;;;======================================================

(deffacts facts-suspect

  ;Killer
	(suspect Luigi)
	(has-age-of Luigi 23)
	(hair-lenght-of Luigi short)
	(hair-color-of Luigi brown)
	(hair-color-is-dyed Luigi)
	(has-footprint Luigi average)
	(like-to-eat Luigi mushrooms)
	(like-to-eat Luigi macaroni-and-cheese)
	(like-to-eat Luigi pastas)
	(like-to-eat Luigi crunchy)
	(was-at Luigi Yoshis-island from-t 14 to-t 16)
	(travel Luigi by Standard-kart)
	(travel Luigi by Cat-Cruiser)
	(travel Luigi by Circuit-Special)

  (suspect mario)
	(has-age-of mario 25)
	(hair-lenght-of mario short)
	(hair-color-of mario brown)
	(has-footprint mario average)
	(like-to-eat mario mushrooms)
	(like-to-eat mario macaroni-and-cheese)
	(like-to-eat mario pastas)
	(was-at mario Yoshis-island from-t 8 to-t 10)
	(travel mario by Standard-kart)

  (suspect Peach)
	(has-age-of Peach 19)
	(hair-lenght-of Peach long)
	(hair-color-of Peach blond)
	(hair-color-is-dyed Peach)
	(has-footprint Peach small)
	(like-to-eat Peach caviar)
	(like-to-eat Peach pastas)
	(was-at Peach cookie-mountain from-t 8 to-t 10)
	(travel Peach by Standard-kart)
	(travel Peach by Cat-Cruiser)
	(travel Peach by Bad-Wagon)
	(travel Peach by Pipe-Frame)
	(travel Peach by Circuit-Special)
	(travel Peach by Tri-Speeder)	
	
  (suspect Bowser)
	(has-age-of Bowser 44)
	(hair-lenght-of Bowser long)
	(hair-color-of Bowser orange)
	(has-footprint Bowser big)
	(like-to-eat Bowser sandwich)
	(like-to-eat Bowser bucket-of-lava)
	(like-to-eat Bowser caviar)
	(like-to-eat Bowser koopa)
	(like-to-eat Bowser goomba)
	(was-at Bowser valler-of-bowser from-t 14 to-t 16)
	(travel Bowser by Standard-kart)
	(travel Bowser by Pipe-Frame)
	(travel Bowser by LandShip)

  (suspect Wario)
	(has-age-of Wario 27)
	(hair-lenght-of Wario short)
	(hair-color-of Wario brown)
	(has-footprint Wario average)
	(like-to-eat Wario sandwich)
	(like-to-eat Wario candies)
	(like-to-eat Wario macaroni-and-cheese)
	(was-at Wario soda-lake from-t 14 to-t 16)
	(travel Wario by Standard-kart)
	(travel Wario by Bad-Wagon)
	(travel Wario by Pipe-Frame)
	(travel Wario by Circuit-Special)
)


;;;======================================================
;;; FACT OF ARMS 
;;;======================================================

(deffacts wound-types
  (wound-type laceration)
	(wound-type burn)
	(wound-type blunt)
	(wound-type fracture)
	(wound-type internal)
)

(deffacts weapon-types
	(weapon-type slip slip)
	(weapon-type fire burn)
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
	(weapon red-koopa-shell blunt)
	(weapon green-koopa-shell blunt)
	(weapon banana slip)
	(weapon fake-item-box blunt)
	(weapon blooper burnt)
	(weapon lighning-bolt fire)
	(weapon blue-spiny-shell blunt-pierce)
	(weapon BulletBill explosive)
	(weapon Bob-omb explosive)
)

(deffacts weapons
	(weapon-price red-koopa-shell 50)
	(weapon-price green-koopa-shell 20)
	(weapon-price banana 10)
	(weapon-price fake-item-box 30)
	(weapon-price blooper 40)
	(weapon-price lighning-bolt 75)
	(weapon-price blue-spiny-shell 85)
	(weapon-price BulletBill 100)
	(weapon-price Bob-omb 80)
)

;;;======================================================
;;; FACT OF PLACE
;;;======================================================

(deffacts fact-distance
	(distance-between Yoshis-island soda-lake is-t 2100)
	(distance-between Yoshis-island cookie-mountain is-t 1600)
	(distance-between Yoshis-island valler-of-bowser is-t 3300)
	(distance-between Yoshis-island star-world is-t 3900)
)

;;;======================================================
;;; FACT OF VEHICULE
;;;======================================================

(deffacts fact-mobility
	(travel-by Standard-kart 700 gas 5.5)
	(travel-by Pipe-Frame 500 gas 4)
	(travel-by Cat-Cruiser 630 gas 5.5)
	(travel-by Circuit-Special 1200 gas 6)
	(travel-by Tri-Speeder 1300 gas 4)
	(travel-by Bad-Wagon 750 gas 10)
	(travel-by LandShip 850 gas 25)
)

(deffacts fact-gas
	(gas-price 2.50)
)

;;;======================================================
;;; FACT OF LUNCH
;;;======================================================

(deffacts lunch
  (lunch macaroni-and-cheese 20)
	(lunch-smell macaroni-and-cheese cheese)

  (lunch mushrooms 5)
	(lunch-smell mushrooms veges)

  (lunch poison-plants 15)
	(lunch-smell poison-plants poison)
  
  (lunch candies 10)
	(lunch-smell candies candies)
	
  (lunch bucket-of-lava 200)
	(lunch-smell bucket-of-lava burnt)
  
  (lunch caviar 100)
	(lunch-smell caviar rich)
	
  (lunch koopa 30)
    (lunch-smell koopa turtles)
   
  (lunch goomba 10)
    (lunch-smell goomba chocolate)
)

;;;======================================================
;;; FACT OF DYE
;;;======================================================
(deffacts fact-dye-price
	(dye-price-is green 15)
	(dye-price-is blue 13)
	(dye-price-is orange 10)
	(dye-price-is brown 12)
)

(batch "main.clp")
