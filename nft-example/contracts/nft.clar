
;; title: nft
;; version: 1.0
;; summary: A basic NFT contract
;; description: This contract implements the minimum requirements of a Stacks NFT

;; traits
(impl-trait 'SP2PABAF9FTAJYNFZH93XENAJ8FVY99RRM50D2JG9.nft-trait.nft-trait)

;; token definitions
(define-non-fungible-token HIROS uint) ;; TODO placeholder callout

;; constants
(define-constant MAX_SUPPLY u1000) ;; TODO placeholder callout
(define-constant TOKEN_URI (some "https://hiro.so"))

;; errors
(define-constant ERR-MAX-SUPPLY-REACHED (err u300))

;; data varss
;; store the last issued token ID
(define-data-var last-id uint u0)

;; data maps
;;

;; public functions
;; mint and claim a new NFT
(define-public (claim)
    (mint tx-sender))

;; SIP-009 function: Transfer NFT token to another owner
(define-public (transfer (token-id uint) (sender principal) (recipient principal))
    (begin
        (asserts! (is-eq tx-sender sender) (err u403))
        (nft-transfer? HIROS token-id sender recipient))) ;; TODO placeholder callout
                                                          ;; TODO implement type checker?

;; read only functions
;; SIP-009 function: Get the last token ID
(define-read-only (get-last-token-id)
    (ok (var-get last-id)))

;; SIP-009 function: Get token metadata URI
(define-read-only (get-token-uri (token-id uint))
  (ok TOKEN_URI)) ;; TODO placeholder callout
            ;; TO DO confirm best practice for token metadata returning


;; SIP-009 function: Get the owner of a given token
(define-read-only (get-owner (token-id uint))
  (ok (nft-get-owner? HIROS token-id))) ;; TODO placeholder callout

;; private functions
;; mint an NFT
(define-private (mint (new-owner principal))
    (let ((next-id (+ u1 (var-get last-id))))
        (asserts! (<= next-id MAX_SUPPLY) ERR-MAX-SUPPLY-REACHED)
        (var-set last-id next-id)
        (nft-mint? HIROS next-id new-owner))) ;; TODO placeholder callout
