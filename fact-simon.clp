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

(deffacts victim-wound "The wound types on the victim"
	(victim-wound laceration)
)

(deffacts corpse-phase
	(corpse-body-temperature-is-at-phase 4)
	(corpse-coagulation-is-at-phase 3)
	(corpse-skin-detoriation-is-at-phase 3)
)

(deffacts fact-hair-lenght
	(hair-lenght-on-crime long)
	(hair-color-on-crime blond)
)

(deffacts fact-smell
	(lieu-smell-like cheese)
	(lieu-found-item-fingerprints triangle)
)

(deffacts fact-receipt
	(receipt-on-crime 50)
)

(deffacts crime-location
	(crime-location park)
)

(deffacts current-investigation-time
	(current-time-is 11)
)

(deffacts body-temperature-on-crime-scene
	(body-temperature-is 10)
)

; Victim body temperature
; Victim blood coagulation
; Victim struggle + not-victim-blood -> Killer = wounded
; Fake evidence on crime scene
; Finger prints
; Victim job -> Victim Tools/weapon

;;;======================================================
;;; FACT OF SUSPECT
;;;======================================================

(deffacts suspect
	(suspect bob)
	(suspect karl)
	(suspect sam)
	(suspect bob2)
	(suspect roger)
)

(deffacts lunch
	(lunch sandwich 10)
	(lunch-smell sandwich cheese)
	(lunch-smell sandwich ham)

	(lunch cheese-fish 4)
	(lunch-smell cheese-fish cheese)

	(lunch nutelas 5)
	(lunch-smell chocolate)
)

(deffacts fact
	;;Country Canada
	(country-of-crime canada)
	(punitence-of-country canada deathPenalty)
	(age-of-adult-of canada 18)
	
	;;Country Mexico
	(punitence-of-country mexico none)
	(age-of-adult-of mexico 15)


	;;Karl
	(like-to-eat karl nutelas)
	(hair-lenght-of karl long)
	(hair-color-of karl brown)
	(has-weapon karl knife)
	(has-fingerprint karl triangle)
	(has-age-of karl 12)

	;;Sam
	(like-to-eat sam fishes)
	(hair-lenght-of sam long)
	(hair-color-of sam blond)
	(hair-color-is-dyed sam)
	(has-weapon sam hammer)
	(has-fingerprint sam circle)
	(has-age-of sam 15)

	;;Bob killer
	(like-to-eat bob nutelas)
	(like-to-eat bob fishes)
	(hair-lenght-of bob short)
	(hair-color-of bob blond)
	(has-weapon bob knife)
	(has-fingerprint bob triangle)
	(has-age-of bob 21)

	;;Bob2 killer
	(like-to-eat bob2 nutelas)
	(like-to-eat bob2 fishes)
	(hair-lenght-of bob2 short)
	(hair-color-of bob2 blond)
	(has-weapon bob2 knife)
	(has-fingerprint bob2 triangle)
	(has-age-of bob2 21)

	;;Roger
	(like-to-eat roger fishes)
	(has-weapon roger wrench)
	(has-fingerprint roger triangle)
	(has-age-of roger 30)
	
	;;Nicolas
	(has-weapon nicolas shovel)
	(has-age-of nicolas 22)

)

(deffacts fact-dye-price
	(dye-price-is blond 10)
	(dye-price-is brown 15)
	(dye-price-is black 20)
)

(deffacts fact-gas-price-by-liter
	(one-liter-gas-price-is 13)
)

;;;======================================================
;;; Faits Lieux-temps - nick
;;;======================================================

(deffacts fact-place
	(was-at karl park from-t 14 to-t 16)
	(was-at bob park from-t 8 to-t 10)
	(was-at bob cafe from-t 10 to-t 12)
	(was-at john cafe from-t 10 to-t 14)
)

(deffacts fact-distance
	(distance-between park cafe is-t 100)
)

(deffacts fact-mobility
	(travel-at carr 100 gas 13)
	(travel-at bike 70 gas 4.5)
)

(deffacts fact-gas
	(gas-price 2)
)

(deffacts fact-travel-by
	(travel-by bob carr)
	(travel-by bob bike)
	(travel-by karl carr)
	(travel-by john bike)
)

(deffacts fact-receipt
	(receipt-on-crime 100)
)

;;;======================================================
;;; FACT OF WEAPON
;;;======================================================

(deffacts wound-types "the wound types"
    (wound-type laceration)
    (wound-type puncture)
    (wound-type avulsion-fracture)
    (wound-type mouth-erosion)
    (wound-type blue-skin)
    (wound-type red-eye)
    (wound-type skin-rash)
)

(deffacts weapon-types "Weapon type classified by wound type"
    (weapon-type slash laceration)
    (weapon-type pierce puncture)
    (weapon-type bullet puncture)
    (weapon-type shell puncture)
    (weapon-type blunt avulsion-fracture)
	(weapon-type poison mouth-erosion)
    (weapon-type poison blue-skin)
    (weapon-type poison red-eye)
    (weapon-type poison skin-rash)
)

(deffacts weapons "Weapon classified by weapon type"
    (weapon hammer blunt)
    (weapon sledgehammer blunt)
    (weapon wrench blunt)
    (weapon shovel blunt)
	(weapon pistol bullet)
    (weapon shotgun shell)
    (weapon knife slash)
	(weapon blade slash)
	(weapon machete slash)
    (weapon screwdriver pierce)
    (weapon icepick pierce)
    (weapon nailgun pierce)
    (weapon poison-vial poison)
    (weapon poison-seringue poison)
)

(deffacts weapons-price
	(weapon-price knife 50)
	(weapon-price blade 150)
	(weapon-price machete 180)
)

; Doesn't make sense, I know
(deffacts weapon-types "Poison type classified by container type"
    (weapon-type detergent poison-vial)
    (weapon-type insecticide poison-vial)
    (weapon-type windwasher poison-vial)
    (weapon-type gasoline poison-vial)
    (weapon-type drugs poison-seringue)
	(weapon-type snakebite poison-seringue)
    (weapon-type SodiumThiopental poison-seringue)
)

(deffacts job "Weapon classified by jobs"
    (job detergent garagist)
    (job insecticide pestControl)
    (job windwasher garagist)
    (job gasoline garagist)
    (job drugs doctor)
	(job snakebite pestControl)
    (job SodiumThiopental doctor)
	(job hammer garagist)
	(job sledgehammer garagist)
	(job wrench garagist)
	(job shovel garagist)
	(job pistol policeOfficer)
	(job shotgun policeOfficer)
	(job knife policeOfficer)
	(job blade policeOfficer)
	(job machete pestControl)
	(job screwdriver garagist)
	(job nailgun garagist)
)

(batch "main.clp")
