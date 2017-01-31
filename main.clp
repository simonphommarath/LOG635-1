;;;======================================================
;;; LOG-635 Laboratoire 1
;;; Author:
;;; 	Simon Phommarath
;;; 	Nicolas Arsenault
;;; 	Yannick Maringo
;;; 
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
	(declare (salience 20))
	(crime-was-at ?location at-t ?tcrime)
	(was-at ?name ?location from-t ?tstart to-t ?tend)
	(test (>= ?tcrime ?tstart))
	(test (<= ?tcrime ?tend))
	=>
	(printout t ?name " was on the crime scene on time of death" crlf)
	(assert (was-there ?name))
)

;;;======================================================
;;; RULES VICTIM-WOUND
;;;======================================================

(defrule woundTypeDeduction
	(declare (salience 0) )
	(victim-wound ?wound)
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

(defrule hairColorMatch
	(declare (salience 0) )
	(hair-color-of ?name ?color)
	(or (hair-color-on-crime ?color)
	    (test (= ?color dyed))
	)
	=>
	(printout t ?name " is a potential killer from matching hair color." crlf)
	(assert(is-potential-killer-from-hair-color ?name))
)

(defrule hairLenghtMatch
	(declare (salience 0) )
	(wound-of-crime-type ?wound-type)
	(hair-lenght-on-crime ?lenght)
	(or	(hair-lenght-of ?name ?lenght)
		(and (hair-lenght-of ?name short)
		(test (= ?wound-type laceration))
		)
	)
	=>
	(printout t ?name " is a potential killer from hair lenght matching." crlf)
	(assert(is-potential-killer-from-hair-lenght ?name))
)


;;(defrule factureMatching
;;	(declare (salience 0) )
;;	(facture-on-crime ?amount)
;;	(test (< ?amountDiscovered-for ?name ?amount))
;;	=>
;;	(printout t ?name " is a potential killer for having legit facture." crlf)
;;	(assert(is-potential-killer-from-facture-on-crime ?name))
;;)
	
	
;;;======================================================
;;; RULES PUNITENCE
;;;======================================================

(defrule isTreatAsAnAdultInTheCountry
	(declare (salience 0) )
	(has-age-of ?name ?ageOfSuspect)
	(country-of-crime ?country)
	(age-of-adult-of ?country ?ageOfAdultOfCountry)
	
	(test (> ?ageOfSuspect ?ageOfAdultOfCountry))	
	=>
	(printout t ?name " will be treat as an adult in the country of : " ?country crlf)
	(assert(will-be-treat-as-an-adult ?name ?country))
)

(defrule isTreatAsAMinorInTheCountry
	(declare (salience 0) )
	(has-age-of ?name ?ageOfSuspect)
	(country-of-crime ?country)
	(age-of-adult-of ?country ?ageOfAdultOfCountry)
	
	(test (< ?ageOfSuspect ?ageOfAdultOfCountry))
	=>
	(printout t ?name " will be treat as a minor in the country of : " ?country crlf)
	(assert(will-be-treat-as-a-minor ?name ?country))
)

(defrule PenitenceInTheCountryForTheKiller
	(declare (salience 0) )
	(will-be-treat-as-an-adult ?name ?country)
	(punitence-of-country ?country ?penalty)
	=>
	(printout t ?name " could get a sentence of : " ?penalty crlf)
	(assert(penitenceOfSuspect ?name ?penalty ?country))
)


;;;======================================================
;;; RULES ODORS
;;;======================================================

(defrule odorDeduction
	(declare (salience 0) )
	(likeToEat ?name ?meal)
	(lieu-smell-like ?meal)
	=>
	(printout t ?name " is a potential killer from odor" crlf)
	(assert(is-potential-killer-from-odor ?name))
)

(defrule finterprints-found-on-object-matches-suspect-fingerprints
	(declare (salience 0) )
	(lieu-found-item-fingerprints ?fingerprintsType)
	(has-fingerprint ?name ?fingerprintsType)
	=>
	(printout t ?name " has matching fingerprints found on the object on the scene" crlf)
	(assert(fingerprints-found-on-object-matches-suspect-fingerprints ?name))
)

(defrule itemfound-fingerprints-and-odor-matching
	(declare (salience 0) )
	(and	(is-potential-killer-from-odor ?name)
			(fingerprints-found-on-object-matches-suspect-fingerprints ?name)
	)
	=>
	(printout t ?name " likes to eat the item found on the scene and the odor matches the object found." crlf)
	(assert(is-potential-killer-from-fingerprints-odor-found-on-crime ?name))
)


;;;======================================================
;;; Règles de déduction
;;;======================================================

(defrule voici-le-tueur
	(declare (salience 50))
	(is-potential-killer-from-odor ?name)
	(is-potential-killer-from-weapon ?name)
	(is-potential-killer-from-hair-color ?name)
	(is-potential-killer-from-hair-lenght ?name)
	(is-potential-killer-from-fingerprints-odor-found-on-crime ?name)
	(penitenceOfSuspect ?name ?penalty ?country)
	;(was-there ?name)

	(started)
	=>
	(assert (is-killer ?name))
	(printout t "The killer is " ?name " and will get the sentence of : " ?penalty " in the country of : " ?country crlf)
	(halt)
)

(reset)
(run)