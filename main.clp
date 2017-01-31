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
/*
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
*/
;;(defrule factureMatching
;;	(declare (salience 0) )
;;	(facture-on-crime ?amount)
;;	(test (< ?amountDiscovered-for ?name ?amount))
;;	=>
;;	(printout t ?name " is a potential killer for having legit facture." crlf)
;;	(assert(is-potential-killer-from-facture-on-crime ?name))
;;)
	

;;;======================================================
;;; RULES ODORS
;;;======================================================
/*
(defrule odorDeduction
	(declare (salience 0) )
	(likeToEat ?name ?meal)
	(lieu-smell-like ?meal)
	=>
	(printout t ?name " is a potential killer from odor" crlf)
	(assert(is-potential-killer-from-odor ?name))
)
*/

;;;======================================================
;;; Règles de déduction
;;;======================================================

(defrule voici-le-tueur
	(declare (salience 50))
	(is-potential-killer-from-odor ?name)
	(is-potential-killer-from-weapon ?name)
	(is-potential-killer-from-hair-color ?name)
	(was-there ?name)
	(is-potential-killer-from-hair-lenght ?name)
	(started)
	=>
	(assert (is-killer ?name))
	(printout t "The killer is " ?name crlf)
	(halt)
)

(reset)
(run)
