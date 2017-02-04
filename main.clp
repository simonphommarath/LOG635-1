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

; crime-was-at est trouver par (la coagulation du sang) avec (l'heure de l'investigation)
;	il ne doit pas etre un fact setter du depart

; trouver l'age de la personne par le cheveux de la scene de crime
;	il ne doit pas etre un fact setter du depart

; finir la facture
; fixer la was-there

; Setter les tout les gens suspect au debut
;	ensuite les rendre innocent a fur et a mesure que les RULES sont executer
;	Sa fait que on trouve des fait par elimination (qui vaut des points)
;	Par contre, sa reduit tu les inferences en faisant sa?

; -Current situation, 20 rules, 49 inference, ? complexe

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


; To be removed maybe
(defrule job-has-weapon
	(declare (salience 0) )
	(can-be-weapon ?weapon)
	(job ?weapon ?job)
	=>
	(printout t "The suspect can be " ?name" based on weapon possibility" crlf)
	(assert(is-potential-killer-from-weapon ?name))
)

/*
; To be removed maybe
(defrule weaponSuspect
	(declare (salience 0) )
	(can-be-weapon ?weapon)
	(has-weapon ?name ?weapon)
	=>
	(printout t "The suspect can be " ?name" based on weapon possibility" crlf)
	(assert(is-potential-killer-from-weapon ?name))
)
*/

;;;======================================================
;;; RULES EMPRUNTS
;;;======================================================
/*
(defrule hairColorMatch
	(declare (salience 0) )
	(hair-color-of ?name ?color)
	(hair-color-is-dyed ?name ?is-dyed)
	(or (hair-color-on-crime ?color)
	    (test (= ?is-dyed TRUE))
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
*/
	
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
	(hair-color-is-dyed ?name ?is-dyed)
	(test (eq ?is-dyed FALSE))
	=>
	(printout t ?name " did not pay for dye" crlf)
	(assert(has-spent-on-dye ?name 0))
)

(defrule money-spent-on-gaz
	(declare (salience 0))
	(gas-used ?name ?car ?gaz)
	(gas-price ?price)
	;(test (> ?gaz-liter-consumed 0))
	=>
	(bind ?money (* ?gaz ?price))
	(printout t ?name " needed " ?money "$ of gaz" crlf)
	(assert(has-spent-on-gaz ?name ?money))
)

	

(defrule moneyNotSpentOnGaz
	(declare (salience 0))
	(suspect ?name)
	(not (gas-used ?name ?car ?gaz))
	=>
	(printout t ?name " did not spend money on gaz " crlf)
	(assert(has-spent-on-gaz ?name 0))
)



(defrule receipt-matching
	(declare (salience 0))
	(suspect ?name)
	(receipt-on-crime ?amount)
	(has-spent-on-gaz ?name ?gas)
	(test (>= ?amount ?gas))
	=>
	(printout t ?name " is a potential killer because of the receipt." crlf)
	(assert(is-potential-killer-from-receipt-on-crime ?name))
)

/*
; Nic, tu connais la logique, plz do it
; Le frame est toute faite, faut juste le (test 
(defrule receiptMatching
	(declare (salience 0))
	(receipt-on-crime ?amount)
	(has-spent-on-dye ?name ?dye-price)
	(has-spent-on-gaz ?name ?gaz-cost)
	(test (> ?amount ?dye-price ))
	=>
	(printout t ?name " is a potential killer because of the receipt." crlf)
	(assert(is-potential-killer-from-receipt-on-crime ?name))
)
*/

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

;(rules)
(reset)
(run)
