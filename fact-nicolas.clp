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
	(vitim-wound laceration)
)

(deffacts fact
	(hair-lenght-on-crime long)
	(hair-color-on-crime blond)
)

(deffacts fact
	(lieu-smell-like fishes)
)

/*
(deffacts weapon-hint-on-crime-scene "hint on crime of scene"
	(scene-has shell-casing)
	(scene-has empty-vial)
	(scene-has empty-seringue)
	(scene-has blood-spat)
)
*/

(deffacts fact-crime-place
	(crime-was-at park at-t 15)
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

(deffacts fact
	(has-weapon karl knife)
	(has-weapon bob knife)
	(has-weapon sam hammer)
	(has-weapon roger wrench)
	(has-weapon nicolas shovel)
)

(deffacts fact
	(like-to-eat karl nutelas)
	(hair-lenght-of karl long)
	(hair-color-of karl blond)

	(like-to-eat sam fishes)
	(hair-lenght-of sam long)
	(hair-color-of sam dyed)

	(like-to-eat bob nutelas)
	(like-to-eat bob fishes)
	(hair-lenght-of bob short)
	(hair-color-of bob blond)
	
	(like-to-eat roger fishes)
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

(deffacts fact-gaz
	(gas-price 2)
)

(deffacts fact-travel-by
	(travel-by bob carr)
	(travel-by bob bike)
	(travel-by karl carr)
	(travel-by john bike)
)

(deffacts suspect
	(suspect bob)
	(suspect karl)
	(suspect john)
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
