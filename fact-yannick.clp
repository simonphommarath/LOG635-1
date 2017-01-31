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

(deffacts fact
	(hair-lenght-on-crime long)
	(hair-color-on-crime blond)
)

(deffacts fact
	(lieu-smell-like fishes)
)

;;
;;;;;;MODULE FACTURE
;;
(deffacts fact
	(facture-on-crime 50)
	(amountDiscovered-for 0)	;; For each person, initialize to 0 NEED TO ADD NAME INCOMPLETE GO SIMON !!!
	
	(price-of-blond-dye 20)
	(price-of-brown-dye 51)
	(price-of-black-dye 25) ;;unused
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
	(crime-was-at park at-t 3)
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
	;;Karl
	(likeToEat karl nutelas)
	(hair-lenght-of karl long)
	(hair-color-of karl blond)
	(has-weapon karl knife)


	;;Sam
	(likeToEat sam fishes)
	(hair-lenght-of sam long)
	(hair-color-of sam dyed)
	(has-weapon sam hammer)


	;;Bob killer
	(likeToEat bob nutelas)
	(likeToEat bob fishes)
	(hair-lenght-of bob short)
	(hair-color-of bob blond)
	(has-weapon bob knife)

	
	;;Roger
	(likeToEat roger fishes)
	(has-weapon roger wrench)
	
	;;Nicolas
	(has-weapon nicolas shovel)

)

;;;======================================================
;;; Faits Lieux-temps - nick
;;;======================================================

(deffacts fact-place
	(was-at karl cafe from-t 2 to-t 4)
	(was-at bob cafe from-t 8 to-t 10)
)

(deffacts fact-distance
	(distance-between park cafe is-t 0.5)
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