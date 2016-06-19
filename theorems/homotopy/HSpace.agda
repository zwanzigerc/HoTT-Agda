{-# OPTIONS --without-K #-}

open import HoTT

module homotopy.HSpace where

-- This is just an approximation because
-- not all higher cells are killed.
record HSpaceStructure {i} (A : Type i) : Type i where
  constructor hSpaceStructure
  field
    e : A
    μ : A → A → A
    μ-e-l : (a : A) → μ e a == a
    μ-e-r : (a : A) → μ a e == a
    μ-coh : μ-e-l e == μ-e-r e

module ConnectedHSpace {i} (A : Type i) (c : is-connected 0 A)
  (hA : HSpaceStructure A) where

  open HSpaceStructure hA

  {-
  Given that [A] is 0-connected, to prove that each [μ a] is an equivalence we
  only need to prove that one of them is. But for [a] = [e], [μ a] is the 
  identity so we’re done.
  -}

  μ-e-l-is-equiv : (a : A) → is-equiv (λ a' → μ a' a)
  μ-e-l-is-equiv = prop-over-connected {a = e} c
    (λ a → (is-equiv (λ a' → μ a' a) , is-equiv-is-prop (λ a' → μ a' a)))
    (transport! is-equiv (λ= μ-e-r) (idf-is-equiv A))

  μ-e-r-is-equiv : (a : A) → is-equiv (μ a)
  μ-e-r-is-equiv = prop-over-connected {a = e} c
    (λ a → (is-equiv (μ a) , is-equiv-is-prop (μ a)))
    (transport! is-equiv (λ= μ-e-l) (idf-is-equiv A))

  μ-e-l-equiv : A → A ≃ A
  μ-e-l-equiv a = _ , μ-e-l-is-equiv a

  μ-e-r-equiv : A → A ≃ A
  μ-e-r-equiv a = _ , μ-e-r-is-equiv a
