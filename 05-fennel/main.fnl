(local lines (io.lines (. arg 1)))

(local rules (icollect [line lines &until (= line "")]
               (let [(s1 s2) (line:match "(%d+)|(%d+)")
                     v1 (tonumber s1)
                     v2 (tonumber s2)]
                 {: v1 : v2})))

(fn get-pos [nums num]
  (accumulate [res nil i num2 (ipairs nums) &until res]
    (if (= num num2) i)))

(fn comp [n1 n2]
  (accumulate [res false _ {: v1 : v2} (ipairs rules) &until res]
    (and (= n1 v1) (= n2 v2))))

(fn mid-val [nums]
  (. nums (+ 1 (// (length nums) 2))))

(fn print-each [...]
  (each [_ val (ipairs [...])]
    (print val)))

(-> (accumulate [(p1 p2) (values 0 0) line lines]
      (let [nums (icollect [num (line:gmatch "%d+")] (tonumber num))
            invalid (accumulate [res false _ {: v1 : v2} (ipairs rules)
                                 &until res]
                      (let [pos1 (get-pos nums v1)
                            pos2 (get-pos nums v2)]
                        (and pos1 pos2 (< pos2 pos1))))]
        (table.sort nums comp)
        (if invalid
            (values p1 (+ p2 (mid-val nums)))
            (values (+ p1 (mid-val nums)) p2))))
    (print-each))
