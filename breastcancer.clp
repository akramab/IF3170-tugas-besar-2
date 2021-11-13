(deffacts init-threshold-value-main
    (mean-concave-points-threshold 0.05)
    (breast-cancer-positive 1.0)
    (breast-cancer-negative 0.0))
    
(deffacts init-threshold-value-left
    (worst-radius-threshold 16.83)
    (radius-error-threshold 0.63)
    (mean-texture-threshold 16.19)
    (worst-texture-threshold 30.15)
    (mean-smoothness-threshold 0.09)
    (concave-points-error-threshold 0.01)
    (worst-area-threshold 641.60)
    (mean-radius-threshold 13.45)
    (mean-texture-threshold 28.79))

(deffacts init-threshold-value-right
    (worst-perimeter-threshold 114.45)
    (worst-texture-threshold 25.65)
    (worst-concave-points-threshold 0.17)
    (perimeter-error-threshold 1.56)
    (mean-radius-threshold 13.34))

(defrule breast-cancer-verdict-positive
    (breast-cancer-positive ?positive)
    (breast-cancer-verdict ?value&:(= ?value ?positive))
=>
    (printout t "Hasil Prediksi = Terprediksi Kanker Payudara" crlf))

(defrule breast-cancer-verdict-negative
    (breast-cancer-negative ?negative)
    (breast-cancer-verdict ?value&:(= ?value ?negative))
=>
    (printout t "Hasil Prediksi = Terprediksi Tidak Kanker Payudara" crlf))

(defrule ask-for-mean-concave-points  
    (initial-fact)
=>
    (printout t "Mean Concave Points? ")
    (assert (mean-concave-points (read))))

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
    (assert (mean-texture (read))))

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

(defrule mean-texture-left
    (mean-texture-threshold ?threshold)
    (mean-texture ?value&:(<= ?value ?threshold))
=>
    (assert (breast-cancer-verdict 1.0)))

(defrule mean-texture-right
    (mean-texture-threshold ?threshold)
    (mean-texture ?value&:(> ?value ?threshold))
=>
    (printout t "Concave Points Error? " )
    (assert (concave-points-error (read))))
