;;;======================================================
;;; LOG-635 Laboratoire 1
;;; Author:
;;; 	Simon Phommarath
;;; 	Nicolas Arsenault
;;; 	Yannick Maringo
;;; 
;;;======================================================


;;;======================================================
;;; TO DO
;;;======================================================

; verification de 1 ou plus de criminel a la fin, 
;	si plus que 2, sa foire

; trouver l'age de la personne par le cheveux de la scene de crime
;	il ne doit pas etre un fact setter du depart

; finir la facture
; fixer la was-there

; Setter les tout les gens suspect au debut
;	ensuite les rendre innocent a fur et a mesure que les RULES sont executer
;	Sa fait que on trouve des fait par elimination (qui vaut des points)
;	Par contre, sa reduit tu les inferences en faisant sa?

; -Current situation, 22 rules, 51 inference, 5? complexe

;;;======================================================
;;; Rule Lieux-temps
;;;======================================================

(deffacts body-temperature-on-crime-scene
	(body-temperature-is-at-phase 1 0 to 1)
	(body-temperature-is-at-phase 2 2 to 4)
	(body-temperature-is-at-phase 3 5 to 7)
	(body-temperature-is-at-phase 4 7 to 10)
)

(deffacts coagulation-on-crime-scene
	(coagulation-is-at phase-1 0 to 2)
	(coagulation-is-at phase-2 3 to 5)
	(coagulation-is-at phase-3 6 to 8)
	(coagulation-is-at phase-4 9 to 11)
)

(deffacts skin-detoriation-on-crime-scene
	(skin-detoriation-is-at-phase 1 0 to 3)
	(skin-detoriation-is-at-phase 2 4 to 6)
	(skin-detoriation-is-at-phase 3 7 to 9)
)

(defrule time-past-since-crime
	(declare (salience 0))
	(body-temperature-is ?body-temperature)
	(dead-body-temperature-is-at ?body-temperature degree-when-dead ?past-time hours-ago)
	=>
	(assert (time-past-since-crime ?past-time))
	(printout t "The crime was committed " ?past-time " hours ago" crlf)
)

(defrule corpse-time-location
	(declare (salience 0))
	(time-past-since-crime ?past-time)
	(current-time-is ?current-time)
	(crime-location ?location)
	=>
	(printout t "The current time is " ?current-time " hours " crlf)
	(bind ?death-time (- ?current-time ?past-time))
	(assert (crime-was-at ?location at-t ?death-time))
	(printout t "The crime was at the " ?location " at " ?death-time " hours" crlf)
)

(defrule was-there
	(declare (salience 0))
	(crime-was-at ?location at-t ?tcrime)
	(was-at ?name ?location from-t ?tstart to-t ?tend)
	(test (>= ?tcrime ?tstart))
	(test (<= ?tcrime ?tend))
	=>
	(printout t ?name " was on the crime scene on time of death" crlf)
	(assert (was-there ?name))
)

(defrule adjusted-time
	(declare (salience 20))
	(crime-was-at ?locationCrime at-t ?tcrime)
	(was-at ?name ?location from-t ?tstart to-t ?tend)
	(distance-between ?locationCrime ?location is-t ?distance)
	(travel-by ?name ?car)
	(travel-at ?car ?speed gas ?litter)
	=>
	;(printout t ?name " was on the crime scene on time of death" crlf)
	(bind ?ttravel (/ ?distance ?speed)) 
	(assert (was-at-adjusted ?name ?location from-t (+ ?tstart ?ttravel) to-t (+ ?tend ?ttravel)))
	(printout t ?name " use this much gas: " (* ?ttravel ?litter) crlf)
	(assert (gas-used ?name ?car (* ?ttravel ?litter)))
)

(defrule was-there-adjusted
	(declare (salience 30))
	(crime-was-at ?locationCrime at-t ?tcrime)
	(was-at-adjusted ?name ?location from-t ?tstart to-t ?tend)
	(or	(test (<= ?tcrime ?tstart))
		(test (>= ?tcrime ?tend)))
	=>
	(printout t ?name " could be on the crime scene on time of death" crlf)
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
; To be removed maybe
(defrule job-has-weapon
	(declare (salience 0) )
	(can-be-weapon ?weapon)
	(job ?weapon ?job)
	=>
	(printout t "The suspect can be " ?name" based on weapon possibility" crlf)
	(assert(is-potential-killer-from-weapon ?name))
)
*/

;;;======================================================
;;; RULES EMPRUNTS
;;;======================================================

(defrule hairColorMatch
	(declare (salience 0) )
	(hair-color-of ?name ?color)
	(or (hair-color-on-crime ?color)
	    (hair-color-is-dyed ?name)
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
	
;;;======================================================
;;; RULES ODORS
;;;======================================================
/*
(defrule odorDeduction
	(declare (salience 0) )
	(like-to-eat ?name ?meal)
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
*/
;;;======================================================
;;; RULES RECEIPT
;;;======================================================

(defrule moneySpentOnHairDye
	(declare (salience 0))
	(hair-color-is-dyed ?name ?is-dyed)
	(hair-color-of ?name ?hair-color)
	(dye-price-is ?hair-color ?dye-price)
	(test (eq ?is-dyed TRUE))
	=>
	(printout t ?name " has dyed hair at the price of " ?dye-price "$" crlf)
	(assert(has-spent-on-dye ?name ?dye-price))
)

(defrule moneyNotSpentOnHairDye
	(declare (salience 0))
	(suspect ?name)
	(not (hair-color-is-dyed ?name))
	=>
	(printout t ?name " did not pay for dye" crlf)
	(assert(has-spent-on-dye ?name 0))
)

(defrule moneySpentOngas
	(declare (salience 0))
	(gas-used ?name ?car ?gas)
	(gas-price ?price)
	=>
	(bind ?money (* ?gas ?price))
	(printout t ?name " needed " ?money "$ of gas" crlf)
	(assert(has-spent-on-gas ?name ?money))
)

(defrule moneyNotSpentOnGas
	(declare (salience 0))
	(suspect ?name)
	(not (gas-used ?name ?car ?gas))
	=>
	(printout t ?name " did not spend money on gas " crlf)
	(assert(has-spent-on-gas ?name 0))
)

(defrule receipt-matching
	(declare (salience 45))
	(suspect ?name)
	(receipt-on-crime ?amount)
	(has-spent-on-dye ?name ?dye)
	(has-spent-on-gas ?name ?gas)
	(test (>= ?amount (+ ?gas ?dye)))
	=>
	(printout t ?name " is a potential killer because of the receipt." crlf)
	(assert(is-potential-killer-from-receipt-on-crime ?name))
)

;;;======================================================
;;; Deduction rules
;;;======================================================

(defrule the-killer-is
	(declare (salience 50))
	;(is-potential-killer-from-odor ?name)
	;(is-potential-killer-from-weapon ?name)
	;(is-potential-killer-from-hair-color ?name)
	;(is-potential-killer-from-hair-lenght ?name)
	;(is-potential-killer-from-fingerprints-odor-found-on-crime ?name)
	(is-potential-killer-from-receipt-on-crime ?name)
	(was-there ?name)
	
	;(penitenceOfSuspect ?name ?penalty ?country)

	(started)
	=>
	(assert (is-killer ?name))
	(printout t "The killer is " ?name " because he fits matches with all the evidence" crlf)
	;(printout t "The killer " ?name " will get the sentence of : " ?penalty " in the country of : " ?country crlf)
	;(halt) J'ai mis sa en commentaire pour voir le VRAI resultat finale (plus que 1 criminel possible actuellement) - Simon
)

(rules)
(reset)
(run)