(define-map members
  { member: principal }
  { level: uint, expiry: uint })

(define-constant BASIC-FEE u1000)
(define-constant PREMIUM-FEE u5000)
(define-constant BASIC-DURATION u30) ;; Days
(define-constant PREMIUM-DURATION u90) ;; Days

(define-public (purchase-membership (level uint))
  (begin
    (asserts! (or (= level u1) (= level u2)) (err u100)) ;; Invalid level
    (let (
          (fee (if (= level u1) BASIC-FEE PREMIUM-FEE))
          (duration (if (= level u1) BASIC-DURATION PREMIUM-DURATION))
          (expiry (+ (block-height) duration))
    )
      (stx-transfer? fee tx-sender 'SPX1234EXAMPLERECIPIENT) ;; Replace with recipient address
      (map-set members { member: tx-sender } { level: level, expiry: expiry })
      (ok expiry)
    )
  )
)

(define-public (renew-membership)
  (begin
    (match (map-get members { member: tx-sender })
      member-data
      (let (
            (level (get level member-data))
            (fee (if (= level u1) BASIC-FEE PREMIUM-FEE))
            (duration (if (= level u1) BASIC-DURATION PREMIUM-DURATION))
            (new-expiry (+ (block-height) duration))
      )
        (stx-transfer? fee tx-sender 'SPX1234EXAMPLERECIPIENT) ;; Replace with recipient address
        (map-set members { member: tx-sender } { level: level, expiry: new-expiry })
        (ok new-expiry)
      )
      (err u101) ;; Membership not found
    )
  )
)

(define-public (get-membership (member principal))
  (begin
    (match (map-get members { member: member })
      member-data
      (ok member-data)
      (err u102) ;; Membership not found
    )
  )
)
