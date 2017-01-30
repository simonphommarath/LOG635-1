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

;(defrule cheveuxLongBlond
;	(declare (salience 39) )
;	(personnage ?nom a longCheveuxBlond)
;	=>
;	(printout t ?nom " is tired." crlf)
;)
;
;(defrule cheveuxLongBrun
;	(declare (salience 39) )
;	(personnage ?nom a longCheveuxBrun)
;	=>
;	(printout t ?nom " is tired." crlf)
;)

;;;======================================================
;;; CHARACTERS
;;;======================================================





;;;======================================================
; Faits lien avec victime  -not now
;;;======================================================




;;;======================================================
; Règle de départ
;;;======================================================

(defrule startup
    =>
    (readline)
    (printout t "Start" crlf)
    (assert (started))
)


; Rule Lieux-temps

(defrule was-there
	(declare (salience 0))
	(crime-was-at ?location at-t ?tcrime)
	(was-at ?name ?location from-t ?tstart to-t ?tend)
	(test (>= ?tcrime ?tstart))
	(test (<= ?tcrime ?tend))
	=>
	(assert (was-there ?name))
)

; Rule arms-blessur

; Rule emprunt

; Rule lien avec victime



; Règles de déduction
(defrule voici-le-tueur
	(declare (salience 0))
	(as-weapon ?name ?weapon)
	(weapon-crime ?weapon)
	(was-there ?name)
	(started)
	=>
	(assert (is-killer ?name))
	(printout t "Le tueur est " ?name crlf)
	(halt)
)

(reset)
(run)
