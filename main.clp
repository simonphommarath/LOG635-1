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



;;;======================================================
; Faits arms-blessure - sim
;;;======================================================



;;;======================================================
;; FAITS EMPRUNTS - yannick
;;;======================================================

(defrule cheveuxLongBlond
	(declare (salience 39) )
	(personnage ?nom a longCheveuxBlond)
	=>
	(printout t ?nom " is tired." crlf)
)

(defrule cheveuxLongBrun
	(declare (salience 39) )
	(personnage ?nom a longCheveuxBrun)
	=>
	(printout t ?nom " is tired." crlf)
)

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

; Rule arms-blessur

; Rule emprunt

; Rule lien avec victime



; Règles de déduction
(defrule voici-le-tueur
	(declare (salience 0))
	(as-weapon ?name ?weapon)
	(weapon-crime ?weapon)
	(started)
	=>
	(assert (is-killer ?name))
	(printout t "Le tueur est " ?name crlf)
	(halt)
)

(reset)
(run)