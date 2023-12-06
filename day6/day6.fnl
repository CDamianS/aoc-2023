(global time-to-dist {55 401 93 1405 97 2274 99 1485})
;; (global time-to-dist {55939799 401140522741485})

(global ways-to-beat {})

(each [time dist (pairs time-to-dist)]
  (for [i 0 (- time 1)]
    (when (> (* i (- time i)) dist)
      (table.insert ways-to-beat (+ (- time (* 2 i)) 1))
      (lua :break))))

(global ret 1)

(each [_ w (ipairs ways-to-beat)] (global ret (* ret w)))

(print ret)
