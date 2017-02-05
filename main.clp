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

(defrule corpse-body-temperature
	(declare (salience 0))
	(corpse-body-temperature-is-at-phase ?phase)
	=>
	(if (eq ?phase 1) then
		(bind ?tmin 1)
		(bind ?tmax 1)
	else (if (eq ?phase 2) then
		(bind ?tmin 2)
		(bind ?tmax 4)
	else (if (eq ?phase 3) then
		(bind ?tmin 5)
		(bind ?tmax 7)
	else
		(bind ?tmin 8)
		(bind ?tmax 10)
	)))
	(assert (body-temperature-is-at-phase ?phase ?tmin to ?tmax))
	(printout t "The body temperature is at phase " ?phase crlf)
	(printout t "From the body temperature, we know he died between " ?tmin " and " ?tmax crlf)
)

(defrule corpse-body-coagulation
	(declare (salience 0))
	(corpse-coagulation-is-at-phase ?phase)
	=>
	(if (eq ?phase 1) then
		(bind ?tmin 1)
		(bind ?tmax 2)
	else (if (eq ?phase 2) then
		(bind ?tmin 3)
		(bind ?tmax 5)
	else (if (eq ?phase 3) then
		(bind ?tmin 6)
		(bind ?tmax 8)
	else
		(bind ?tmin 9)
		(bind ?tmax 11)
	)))
	(assert (coagulation-is-at-phase ?phase ?tmin to ?tmax))
	(printout t "The body coagulation is at phase " ?phase crlf)
	(printout t "From the body coagulation, we know he died between " ?tmin " and " ?tmax crlf)
)

(defrule corpse-body-skin-detoriation
	(declare (salience 0))
	(corpse-skin-detoriation-is-at-phase ?phase)
	=>
	(if (eq ?phase 1) then
		(bind ?tmin 1)
		(bind ?tmax 3)
	else (if (eq ?phase 2) then
		(bind ?tmin 4)
		(bind ?tmax 6)
	else
		(bind ?tmin 7)
		(bind ?tmax 9)
	))
	(assert (skin-detoriation-is-at-phase ?phase ?tmin to ?tmax))
	(printout t "The body skin detoriation is at phase " ?phase crlf)
	(printout t "From the skin detoriation, we know he died between " ?tmin " and " ?tmax crlf)
)

(defrule time-of-crime
	(declare (salience 0))
	(skin-detoriation-is-at-phase ?skin-phase ?min-skin to ?max-skin)
	(coagulation-is-at-phase ?coag-phase ?min-coag to ?max-coag)
	(body-temperature-is-at-phase ?temp-phase ?min-temp to ?max-temp)
	=>
	(bind ?tmin (min ?max-skin (min ?max-coag ?max-temp)))
	(assert (time-past-since-crime ?tmin))
	(printout t "The crime was committed " ?tmin " hours ago" crlf)
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

(defrule wound-type-deduction
	(declare (salience 0) )
	(victim-wound ?wound)
	(wound-type ?wound)
	=>
	(printout t "Wound of victim is " ?wound " types" crlf)
	(assert(wound-of-crime-type ?wound))
)

(defrule weapon-type-deduction
	(declare (salience 0) )
	(wound-of-crime-type ?wound)
	(weapon-type ?weaponType ?wound)
	=>
	(printout t "the weapon of crime can be of " ?weaponType " types" crlf)
	(assert(weapon-of-crime-type ?weaponType))
)

(defrule weapon-deduction
	(declare (salience 0) )
	(weapon-of-crime-type ?weaponType)
	(weapon ?weapon ?weaponType)
	=>
	(printout t "the weapon of crime can be " ?weapon " types" crlf)
	(assert(can-be-weapon ?weapon))
)


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

(defrule hairMatchingAgeSuspect
	(declare (salience 0) )
	
	(hair-youth-groupAge-on-crime ?ageGroup)
	(hairYouth ?name ?ageGroup)
	
	=>
	(if (eq ?ageGroup 1020) then
		(bind ?tgroupAge between1030)
		(printout t "The suspect " ?name " hair youth matches the hair found on crime : between1030" crlf)
	else (if (eq ?ageGroup 2030) then
		(bind ?tgroupAge between2030)
		(printout t "The suspect " ?name " hair youth matches the hair found on crime : between2030" crlf)
	else (if (eq ?ageGroup 3040) then
		(bind ?tgroupAge between3040)
		(printout t "The suspect " ?name " hair youth matches the hair found on crime : between3040" crlf)
	else
		(bind ?tgroupAge unknown)
		(printout t "The suspect " ?name " hair youth is unknown" crlf)
	)))
	
	(assert(is-potential-killer-from-hair-youth-groupAge ?name ?tgroupAge))

)


	
;;;======================================================
;;; RULES ODORS
;;;======================================================

(defrule odor-deduction
	(declare (salience 0))
	(like-to-eat ?name ?lunch)
	(lunch-smell ?lunch ?smell)
	(lieu-smell-like ?smell)
	=>
	(printout t ?name " is a potential killer from odor" crlf)
	(assert(is-potential-killer-from-odor ?name))
)


(defrule finterprints-found-on-object-matches-suspect-fingerprints
	(declare (salience 0))
	(lieu-found-item-fingerprints ?fingerprintsType)
	(has-fingerprint ?name ?fingerprintsType)
	=>
	(printout t ?name " has matching fingerprints found on the object on the scene" crlf)
	(assert(fingerprints-found-on-object-matches-suspect-fingerprints ?name))
)


(defrule itemfound-fingerprints-and-odor-matching
	(declare (salience 0))
	(is-potential-killer-from-odor ?name)
	(fingerprints-found-on-object-matches-suspect-fingerprints ?name)
	=>
	(printout t ?name " likes to eat the item found on the scene and the odor matches the object found." crlf)
	(assert(is-potential-killer-from-fingerprints-odor-found-on-crime ?name))
)

;;;======================================================
;;; RULES RECEIPT
;;;======================================================

;; Dye
(defrule money-spent-on-hair-dye
	(declare (salience 0))
	(hair-color-is-dyed ?name ?dyed)
	(hair-color-of ?name ?color)
	(dye-price-is ?color ?price)
	=>
	(printout t ?name " has dyed hair at the price of " ?price "$" crlf)
	(assert(has-spent-on-dye ?name ?price))
)

(defrule money-not-spent-on-hair-dye
	(declare (salience 0))
	(suspect ?name)
	(not (hair-color-is-dyed ?name))
	=>
	(printout t ?name " did not pay for dye" crlf)
	(assert(has-spent-on-dye ?name 0))
)

;; Gas
(defrule money-spent-on-gas
	(declare (salience 0))
	(gas-used ?name ?vehicule ?gas)
	(gas-price ?price)
	=>
	(bind ?money (* ?gas ?price))
	(printout t ?name " needed " ?money "$ of gas with his " ?vehicule crlf)
	(assert(has-spent-on-gas ?name ?money))
)

(defrule money-not-spent-on-gas
	(declare (salience 0))
	(suspect ?name)
	(not (gas-used ?name ?vehicule ?gas))
	=>
	(printout t ?name " did not spend money on gas" crlf)
	(assert(has-spent-on-gas ?name 0))
)

;; Arme
(defrule money-spent-on-arme
	(declare (salience 0))
	(weapon-price ?weapon ?price)
	(can-be-weapon ?weapon)
	=>
	(assert(has-spent-on-weapon ?price))
	(printout t "the killer need " ?price " to buy the " ?weapon crlf)
)

;; Odor
(defrule lunch-possibility
	(declare (salience 0))
	(lieu-smell-like ?smell)
	(lunch-smell ?lunch ?smell)
	=>
	(printout t "can be lunch " ?lunch crlf)
	(assert(can-be-lunch ?lunch))
)

(defrule money-spent-on-lunch
	(declare (salience 0))
	(can-be-lunch ?lunch)
	(lunch ?lunch ?price)
	=>
	(assert(has-spent-on-lunch ?price))
	(printout t "the killer need " ?price " to buy the " ?lunch crlf)
)

;; Total
(defrule receipt-matching
	(declare (salience 45))
	(suspect ?name)
	(receipt-on-crime ?amount)
	(has-spent-on-dye ?name ?dye)
	(has-spent-on-gas ?name ?gas)
	(has-spent-on-lunch ?name ?lunch)
	(has-spent-on-weapon ?weapon)
	(test (>= ?amount (+ ?gas (+ ?dye (+ ?lunch ?weapon)))))
	=>
	(printout t ?name " is a potential killer because of the receipt" crlf)
	(assert(is-potential-killer-from-receipt-on-crime ?name))
)

;;;======================================================
;;; Deduction rules
;;;======================================================

(defrule the-killer-is
	(declare (salience 50))
	(is-potential-killer-from-odor ?name)									;;bob rentre
	;;(is-potential-killer-from-weapon ?name)
	(is-potential-killer-from-hair-color ?name)								;;bob rentre
	(is-potential-killer-from-hair-lenght ?name)							;;bob rentre
	(is-potential-killer-from-fingerprints-odor-found-on-crime ?name)		;;bob rentre
	;;(is-potential-killer-from-receipt-on-crime ?name)
	;;(was-there ?name)
	
	;;(is-potential-killer-from-hair-youth-groupAge ?name ?groupAge)
	;;(penitenceOfSuspect ?name ?penalty ?country)

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
