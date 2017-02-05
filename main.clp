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

; -Current situation, 22 rules, 51 inference, 5? complexe

; cheveux -> range age -> suspect
; odor -> food type -> food

;;;======================================================
;;; Rule Lieux-temps
;;;======================================================

(defrule real-corpse-body-temperature
	(declare (salience 9))
	(corpse-body-temperature-is-at-phase ?phase)
	(weapon-of-crime-type ?weaponType)
	(temperature-phase-modification ?weaponType ?phaseModif)
	=>
	(bind ?newPhase (+ ?phase ?phaseModif))
	(assert (actual-corpse-temperature-is-at-phase ?newPhase))
	(printout t "The actual body temperature is at phase " ?newPhase crlf)
)

(defrule corpse-body-actual-temperature
	(declare (salience 9))
	(corpse-body-temperature-is-at-phase ?phase)
	(weapon-of-crime-type ?weaponType)
	(not (temperature-phase-modification ?weaponType ?phaseModif))
	=>
	(assert (actual-corpse-temperature-is-at-phase ?phase))
	(printout t "The body temperature did not change because of the weapon" crlf)
)

(defrule corpse-body-temperature
	(declare (salience 8))
	(actual-corpse-temperature-is-at-phase ?phase)
	=>
	(if (<= ?phase 1) then
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
	(declare (salience 9))
	(corpse-coagulation-is-at-phase ?phase)
	(weapon-of-crime-type ?weaponType)
	(coagulation-phase-modification ?weaponType ?phaseModif)
	=>
	(bind ?newPhase (+ ?phase ?phaseModif))
	(assert (actual-corpse-coagulation-is-at-phase ?newPhase))
	(printout t "The actual body coagulation is at phase " ?newPhase crlf)
)

(defrule corpse-body-actual-coagulation
	(declare (salience 9))
	(corpse-coagulation-is-at-phase ?phase)
	(weapon-of-crime-type ?weaponType)
	(not (coagulation-affected-by-weapon-type ?weaponType ?phaseModif))
	=>
	(assert (actual-corpse-coagulation-is-at-phase ?phase))
	(printout t "The body coagulation did not change from the weapon" crlf)
)

(defrule corpse-body-coagulation
	(declare (salience 9))
	(actual-corpse-coagulation-is-at-phase ?phase)
	=>
	(if (<= ?phase 1) then
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
	(declare (salience 9))
	(corpse-skin-detoriation-is-at-phase ?phase)
	(weapon-of-crime-type ?weaponType)
	(skin-detoriation-phase-modification ?weaponType ?phaseModif)
	=>
	(bind ?newPhase (+ ?phase ?phaseModif))
	(assert (actual-corpse-skin-detoriation-is-at-phase ?newPhase))
	(printout t "The actual body skin-detoriation is at phase " ?newPhase crlf)
)

(defrule corpse-body-actual-skin-detoriation
	(declare (salience 9))
	(corpse-skin-detoriation-is-at-phase ?phase)
	(weapon-of-crime-type ?weaponType)
	(not (skin-detoriation-affected-by-weapon-type ?weaponType ?phaseModif))
	=>
	(assert (actual-corpse-skin-detoriation-is-at-phase ?phase))
	(printout t "The body skin detoriation did not change from the weapon" crlf)
)

(defrule corpse-body-skin-detoriation
	(declare (salience 10))
	(actual-corpse-skin-detoriation-is-at-phase ?phase)
	=>
	(if (<= ?phase 1) then
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
	(declare (salience 11))
	(skin-detoriation-is-at-phase ?skin-phase ?min-skin to ?max-skin)
	(coagulation-is-at-phase ?coag-phase ?min-coag to ?max-coag)
	(body-temperature-is-at-phase ?temp-phase ?min-temp to ?max-temp)
	=>
	(bind ?tmin (min ?max-skin (min ?max-coag ?max-temp)))
	(assert (time-past-since-crime ?tmin))
	(printout t "The crime was committed " ?tmin " hours ago" crlf)
)

(defrule corpse-time-location
	(declare (salience 15))
	(time-past-since-crime ?past-time)
	(current-time-is ?current-time)
	(crime-location ?location)
	=>
	(printout t "The current time is " ?current-time " hours " crlf)
	(bind ?death-time (- ?current-time ?past-time))
	(assert (crime-was-at ?location at-t ?death-time))
	(printout t "The crime was at the " ?location " at " ?death-time " hours" crlf)
)

;Complexe
(defrule was-there
	(declare (salience 13))
	(crime-was-at ?location at-t ?tcrime)
	(was-at ?name ?location from-t ?tstart to-t ?tend)
	(test (>= ?tcrime ?tstart))
	(test (<= ?tcrime ?tend))
	=>
	(printout t ?name " was on the crime scene on time of death" crlf)
	(assert (was-there ?name))
)

;Complexe
(defrule adjusted-time
	(declare (salience 14))
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

;Complexe
(defrule was-there-adjusted
	(declare (salience 15))
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
	(declare (salience 18) )
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
	(declare (salience 20) )
	(weapon-of-crime-type ?weaponType)
	(weapon ?weapon ?weaponType)
	=>
	(printout t "the weapon of crime can be the " ?weapon crlf)
	(assert(can-be-weapon ?weapon))
)

;;;======================================================
;;; RULES EMPRUNTS
;;;======================================================

;Complexe
(defrule hairColorMatch
	(declare (salience 25) )
	(hair-color-of ?name ?color)
	(or (hair-color-on-crime ?color)
	    (hair-color-is-dyed ?name)
	)
	=>
	(printout t ?name " is a potential killer from matching hair color." crlf)
	(assert(is-potential-killer-from-hair-color ?name))
)

;Complexe
(defrule hairLenghtMatch
	(declare (salience 25) )
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

(defrule hairMatchingAgeSuspect
	(declare (salience 0) )
	
	(theTest ?name)
	(suspect ?name)
	
	=>
	(printout t "The Ultimate Test for " ?name " worked if bob" crlf)
	(assert(is-fucking-bob ?name ))
)




	
;;;======================================================
;;; RULES ODORS
;;;======================================================

(defrule odorDeduction
	(declare (salience 30) )
	(like-to-eat ?name ?meal)
	(lieu-smell-like ?meal)
	=>
	(printout t ?name " is a potential killer from odor" crlf)
	(assert(is-potential-killer-from-odor ?name))
)

(defrule finterprints-found-on-object-matches-suspect-fingerprints
	(declare (salience 30) )
	(lieu-found-item-fingerprints ?fingerprintsType)
	(has-fingerprint ?name ?fingerprintsType)
	=>
	(printout t ?name " has matching fingerprints found on the object on the scene" crlf)
	(assert(fingerprints-found-on-object-matches-suspect-fingerprints ?name))
)

(defrule itemfound-fingerprints-and-odor-matching
	(declare (salience 30) )
	(and	(is-potential-killer-from-odor ?name)
			(fingerprints-found-on-object-matches-suspect-fingerprints ?name)
	)
	=>
	(printout t ?name " likes to eat the item found on the scene and the odor matches the object found." crlf)
	(assert(is-potential-killer-from-fingerprints-odor-found-on-crime ?name))
)

;;;======================================================
;;; RULES RECEIPT
;;;======================================================

;; Dye
(defrule money-spent-on-hair-dye
	(declare (salience 50))
	(hair-color-is-dyed ?name ?is-dyed)
	(hair-color-of ?name ?hair-color)
	(dye-price-is ?hair-color ?dye-price)
	(test (eq ?is-dyed TRUE))
	=>
	(printout t ?name " has dyed hair at the price of " ?dye-price "$" crlf)
	(assert(has-spent-on-dye ?name ?dye-price))
)

(defrule money-not-spent-on-hair-dye
	(declare (salience 50))
	(suspect ?name)
	(not (hair-color-is-dyed ?name))
	=>
	(printout t ?name " did not pay for dye" crlf)
	(assert(has-spent-on-dye ?name 0))
)

;; Gas
(defrule money-spent-on-gas
	(declare (salience 50))
	(gas-used ?name ?vehicule ?gas)
	(gas-price ?price)
	=>
	(bind ?money (* ?gas ?price))
	(printout t ?name " needed " ?money "$ of gas with his " ?vehicule crlf)
	(assert(has-spent-on-gas ?name ?money))
)

(defrule money-not-spent-on-gas
	(declare (salience 50))
	(suspect ?name)
	(not (gas-used ?name ?vehicule ?gas))
	=>
	(printout t ?name " did not spend money on gas" crlf)
	(assert(has-spent-on-gas ?name 0))
)

;; Arme
(defrule money-spent-on-arme
	(declare (salience 50))
	(weapon-price ?weapon ?price)
	(can-be-weapon ?weapon)
	=>
	(assert(has-spent-on-weapon ?weapon))
	(printout t "the killer need " ?price " to buy the " ?weapon crlf)
)

;Complexe
(defrule receipt-matching
	(declare (salience 60))
	(suspect ?name)
	(receipt-on-crime ?amount)
	(has-spent-on-dye ?name ?dye)
	(has-spent-on-gas ?name ?gas)
	(test (>= ?amount (+ ?gas ?dye)))
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
	(is-fucking-bob ?name)													;;Ultimate Test bob condition !
	
	;(penitenceOfSuspect ?name ?penalty ?country)

	=>
	(assert (is-killer ?name))
	(printout t "The killer is " ?name " because he fits matches with all the evidenceWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW" crlf)
	;(printout t "The killer " ?name " will get the sentence of : " ?penalty " in the country of : " ?country crlf)
	;(halt) J'ai mis sa en commentaire pour voir le VRAI resultat finale (plus que 1 criminel possible actuellement) - Simon
)

;(rules)
(reset)
(run)