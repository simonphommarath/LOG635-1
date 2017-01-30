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
	(scene-has bullet-casing)
	(scene-has bullet-shell)
	(scene-has empty-vial)
	(scene-has blood-splat)
)
*/

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