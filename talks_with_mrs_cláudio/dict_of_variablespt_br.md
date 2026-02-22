# FROST — Colinha de Variáveis

## Variáveis Globais

| Variável | Descrição |
|---|---|
| `n` | Número total de participantes |
| `t` | Threshold — mínimo de participantes para assinar |
| `α` | Número de participantes **efetivamente** na operação de assinatura, onde `t ≤ α ≤ n` |
| `i` | Identificador do participante `Pᵢ`, onde `1 ≤ i ≤ n` |
| `Pᵢ` | Participante `i` do protocolo |
| `q` | Ordem prima do grupo |
| `G` | Grupo onde o problema do Logaritmo Discreto é difícil |
| `g` | Gerador de G |
| `H` | Função hash criptográfica com saída em Zq* |
| `s` | Chave privada do grupo (nunca reconstruída em claro) |
| `Y` | Chave pública do grupo: `Y = gˢ` |
| `m` | Mensagem a ser assinada |
| `S` | Conjunto dos `α` participantes selecionados para assinar: `S = {p₁, ..., pα}` |

---

## 🔑 KeyGen — 2 Rounds (Figura 1)

### Round 1

| Variável | Descrição |
|---|---|
| `aᵢ₀, ..., aᵢ₍ₜ₋₁₎` | Coeficientes aleatórios amostrados por `Pᵢ` em Zq |
| `fᵢ(x)` | Polinômio de grau `t-1` de `Pᵢ`: `fᵢ(x) = Σ aᵢⱼ · xʲ`, com `fᵢ(0) = aᵢ₀` |
| `Φ` | String de contexto (evita replay attacks) |
| `k` | Nonce aleatório para a prova de conhecimento de `aᵢ₀` |
| `Rᵢ` | Commitment da prova: `Rᵢ = gᵏ` |
| `cᵢ` | Challenge da prova: `cᵢ = H(i, Φ, g^{aᵢ₀}, Rᵢ)` |
| `μᵢ` | Resposta da prova: `μᵢ = k + aᵢ₀ · cᵢ` |
| `σᵢ = (Rᵢ, μᵢ)` | Prova de conhecimento zero de `aᵢ₀` — previne **rogue-key attacks** |
| `φᵢⱼ` | Commitment público do coeficiente `j` de `Pᵢ`: `φᵢⱼ = g^{aᵢⱼ}` |
| `C̃ᵢ` | Vetor de commitments públicos de `Pᵢ`: `⟨φᵢ₀, ..., φᵢ₍ₜ₋₁₎⟩` |

> **Verificação de σₗ por Pᵢ:** `Rₗ ?= g^{μₗ} · φₗ₀^{-cₗ}`

### Round 2

| Variável | Descrição |
|---|---|
| `fᵢ(ℓ)` | Share secreta calculada por `Pᵢ` e enviada para `Pₗ` |
| `sᵢ` | Share privada final de `Pᵢ`: `sᵢ = Σ fₗ(i)` para todo `ℓ ∈ {1,...,n}` |
| `Yᵢ` | Chave pública do participante `Pᵢ`: `Yᵢ = g^{sᵢ}` |
| `Y` | Chave pública do grupo: `Y = Π φⱼ₀` para todo `j` |

> **Verificação da share recebida por Pᵢ:** `g^{fₗ(i)} ?= Π φₗₖ^{iᵏ mod q}`

---

## ⚙️ Preprocess (Figura 2)

| Variável | Descrição |
|---|---|
| `π` | Número de pares nonce/commitment gerados por rodada de preprocessing |
| `j` | Contador do par de nonce atual (`1 ≤ j ≤ π`) |
| `dᵢⱼ` | 1º nonce privado de uso único de `Pᵢ`, amostrado em Zq* |
| `eᵢⱼ` | 2º nonce privado de uso único de `Pᵢ`, amostrado em Zq* |
| `Dᵢⱼ` | Commitment público do nonce `d`: `Dᵢⱼ = g^{dᵢⱼ}` |
| `Eᵢⱼ` | Commitment público do nonce `e`: `Eᵢⱼ = g^{eᵢⱼ}` |
| `Lᵢ` | Lista de commitments publicada por `Pᵢ`: `⟨(Dᵢⱼ, Eᵢⱼ)⟩` para `1 ≤ j ≤ π` |

> ⚠️ Cada par `(dᵢⱼ, eᵢⱼ)` deve ser usado **no máximo uma vez** — reutilização expõe `sᵢ`!

---

## ✍️ Sign — 1 Round (Figura 3)

| Variável | Descrição |
|---|---|
| `SA` | Signature Aggregator — coordenador semi-confiável (pode ser um `Pᵢ` ou externo) |
| `S` | Conjunto de `α` participantes selecionados: `t ≤ α ≤ n` |
| `B` | Lista ordenada enviada pelo SA: `⟨(i, Dᵢ, Eᵢ)⟩` para `i ∈ S` |
| `ρᵢ` | **Binding value** de `Pᵢ`: `ρᵢ = H₁(i, m, B)` — vincula participante + mensagem + commitments |
| `Rᵢ` | Commitment individual de `Pᵢ`: `Rᵢ = Dᵢ · Eᵢ^{ρᵢ}` |
| `R` | Commitment do grupo: `R = Π Rᵢ` para `i ∈ S` |
| `c` | Challenge global: `c = H₂(R, Y, m)` |
| `λᵢ` | Coeficiente de Lagrange de `Pᵢ` sobre `S`: `λᵢ = Π pⱼ / (pⱼ - pᵢ)` para `j ≠ i` |
| `zᵢ` | Resposta individual de `Pᵢ`: `zᵢ = dᵢ + (eᵢ · ρᵢ) + λᵢ · sᵢ · c` |
| `z` | Resposta agregada: `z = Σ zᵢ` para `i ∈ S` |
| `σ = (R, z)` | **Assinatura final** — verificável como Schnorr padrão com chave pública `Y` |

> **Verificação de cada `zᵢ` pelo SA:** `g^{zᵢ} ?= Rᵢ · Yᵢ^{c·λᵢ}`

---

## Funções Hash

| Função | Entradas | Saída | Onde é usada |
|---|---|---|---|
| `H` | `(i, Φ, g^{aᵢ₀}, Rᵢ)` | Zq* | KeyGen — challenge da prova de conhecimento |
| `H₁` | `(i, m, B)` | Zq* | Sign — geração do binding value `ρᵢ` |
| `H₂` | `(R, Y, m)` | Zq* | Sign — geração do challenge `c` |