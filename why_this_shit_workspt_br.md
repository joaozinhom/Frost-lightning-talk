# FROST — Por Que Funciona?

> Objetivo: entender a cadeia matemática que garante que a assinatura final `σ = (R, z)` é uma Schnorr válida.

---

## A Pergunta Central

Uma assinatura Schnorr é válida se e somente se:

$$g^z = R \cdot Y^c$$

**Tudo no FROST existe para garantir que essa equação seja satisfeita** — sem que nenhum participante sozinho conheça `s` ou `k`.

---

## Bloco 1 — KeyGen: distribuindo o segredo `s`

### O que acontece

Cada `Pᵢ` escolhe um polinômio secreto de grau `t-1`:

$$f_i(x) = \sum_{j=0}^{t-1} a_{ij} \cdot x^j \quad \text{com } f_i(0) = a_{i0}$$

O **segredo do grupo** é implicitamente a soma dos termos independentes:

$$s = \sum_{i=1}^{n} a_{i0} = \sum_{i=1}^{n} f_i(0)$$

Nunca é calculado em claro. A chave pública é verificável por qualquer um:

$$Y = \prod_{i=1}^{n} g^{a_{i0}} = g^{\sum a_{i0}} = g^s \checkmark$$

### A share de cada participante

`Pᵢ` recebe de cada `Pₗ` o valor `fₗ(i)`, e calcula sua share privada:

$$s_i = \sum_{\ell=1}^{n} f_\ell(i)$$

Isso é um ponto `(i, sᵢ)` no polinômio soma `F(x) = Σ fₗ(x)`, onde `F(0) = s`.

### Por que t participantes bastam?

Pela **interpolação de Lagrange**: um polinômio de grau `t-1` é uniquamente determinado por `t` pontos. Logo:

$$F(0) = s = \sum_{i \in S} \lambda_i \cdot s_i$$

onde os coeficientes de Lagrange são:

$$\lambda_i = \prod_{j \in S,\, j \neq i} \frac{p_j}{p_j - p_i}$$

Com menos de `t` pontos, o polinômio não é determinado — `s` permanece oculto.

---

## Bloco 2 — Preprocess: commitments ao nonce

Cada `Pᵢ` amostra dois nonces privados de uso único `(dᵢⱼ, eᵢⱼ)` e publica os commitments:

$$(D_{ij}, E_{ij}) = (g^{d_{ij}},\, g^{e_{ij}})$$

Seguro pelo **problema do logaritmo discreto**: ninguém consegue extrair os nonces a partir dos commitments públicos.

> ⚠️ Cada par `(dᵢⱼ, eᵢⱼ)` deve ser usado **exatamente uma vez**. Reutilização vaza `sᵢ`.

---

## Bloco 3 — Sign: construindo a assinatura

### 3a. O binding value ρᵢ

Antes de qualquer cálculo de nonce, cada participante deriva:

$$\rho_i = H_1(i,\, m,\, B)$$

onde `B = ⟨(i, Dᵢ, Eᵢ)⟩` é a lista de todos os commitments da sessão.

**Por que isso existe?** Para travar o nonce de cada participante à mensagem `m` e ao conjunto exato de participantes. Sem `ρᵢ`, o ataque de Drijvers seria possível (ver Bloco 5).

---

### 3b. O nonce do grupo `k`

Cada `Pᵢ` contribui com um nonce local:

$$k_i = d_i + e_i \cdot \rho_i$$

O nonce do grupo é a soma:

$$k = \sum_{i \in S} k_i = \sum_{i \in S} (d_i + e_i \cdot \rho_i)$$

O commitment do grupo é:

$$R = \prod_{i \in S} D_i \cdot E_i^{\rho_i} = \prod_{i \in S} g^{d_i + e_i \cdot \rho_i} = g^{\sum k_i} = g^k \checkmark$$

Ninguém conhece `k` — mas todos concordam em `R`.

---

### 3c. O challenge `c`

Calculado por todos de forma idêntica:

$$c = H_2(R,\, Y,\, m)$$

---

### 3d. A resposta individual `zᵢ`

Cada `Pᵢ` computa:

$$z_i = d_i + (e_i \cdot \rho_i) + \lambda_i \cdot s_i \cdot c$$

Decomposição:

$$z_i = \underbrace{k_i}_{\text{nonce local}} + \underbrace{\lambda_i \cdot s_i \cdot c}_{\text{contribuição ao segredo}}$$

---

### 3e. A resposta agregada `z`

$$z = \sum_{i \in S} z_i = \sum_{i \in S} k_i + c \cdot \sum_{i \in S} \lambda_i \cdot s_i$$

**Aplicando Lagrange** na segunda soma:

$$\sum_{i \in S} \lambda_i \cdot s_i = F(0) = s$$

Logo:

$$\boxed{z = k + s \cdot c}$$

Essa é **exatamente** a resposta de uma Schnorr padrão.

---

### 3f. Verificação final

A equação de verificação Schnorr:

$$g^z = g^{k + s \cdot c} = g^k \cdot (g^s)^c = R \cdot Y^c \checkmark$$

A assinatura `σ = (R, z)` é válida para qualquer verificador externo usando apenas `Y`.

---

## Bloco 4 — O Truque Central: Lagrange no Expoente

O ponto mais elegante do FROST: os participantes fazem interpolação de Lagrange **sem reconstruir `s`**.

Cada `Pᵢ` multiplica sua share pelo seu `λᵢ` localmente:

$$\lambda_i \cdot s_i$$

A soma dessas contribuições converge para o segredo:

$$\sum_{i \in S} \lambda_i \cdot s_i = s$$

Nenhum participante em momento algum conhece `s`. A reconstrução acontece "implicitamente" na aritmética da soma das respostas `zᵢ`.

---

## Bloco 5 — Por que ρᵢ protege contra Drijvers

### O ataque (sem ρᵢ)

O adversário abre `T` sessões paralelas e tenta encontrar hashes que se combinem:

$$H_2(R^*,\, Y,\, m^*) = \sum_{j=1}^{T} \gamma_j \cdot H_2(R_j,\, Y,\, m_j)$$

Isso é possível porque `R*` e os `Rⱼ` são **independentes** — o adversário pode variar `m*` e `R*` livremente (ataque de aniversário de Wagner).

### Como ρᵢ bloqueia o ataque

Com o binding value, o commitment de cada participante é:

$$R_i = D_i \cdot E_i^{\rho_i} = D_i \cdot E_i^{H_1(i,\, m,\, B)}$$

`R` passa a depender de `m` e de `B` (que contém todos os `Dᵢ, Eᵢ`). Então `R*` no lado esquerdo da equação acima **também muda** toda vez que qualquer `Rⱼ` muda — os dois lados deixam de ser independentes. O ataque de Wagner vira múltiplos ataques de pré-imagem, computacionalmente inviável.

---

## Cadeia Lógica Completa

```
KEYGEN
  Pᵢ cria fᵢ(x) com fᵢ(0) = aᵢ₀
  sᵢ = Σ fₗ(i)  →  sᵢ é ponto em F(x) com F(0) = s
  Y  = g^s  (calculável sem conhecer s)

PREPROCESS
  Pᵢ amostra (dᵢ, eᵢ), publica (Dᵢ, Eᵢ) = (g^dᵢ, g^eᵢ)

SIGN
  ρᵢ = H₁(i, m, B)          ← trava nonce à sessão
  kᵢ = dᵢ + eᵢ·ρᵢ           ← nonce local
  R  = g^(Σkᵢ) = g^k        ← commitment do grupo
  c  = H₂(R, Y, m)          ← challenge
  zᵢ = kᵢ + λᵢ·sᵢ·c        ← resposta local
  z  = Σzᵢ = k + s·c        ← Lagrange: Σλᵢsᵢ = s

VERIFICAÇÃO
  g^z = g^(k+sc) = g^k·(g^s)^c = R·Y^c  ✓
```

---

## Resumo das Garantias

| Propriedade | Como é garantida |
|---|---|
| Ninguém conhece `s` | Shamir: t pontos necessários para reconstruir F(0) |
| Ninguém conhece `k` | Aditive secret sharing: cada Pᵢ contribui kᵢ |
| Assinatura é Schnorr válida | z = k + s·c por construção via Lagrange |
| Segurança contra Drijvers | ρᵢ acopla R à mensagem e aos commitments |
| Misbehaving identificado | SA verifica g^{zᵢ} = Rᵢ · Yᵢ^{c·λᵢ} por participante |
