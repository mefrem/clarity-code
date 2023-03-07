
;; title: ft
;; version: 1.0
;; summary: A basic fungible token contract
;; description: This contract implements the minimum requirements of a Stacks fungible token

;; traits
(impl-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

;; token definitions
(define-fungible-token kongbucks TOKEN_MAX_SUPPLY)

;; constants
(define-constant TOKEN_MAX_SUPPLY u1000000) ;; 1_000_000 KBUX with 1T microtokens
(define-constant contract-owner tx-sender)
(define-constant TOKEN_NAME "Kongbucks")
(define-constant TOKEN_SYMBOL "KBUX")
(define-constant TOKEN_DECIMALS u6)
(define-constant TOKEN_URI u"https://hiro.so") ;; TODO understand why get-token-uri response is different for SIP-010 than sip-009

;; errors
(define-constant ERR-INSUFFICIENT-BALANCE (err u1))
(define-constant ERR-SENDER-AND-RECIPIENT-SAME (err u2))
(define-constant ERR-NON-POSITIVE-AMOUNT (err u3))
(define-constant ERR-UNAUTHORIZED-SENDER (err u4))

;; public functions
;; SIP-010 function: Transfers tokens to a recipient
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
  (if (is-eq tx-sender sender)
    (begin
      (try! (ft-transfer? kongbucks amount sender recipient)) ;; TODO placeholder callout
      (print memo)
      (ok true)
    )
    (err u4)))

;; SIP-010 function: Returns the URI containing token metadata
(define-public (get-token-uri)
  (ok (some TOKEN_URI)))

;; Mint tokens (open to anyone)
(define-public (mint (amount uint)) ;; TODO Ask @Brice if this is a bad form of distribution... like a bad, unsafe practice or something
    (ft-mint? kongbucks amount tx-sender) ;; TODO placeholder callout
)

;; Burn tokens
(define-public (burn (burn-amount uint))
    (begin
        (try! (ft-burn? kongbucks burn-amount tx-sender)) ;; TODO placeholder callout
        (ok true)
    )
)

;; read only functions
;; SIP-010 function: Get the token balance of owner
(define-read-only (get-balance (owner principal))
  (begin
    (ok (ft-get-balance kongbucks owner)))) ;; TODO placeholder callout

;; SIP-010 function: Returns the total number of tokens
(define-read-only (get-total-supply)
  (ok (ft-get-supply kongbucks))) ;; TODO placeholder callout

;; SIP-010 function: Returns the token name
(define-read-only (get-name)
  (ok TOKEN_NAME))

;; SIP-010 function: Returns the symbol or "ticker" for this token
(define-read-only (get-symbol)
  (ok TOKEN_SYMBOL))

;; SIP-010 function: Returns the number of decimals used
(define-read-only (get-decimals)
  (ok TOKEN_DECIMALS))
