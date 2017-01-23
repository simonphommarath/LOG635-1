;
; Fichier d'exemple pour l'initiation au langage JESS.
; Démontre la base de l'utilisation des faits et des règles.
;
 
; Suppression des faits
(clear)

;;;======================================================
;;; FAITS DE BASES
;;;======================================================
(deffacts fact
	(as-weapon karl knife)
	(as-weapon bob knife)
	(as-weapon sam hammer)
	(as-weapon nicolas shovel)
)

;;;======================================================
;;; FAITS ARMES DE CRIMES
;;;======================================================

(deffacts fact-crime
	(weapon-crime knife)
)


;;;======================================================
;;; Faits Lieux-temps - nick
;;;======================================================



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

;;;======================================================
;; FAITS ODEURS - yannick
;;;======================================================
(deffacts fact
	(lieu-smell-like fishes)
)

;;;======================================================
;;; CHARACTERS - yannick
;;;======================================================
(deffacts fact
	(likeToEat karl nutelas)
	(hair-lenght-of karl long)
	(hair-color-of karl blond)

	(likeToEat sam fishes)
	(hair-lenght-of sam long)
	(hair-color-of same dyed)

	(likeToEat bob nutelas)
	(likeToEat bob fishes)
	(hair-lenght-of bob short)
	(hair-color-of bob blond)
	
	(likeToEat roger fishes)
)





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
;;; Rule arms-blessur
;;;======================================================



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
	(is-potential-killer-from-odor ?name)
	
	
	(started)
	=>
	(assert (is-killer ?name))
	(printout t "Le tueur est " ?name crlf)
	(halt)
)

(reset)
(run)