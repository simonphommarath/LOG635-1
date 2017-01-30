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


;;;======================================================
;;; Faits Lieux-temps - nick
;;;======================================================

(deffacts fact-place
	(was-at karl cafe from-t 2 to-t 4)
	(was-at bob cafe from-t 8 to-t 10)
)

(deffacts fact-crime-place
	(crime-was-at park at-t 3)
)

(deffacts fact-distance
	(distance-between park cafe is-t 0.5)
)

;;;======================================================
; Faits arms-blessure - sim
;;;======================================================



;;;======================================================
;; FAITS EMPRUNTS - yannick
;;;======================================================
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
	(has-weapon nicolas shovel)
)

(deffacts fact
	(likeToEat karl nutelas)
	(hair-lenght-of karl long)
	(hair-color-of karl blond)

	(likeToEat sam fishes)
	(hair-lenght-of sam long)
	(hair-color-of sam dyed)

	(likeToEat bob nutelas)
	(likeToEat bob fishes)
	(hair-lenght-of bob short)
	(hair-color-of bob blond)
	
	(likeToEat roger fishes)
)

;;;======================================================
;;; Faits Lieux-temps - nick
;;;======================================================



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

;;;======================================================
;; FAITS ODEURS - yannick
;;;======================================================


;;;======================================================
;;; Faits lien avec victime  -not now
;;;======================================================


;;;======================================================
;;; Règle de départ
;;;======================================================

(defrule startup
    =>
    (readline)
    (printout t "Start" crlf)
    (assert (started))
)

;;;======================================================
;;; Rule Lieux-temps
;;;======================================================

(defrule was-there
	(declare (salience 0))
	(crime-was-at ?location at-t ?tcrime)
	(was-at ?name ?location from-t ?tstart to-t ?tend)
	(test (>= ?tcrime ?tstart))
	(test (<= ?tcrime ?tend))
	=>
	(assert (was-there ?name))
)

;;;======================================================
;;; RULES VICTIM-WOUND
;;;======================================================

(defrule woundTypeDeduction
	(declare (salience 0) )
	(vitim-wound ?wound)
	(wound-type ?wound)
	=>
	(printout t "Wound of victim is " ?wound " types" crlf)
	(assert(wound-of-crime-type ?wound))
)

(defrule weaponTypeDeduction
	(declare (salience 0) )
	(wound-of-crime-type ?wound)
	(weapon-type ?weaponType ?wound)
	=>
	(printout t "the weapon of crime can be of " ?weaponType " types" crlf)
	(assert(weapon-of-crime-type ?weaponType))
)

(defrule weaponDeduction
	(declare (salience 0) )
	(weapon-of-crime-type ?weaponType)
	(weapon ?weapon ?weaponType)
	=>
	(printout t "the weapon of crime can be " ?weapon " types" crlf)
	(assert(can-be-weapon ?weapon))
)

/*
(defrule job-has-weapon
	(declare (salience 0) )
	(can-be-weapon ?weapon)
	(job ?weapon ?job)
	=>
	(printout t "The suspect can be " ?name" based on weapon possibility" crlf)
	(assert(is-potential-killer-from-weapon ?name))
)
*/

(defrule weapon-suspect
	(declare (salience 0) )
	(can-be-weapon ?weapon)
	(has-weapon ?name ?weapon)
	=>
	(printout t "The suspect can be " ?name" based on weapon possibility" crlf)
	(assert(is-potential-killer-from-weapon ?name))
)



;;;======================================================
;;; RULES EMPRUNTS
;;;======================================================

(defrule cheveuxLongBlond
	(declare (salience 39) )
	(personnage ?name a longCheveuxBlond)
	=>
	(printout t ?name " is tired." crlf)
)

(defrule cheveuxLongBrun
	(declare (salience 39) )
	(personnage ?name a longCheveuxBrun)
	=>
	(printout t ?name " is tired." crlf)
)

(defrule cheveuxLongBrun
	(declare (salience 39) )
	(hair-color-of ?name ?color)
	(or (hair-color-on-crime ?color)
	    (test (= ?color dyed))
	)
	=>
	(printout t ?name " have colorMatching." crlf)
)

;;;======================================================
;;; RULES ODORS
;;;======================================================

(defrule odorDeduction
	(declare (salience 39) )
	(likeToEat ?name ?meal)
	(lieu-smell-like ?meal)
	=>
	(printout t ?name " peut etre un victime." crlf)
	(assert(is-potential-killer-from-odor ?name))
)

;;;======================================================
;;; Rule lien avec victime
;;;======================================================



;;;======================================================
;;; Règles de déduction
;;;======================================================

(defrule voici-le-tueur
	(declare (salience 0))
	(as-weapon ?name ?weapon)
	(weapon-crime ?weapon)
	(was-there ?name)
	(is-potential-killer-from-odor ?name)
	(is-potential-killer-from-weapon ?name)
	
	(started)
	=>
	(assert (is-killer ?name))
	(printout t "Le tueur est " ?name crlf)
	(halt)
)

(reset)
(run)
