(deffacts init-threshold-value-main
    (mean-concave-points-threshold 0.05)
    (breast-cancer-positive 1.0)
    (breast-cancer-negative 0.0))
    
(deffacts init-threshold-value-left
    (worst-radius-threshold 16.83)
    (radius-error-threshold 0.63)
    (mean-texture-1-threshold 16.19)
    (worst-texture-threshold 30.15)
    (mean-smoothness-threshold 0.09)
    (concave-points-error-threshold 0.01)
    (worst-area-threshold 641.60)
    (mean-radius-threshold 13.45)
    (mean-texture-2-threshold 28.79))

(deffacts init-threshold-value-right
    (worst-perimeter-threshold 114.45)
    (worst-texture-2-threshold 25.65)
    (worst-concave-points-threshold 0.17)
    (perimeter-error-threshold 1.56)
    (mean-radius-2-threshold 13.34))

(defrule breast-cancer-verdict-positive
    (declare (salience 100))
    (breast-cancer-positive ?positive)
    (breast-cancer-verdict ?value&:(= ?value ?positive))
=>
    (printout t "Hasil Prediksi = Terprediksi Kanker Payudara" crlf)
    (retract *))

(defrule breast-cancer-verdict-negative
    (declare (salience 100))
    (breast-cancer-negative ?negative)
    (breast-cancer-verdict ?value&:(= ?value ?negative))
=>
    (printout t "Hasil Prediksi = Terprediksi Tidak Kanker Payudara" crlf)
    (retract *))

;STARTING POINT
(defrule ask-for-mean-concave-points  
    (initial-fact)
=>
    (reset)
    (printout t "Mean Concave Points? ")
    (assert (mean-concave-points (read))))

;MAIN NODE LEFT SIDE
(defrule mean-concave-points-left
    (mean-concave-points-threshold ?threshold)
    (mean-concave-points ?value&:(<= ?value ?threshold))
=>
    (printout t "Worst Radius? ")
    (assert (worst-radius (read))))

(defrule worst-radius-left
    (worst-radius-threshold ?threshold)
    (worst-radius ?value&:(<= ?value ?threshold))
=>
    (printout t "Radius Error? " )
    (assert (radius-error (read))))

(defrule worst-radius-right
    (worst-radius-threshold ?threshold)
    (worst-radius ?value&:(> ?value ?threshold))
=>
    (printout t "Mean Texture? " )
    (assert (mean-texture-1 (read))))

(defrule radius-error-left
    (radius-error-threshold ?threshold)
    (radius-error ?value&:(<= ?value ?threshold))
=>
    (printout t "Worst Texture? " )
    (assert (worst-texture (read))))

(defrule radius-error-right
    (radius-error-threshold ?threshold)
    (radius-error ?value&:(> ?value ?threshold))
=>
    (printout t "Mean Smoothness? " )
    (assert (mean-smoothness (read))))

(defrule mean-texture-1-left
    (mean-texture-1-threshold ?threshold)
    (mean-texture-1 ?value&:(<= ?value ?threshold))
    (breast-cancer-positive ?positive)
=>
    (assert (breast-cancer-verdict ?positive)))

(defrule mean-texture-1-right
    (mean-texture-1-threshold ?threshold)
    (mean-texture-1 ?value&:(> ?value ?threshold))
=>
    (printout t "Concave Points Error? " )
    (assert (concave-points-error (read))))

(defrule worst-texture-left
    (worst-texture-threshold ?threshold)
    (worst-texture ?value&:(<= ?value ?threshold))
    (breast-cancer-positive ?positive)
=>
    (assert (breast-cancer-verdict ?positive)))

(defrule worst-texture-right
    (worst-texture-threshold ?threshold)
    (worst-texture ?value&:(> ?value ?threshold))
=>
    (printout t "Worst Area? " )
    (assert (worst-area (read))))

(defrule mean-smoothness-left
    (mean-smoothness-threshold ?threshold)
    (mean-smoothness ?value&:(<= ?value ?threshold))
    (breast-cancer-positive ?positive)
=>
    (assert (breast-cancer-verdict ?positive)))

(defrule mean-smoothness-right
    (mean-smoothness-threshold ?threshold)
    (mean-smoothness ?value&:(> ?value ?threshold))
    (breast-cancer-negative ?negative)
=>
    (assert (breast-cancer-verdict ?negative)))

(defrule concave-points-error-left
    (concave-points-error-threshold ?threshold)
    (concave-points-error ?value&:(<= ?value ?threshold))
    (breast-cancer-negative ?negative)
=>
    (assert (breast-cancer-verdict ?negative)))

(defrule concave-points-error-right
    (concave-points-error-threshold ?threshold)
    (concave-points-error ?value&:(> ?value ?threshold))
    (breast-cancer-positive ?positive)
=>
    (assert (breast-cancer-verdict ?positive)))

(defrule worst-area-left
    (worst-area-threshold ?threshold)
    (worst-area ?value&:(<= ?value ?threshold))
    (breast-cancer-positive ?positive)
=>
    (assert (breast-cancer-verdict ?positive)))

(defrule worst-area-right
    (worst-area-threshold ?threshold)
    (worst-area ?value&:(> ?value ?threshold))
=>
    (printout t "Mean Radius? " )
    (assert (mean-radius (read))))

(defrule mean-radius-left
    (mean-radius-threshold ?threshold)
    (mean-radius ?value&:(<= ?value ?threshold))
=>
    (printout t "Mean Texture? " )
    (assert (mean-texture-2 (read))))

(defrule mean-radius-right
    (mean-radius-threshold ?threshold)
    (mean-radius ?value&:(> ?value ?threshold))
    (breast-cancer-positive ?positive)
=>
    (assert (breast-cancer-verdict ?positive)))

(defrule mean-texture-2-left
    (mean-texture-2-threshold ?threshold)
    (mean-texture-2 ?value&:(<= ?value ?threshold))
    (breast-cancer-negative ?negative)
=>
    (assert (breast-cancer-verdict ?negative)))

(defrule mean-texture-2-right
    (mean-texture-2-threshold ?threshold)
    (mean-texture-2 ?value&:(> ?value ?threshold))
    (breast-cancer-positive ?positive)
=>
    (assert (breast-cancer-verdict ?positive)))

;MAIN NODE RIGHT SIDE
(defrule mean-concave-points-right
    (mean-concave-points-threshold ?threshold)
    (mean-concave-points ?value&:(> ?value ?threshold))
=> 
    (printout t "Worst Perimeter? ")
    (assert (worst-perimeter (read))))

(defrule worst-perimeter-left
    (worst-perimeter-threshold ?threshold)
    (worst-perimeter ?value&:(<= ?value ?threshold))
=> 
    (printout t "Worst Texture? ")
    (assert (worst-texture-2 (read))))

(defrule worst-perimeter-right
    (worst-perimeter-threshold ?threshold)
    (worst-perimeter ?value&:(> ?value ?threshold))
    (breast-cancer-negative ?negative)
=> 
    (assert (breast-cancer-verdict ?negative)))

(defrule worst-texture-2-left
    (worst-texture-2-threshold ?threshold)
    (worst-texture-2 ?value&:(<= ?value ?threshold))
=> 
    (printout t "Worst Concave Points? ")
    (assert(worst-concave-points (read))))

(defrule worst-texture-2-right
    (worst-texture-2-threshold ?threshold)
    (worst-texture-2 ?value&:(> ?value ?threshold))
=>
    (printout t "Perimeter Error? ")
    (assert (perimeter-error (read))))

(defrule worst-concave-points-left
    (worst-concave-points-threshold ?threshold)
    (worst-concave-points ?value&:(<= ?value ?threshold))
    (breast-cancer-positive ?positive)
=> 
    (assert(breast-cancer-verdict ?positive)))

(defrule worst-concave-points-right
    (worst-concave-points-threshold ?threshold)
    (worst-concave-points ?value&:(> ?value ?threshold))
    (breast-cancer-negative ?negative)
=> 
    (assert (breast-cancer-verdict ?negative)))

(defrule perimeter-error-left
    (perimeter-error-threshold ?threshold)
    (perimeter-error ?value&:(<= ?value ?threshold))
=> 
    (printout t "Mean Radius? ")
    (assert (mean-radius-2 (read))))

(defrule perimeter-error-right
    (perimeter-error-threshold ?threshold)
    (perimeter-error ?value&:(> ?value ?threshold))
    (breast-cancer-negative ?negative)
=> 
    (assert (breast-cancer-verdict ?negative)))

(defrule mean-radius-2-left
    (mean-radius-2-threshold ?threshold)
    (mean-radius-2 ?value&:(<= ?value ?threshold))
    (breast-cancer-negative ?negative)
=> 
    (assert (breast-cancer-verdict ?negative)))

(defrule mean-radius-2-right
    (mean-radius-2-threshold ?threshold)
    (mean-radius-2 ?value&:(> ?value ?threshold))
    (breast-cancer-positive ?positive)
=>
    (assert (breast-cancer-verdict ?positive)))