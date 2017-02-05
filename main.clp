;;;======================================================
;;; LOG-635 Laboratoire 1
;;; Author:
;;; 	Simon Phommarath
;;; 	Nicolas Arsenault
;;; 	Yannick Maringo
;;; 
;;;======================================================


;;;======================================================
;;; Temperature
;;;======================================================
;; On ajust selon le type d'arme
(defrule real-victim-temperature
	(declare (salience 9))
	(victim-temperature-is-at-phase ?phase)
	(victim-wound ?wound)
	(temperature-phase-modification ?wound ?phaseModif)
	=>
	(bind ?new-phase (+ ?phase ?phaseModif))
	(assert (actual-victim-temperature-is-at-phase ?new-phase))
	(printout t "The real body temperature phase is " ?new-phase " because of the wound type" crlf)
)

;; Si on a pas de modification lier au type d'arme
(defrule victim-actual-temperature
  (declare (salience -1))
	(victim-temperature-is-at-phase ?phase)
	(victim-wound ?wound)
	(not (temperature-phase-modification ?wound ?phaseModif))
	=>
	(assert (actual-victim-temperature-is-at-phase ?phase))
	(printout t "The weapon did not change the body temperature" crlf)
)

;; On calcule le temps de la mort
(defrule victim-temperature
	(declare (salience 8))
	(actual-victim-temperature-is-at-phase ?phase)
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
	(printout t "The body temperature is at phase " ?phase ", thus we know he died between " ?tmin " and " ?tmax crlf)
)

;;;======================================================
;;; Coagulation
;;;======================================================
; On ajust la phase selon le type d'arme
(defrule victim-coagulation
	(declare (salience 9))
	(victim-coagulation-is-at-phase ?phase)
	(victim-wound ?wound)
	(coagulation-phase-modification ?wound ?phaseModif)
	=>
	(bind ?new-phase (+ ?phase ?phaseModif))
	(printout t "The real body coagulation phase is " ?new-phase " because of the wound type" crlf)
)

; Si on a pas de modification lie
(defrule victim-actual-coagulation
  (declare (salience -1))
	(victim-coagulation-is-at-phase ?phase)
	(victim-wound ?wound)
	(not (coagulation-affected-by-weapon-type ?wound ?phaseModif))
	=>
	(assert (actual-victim-coagulation-is-at-phase ?phase))
	(printout t "The weapon did not change the body coagulation" crlf)
)

; On calcule l'age
(defrule victim-coagulation
	(declare (salience 9))
	(actual-victim-coagulation-is-at-phase ?phase)
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
	(printout t "The body coagulation is at phase " ?phase ", thus we know he died between " ?tmin " and " ?tmax crlf)
)

;;;======================================================
;;; Temperature
;;;======================================================
(defrule victim-skin-detoriation
	(declare (salience 9))
	(victim-skin-detoriation-is-at-phase ?phase)
	(victim-wound ?wound)
	(skin-detoriation-phase-modification ?wound ?phaseModif)
	=>
	(bind ?new-phase (+ ?phase ?phaseModif))
	(assert (actual-victim-skin-detoriation-is-at-phase ?new-phase))
	(printout t "The real body skin detoriation phase is " ?new-phase " because of the wound type" crlf)
)

(defrule victim-actual-skin-detoriation
  (declare (salience -1))
	(victim-skin-detoriation-is-at-phase ?phase)
	(victim-wound ?wound)
	(not (skin-detoriation-affected-by-weapon-type ?wound ?phaseModif))
	=>
	(assert (actual-victim-skin-detoriation-is-at-phase ?phase))
	(printout t "The weapon did not change the body's skin detoriation" crlf)
)

(defrule victim-skin-detoriation
	(declare (salience 10))
	(actual-victim-skin-detoriation-is-at-phase ?phase)
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
	(printout t "The body' skin detoriation is at phase " ?phase ", thus we know he died between " ?tmin " and " ?tmax crlf)
)


;;;======================================================
;;; Time of the crime
;;;======================================================
(defrule time-of-crime
	(declare (salience 11))
	(skin-detoriation-is-at-phase ?skin-phase ?min-skin to ?max-skin)
	(coagulation-is-at-phase ?coag-phase ?min-coag to ?max-coag)
	(body-temperature-is-at-phase ?temp-phase ?min-temp to ?max-temp)
	=>
	(bind ?tmin (min ?max-skin (min ?max-coag ?max-temp)))
	(assert (time-past-since-crime ?tmin))
	(printout t "From the body examination, we know the crime was committed " ?tmin " hours ago" crlf)
)

(defrule victim-time-location
	(declare (salience 15))
	(time-past-since-crime ?past-time)
	(current-time-is ?current-time)
	(crime-location ?location)
	=>
	(printout t "The body was analysed at " ?current-time " hours " crlf)
	(bind ?death-time (- ?current-time ?past-time))
	(assert (crime-was-at ?location at-t ?death-time))
	(printout t "Thus, the crime was at the " ?location " at " ?death-time " hours" crlf)
)

;;;======================================================
;;; Time and location of suspect
;;;======================================================

;Complexe
(defrule is-potential-killer-from-location-on-crime
	(declare (salience 13))
	(crime-was-at ?location at-t ?tcrime)
	(was-at ?name ?location from-t ?tstart to-t ?tend)
	(test (>= ?tcrime ?tstart))
	(test (<= ?tcrime ?tend))
	=>
	(printout t ?name " was on the crime location on time of death" crlf)
	(assert (is-potential-killer-from-location-on-crime ?name))
	(assert (gas-used ?name none 0))
	(assert (gas-calculated ?name))
)

;Complexe
(defrule adjusted-time
	(declare (salience 14))
	(crime-was-at ?locationCrime at-t ?tcrime)
	(was-at ?name ?location from-t ?tstart to-t ?tend)
	(distance-between ?locationCrime ?location is-t ?distance)
	(travel ?name  by ?car)
	(travel-by ?car ?speed gas ?litter)
	=>
	(bind ?ttravel (/ ?distance ?speed)) 
	(assert (was-at-adjusted ?name ?location from-t (+ ?tstart ?ttravel) to-t (+ ?tend ?ttravel)))
	(printout t ?name " use this much gas: " (* ?ttravel ?litter) crlf)
	(assert (gas-used ?name ?car (* ?ttravel ?litter)))
	(assert (gas-calculated ?name))
)

;Complexe
(defrule is-potential-killer-from-location-on-crime-adjusted
	(declare (salience 15))
	(crime-was-at ?locationCrime at-t ?tcrime)
	(was-at-adjusted ?name ?location from-t ?tstart to-t ?tend)
	(or	(test (<= ?tcrime ?tstart))
		(test (>= ?tcrime ?tend)))
	=>
	(printout t ?name " could be on the crime scene on time of death" crlf)
	(assert (is-potential-killer-from-location-on-crime ?name))
)

;;;======================================================
;;; RULES VICTIM-WOUND
;;;======================================================

(defrule wound-type-deduction
	(declare (salience 18) )
	(victim-wound ?wound)
	(wound-type ?wound)
	=>
	(printout t "The wound on the victim is of " ?wound " types" crlf)
	(assert(wound-of-crime-type ?wound))
)

(defrule weapon-type-deduction
	(declare (salience 0) )
	(wound-of-crime-type ?wound)
	(weapon-type ?weaponType ?wound)
	=>
	(printout t "The weapon of crime is in the categorie of " ?weaponType " weapon" crlf)
	(assert(weapon-of-crime-type ?weaponType))
)

(defrule weapon-deduction
	(declare (salience 20) )
	(weapon-of-crime-type ?weaponType)
	(weapon ?weapon ?weaponType)
	=>
	(printout t "The weapon of crime can be: " ?weapon crlf)
	(assert(can-be-weapon ?weapon))
)

;;;======================================================
;;; RULES HAIR
;;;======================================================

;Complexe
(defrule hair-color-match
	(declare (salience 25) )
	(hair-color-of ?name ?color)
	(or (hair-color-on-crime ?color)
	  (hair-color-is-dyed ?name)
	)
	=>
	(printout t ?name " is a potential killer from matching hair color" crlf)
	(assert(is-potential-killer-from-hair-color ?name))
)

;Complexe
(defrule hair-lenght-match
	(declare (salience 25) )
	(wound-of-crime-type ?wound-type)
	(hair-lenght-on-crime ?lenght)
	(or	(hair-lenght-of ?name ?lenght)
	  (and (hair-lenght-of ?name short)
		(test (= ?wound-type laceration))
		)
	)
	=>
	(printout t ?name " is a potential killer from matching hair lenght" crlf)
	(assert(is-potential-killer-from-hair-lenght ?name))
)

;Complexe
(defrule hair-matching-age-suspect
	(declare (salience 0) )
	(hair-age-on-crime ?minAge to ?maxAge)
	(has-age-of ?name ?age)
	(test (>= ?age ?minAge))
	(test (<= ?age ?maxAge))
	=>
	(printout t ?name " has the right age" crlf)
	(assert(is-potential-killer-from-hair-age ?name))
)

(defrule is-potential-killer-from-hair
  (is-potential-killer-from-hair-age ?name)
	(is-potential-killer-from-hair-lenght ?name)
	(is-potential-killer-from-hair-color ?name)
	=>
	(printout t ?name " has hair that fits the one on the crime sceen" crlf)
	(assert(is-potential-killer-from-hair ?name))
)
	
;;;======================================================
;;; RULES ODORS
;;;======================================================


(defrule odor-deduction
	(declare (salience 0))
	(like-to-eat ?name ?lunch)
	(lunch-smell ?lunch ?smell)
	(place-smell-like ?smell)
	=>
	(printout t ?name " is a potential killer from odor on the crime scene" crlf)
	(assert(is-potential-killer-from-odor ?name))
)

;;;======================================================
;;; RULES FOOTPRINT
;;;======================================================

(defrule footprint-match-patern-on-crime
	(declare (salience 30) )
	(footprint-on-crime  ?footprint)
	(has-footprint ?name ?footprint)
	=>
	(printout t ?name " has the same footprints found on the object on the scene" crlf)
	(assert(is-potential-killer-from-footprints ?name))
)

;;;======================================================
;;; RULES RECEIPT
;;;======================================================

;; Dye
(defrule money-spent-on-hair-dye
  (declare (salience 80))
	(hair-color-is-dyed ?name)
	(hair-color-of ?name ?color)
	(dye-price-is ?color ?price)
	=>
	(printout t ?name " has dyed hair at the price of " ?price "$" crlf)
	(assert(has-spent-on-dye ?name ?price))
)

(defrule money-not-spent-on-hair-dye
  (declare (salience 80))
	(suspect ?name)
	(not (hair-color-is-dyed ?name))
	=>
	(printout t ?name " did not pay for dye" crlf)
	(assert(has-spent-on-dye ?name 0))
)

;; Gas
(defrule money-spent-on-gas
  (declare (salience 80))
	(gas-used ?name ?vehicule ?gas)
	(gas-price ?price)
	(gas-calculated ?name)
	=>
	(bind ?money (* ?gas ?price))
	(printout t ?name " needed " ?money "$ of gas with his " ?vehicule crlf)
	(assert(has-spent-on-gas ?name ?money))
)

(defrule money-not-spent-on-gas
  (declare (salience 80))
	(suspect ?name)
	(gas-calculated ?name)
	(not (gas-used ?name ?vehicule ?gas))
	=>
	(printout t ?name " did not spend money on gas" crlf)
	(assert(has-spent-on-gas ?name 0))
)

;; Arme
(defrule money-spent-on-arme
  (declare (salience 80))
	(weapon-price ?weapon ?price)
	(can-be-weapon ?weapon)
	=>
	(assert(has-spent-on-weapon ?price))
	(printout t "The killer need " ?price " to buy the " ?weapon crlf)
)

;; Odor
(defrule lunch-possibility
  (declare (salience 80))
	(place-smell-like ?smell)
	(lunch-smell ?lunch ?smell)
	=>
	(printout t "Can be lunch " ?lunch crlf)
	(assert(can-be-lunch ?lunch))
)

;; Lunch
(defrule money-spent-on-lunch
  (declare (salience 85))
	(can-be-lunch ?lunch)
	(like-to-eat ?name ?lunch)
	(lunch ?lunch ?price)
	=>
	(assert(has-spent-on-lunch ?name ?price))
	(printout t ?name " need " ?price " to buy the " ?lunch crlf)
)


;Complexe
;; Total
(defrule receipt-matching
  (declare (salience 90))
	(suspect ?name)
	(receipt-on-crime ?amount)
	(has-spent-on-dye ?name ?dye)
	(has-spent-on-gas ?name ?gas)
	(has-spent-on-lunch ?name ?lunch)
	(has-spent-on-weapon ?weapon)
	(test (>= ?amount (+ ?gas (+ ?dye (+ ?lunch ?weapon)))))
	=>
	(printout t ?name " is a potential killer because of the receipt : " (+ ?gas (+ ?dye (+ ?lunch ?weapon))) " being under " ?amount "$" crlf)
	(assert(is-potential-killer-from-receipt-on-crime ?name))
)


;;;======================================================
;;; Deduction rules
;;;======================================================


(defrule the-killer-is
	(declare (salience 100))
	(is-potential-killer-from-hair ?name)
	(is-potential-killer-from-odor ?name)
	(is-potential-killer-from-footprints ?name)
	(is-potential-killer-from-receipt-on-crime ?name)
	(is-potential-killer-from-location-on-crime ?name)
	=>
	(assert (is-killer ?name))
	(printout t "The killer is " ?name " because he fits all the evidence from the crime scene" crlf)
)

;(rules)
(reset)
(run)
