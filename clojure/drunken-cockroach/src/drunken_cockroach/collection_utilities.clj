(ns drunken-cockroach.collection-utilities)

(defn random-item [collection]
  (println (collection (int (rand (count collection)))))
  (collection (int (rand (count collection)))))

