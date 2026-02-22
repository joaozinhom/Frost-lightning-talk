# FROST Protocol — Step-by-Step Summary

## Initial Knowledge (shared by everyone before anything starts)

- Group $G$, generator $g$, hash function $H$
- Total participants $n$ and threshold $t$
- Everyone's indices: $P_1, P_2, \dots, P_n$
- **No secrets exist yet** — indices are just "reserved addresses"

---

## KeyGen — Round 1 (local + broadcast)

**Step 1 — Each $P_i$ creates their polynomial**

$$f_i(x) = a_{i0} + a_{i1}x + \dots + a_{i(t-1)}x^{t-1}$$

- $a_{i0}$ is the personal secret — never shared directly
- Degree $t-1$ means exactly $t$ points are needed to reconstruct it
- Each participant acts as their own dealer (Pedersen DKG)

**Step 2 — Proof of knowledge of $a_{i0}$ (prevents rogue-key attack)**

$$k \xleftarrow{\$} \mathbb{Z}_q, \quad R_i = g^k$$
$$c_i = H(i, \Phi, g^{a_{i0}}, R_i), \quad \mu_i = k + a_{i0} \cdot c_i$$
$$\sigma_i = (R_i, \mu_i)$$

- It's literally a Schnorr signature proving knowledge of $a_{i0}$
- $\Phi$ is a context string to prevent replay attacks
- Without this, a malicious participant could cancel others' contributions

**Step 3 — Public commitments of all coefficients**

$$\vec{C}_i = \langle \phi_{i0}, \phi_{i1}, \dots, \phi_{i(t-1)} \rangle, \quad \phi_{ij} = g^{a_{ij}}$$

- "Raising to the exponent" — publishes a fingerprint without revealing secrets
- $\phi_{i0} = g^{a_{i0}}$ is $P_i$'s public key

**Step 4 — Broadcast**

Each $P_i$ sends $(\vec{C}_i, \sigma_i)$ to everyone.

- Must be broadcast (not private) so everyone has the same view
- Steps 1–3 were all local; this is the first communication

**Step 5 — Verify received proofs**

$$R_\ell \stackrel{?}{=} g^{\mu_\ell} \cdot \phi_{\ell 0}^{-c_\ell}, \quad \text{where } c_\ell = H(\ell, \Phi, \phi_{\ell 0}, R_\ell)$$

- Skip $\ell = i$ (no need to verify your own proof)
- Standard Schnorr verification
- **Abort if any check fails**

---

## KeyGen — Round 2 (private shares + aggregation)

**Step 1 — Private share distribution**

Each $P_i$ sends **privately** to each $P_\ell$:

$$(\ell,\ f_i(\ell))$$

- $f_i(\ell)$ is $P_i$'s polynomial evaluated at $P_\ell$'s index
- One point per recipient — not enough to reconstruct $f_i$ alone
- Requires a secure channel (e.g. TLS)

**Step 2 — Verify received shares**

$$g^{f_\ell(i)} \stackrel{?}{=} \prod_{k=0}^{t-1} \phi_{\ell k}^{i^k \bmod q}$$

- Checks consistency against Round 1 commitments
- No need to know secret coefficients — verification happens in the exponent
- **Abort if any check fails**

**Step 3 — Compute final secret share**

$$s_i = \sum_{\ell=1}^{n} f_\ell(i)$$

- Collapses $n$ received values into a single secret
- Equivalent to a point on the combined polynomial $F(x) = \sum f_\ell(x)$
- Delete all individual $f_\ell(i)$ after summing

**Step 4 — Derive public keys**

$$Y_i = g^{s_i} \quad \text{(personal verification key)}$$
$$Y = \prod_{j=1}^{n} \phi_{j0} = g^{F(0)} \quad \text{(group public key)}$$

- $Y$ is the key the outside world uses to verify signatures
- $Y_i$ is used during signing to verify $P_i$'s share
- The group secret $F(0)$ is **never explicitly computed**

---

## Preprocess (done before signing, can be batched)

**Step 1 — Generate $\pi$ nonce pairs**

For each $j \in \{1, \dots, \pi\}$:

$$(d_{ij}, e_{ij}) \xleftarrow{\$} \mathbb{Z}_q^* \times \mathbb{Z}_q^*$$
$$(D_{ij}, E_{ij}) = (g^{d_{ij}},\ g^{e_{ij}})$$

- Two nonces per slot (not one) — needed for the binding mechanism against Drijvers attack
- Secrets $(d_{ij}, e_{ij})$ stay private; commitments $(D_{ij}, E_{ij})$ are published
- $\pi$ = number of future signing operations this batch covers

**Step 2 — Publish commitment list**

$$L_i = \langle (D_{ij}, E_{ij}) \rangle_{j=1}^{\pi}$$

- Published to a predetermined location accessible by the SA
- Each pair is **single-use** — consumed one per signing operation

---

## Sign — Single Round

**Step 1 — SA selects participants and builds $B$**

SA selects $\alpha$ participants ($t \leq \alpha \leq n$) forming set $S$, fetches the next available commitment from each $L_i$, and builds:

$$B = \langle (i, D_i, E_i) \rangle_{i \in S}$$

SA sends $(m, B)$ to every $P_i \in S$.

**Step 2 — SA sends $(m, B)$ to each participant**

(Distribution step — SA already built $B$ in step 1)

**Step 3 — Each $P_i$ validates**

- Checks that $m$ is a message they're willing to sign
- Checks that every $D_\ell, E_\ell \in G^*$ (no identity element / zero points)
- **Abort if any check fails**

**Step 4 — Each $P_i$ computes binding values, $R$, and challenge $c$**

$$\rho_\ell = H_1(\ell, m, B) \quad \forall \ell \in S$$
$$R = \prod_{\ell \in S} D_\ell \cdot (E_\ell)^{\rho_\ell}$$
$$c = H_2(R, Y, m)$$

- $\rho_\ell$ **binds** each participant to this specific message and set $B$
- This is what defeats the Drijvers attack — $R$ depends on $m$ and $B$, making cross-session combination impossible

**Step 5 — Each $P_i$ computes their signing share $z_i$**

$$z_i = d_i + (e_i \cdot \rho_i) + \lambda_i \cdot s_i \cdot c$$

Where the Lagrange coefficient is:

$$\lambda_i = \prod_{j \in S,\ j \neq i} \frac{j}{j - i}$$

- Compared to plain Schnorr $z = k + s \cdot c$:
  - $d_i + (e_i \cdot \rho_i)$ → distributed nonce (plays the role of $k$)
  - $\lambda_i \cdot s_i$ → adjusted secret share (plays the role of $s$)
  - $c$ → same challenge as in standard Schnorr
- $\lambda_i$ is recalculated for every signing session based on who's in $S$

**Step 6 — Delete nonces and return $z_i$**

Each $P_i$ **securely deletes** $((d_i, D_i), (e_i, E_i))$ and sends $z_i$ to SA.

- Delete **before** anything else — nonce reuse leaks the secret share
- SA only receives $z_i$ — never sees $s_i$ or the raw nonces

**Step 7 — SA verifies, aggregates, and publishes**

**7.a** SA independently recomputes $\rho_i$, $R_i$, $R$, and $c$

**7.b** SA verifies each share:

$$g^{z_i} \stackrel{?}{=} R_i \cdot Y_i^{c \cdot \lambda_i}$$

If any check fails → identify the misbehaving participant and abort.

**7.c** SA aggregates:

$$z = \sum_{i \in S} z_i$$

**7.d** SA publishes $\sigma = (R, z)$ along with $m$.

- The result is a **standard Schnorr signature** — indistinguishable from a single-signer signature
- Anyone can verify using $Y$ and standard Schnorr verification

---

## Key Properties Summary

| Property | FROST |
|---|---|
| Threshold | True $t$-of-$n$ |
| Signing rounds | 1 (after preprocess) |
| Offline signers | Allowed |
| Output | Standard Schnorr sig |
| Robustness | Abort on misbehaviour |
| Security assumption | Discrete log hardness |
| Concurrent signing | Safe (binding via $\rho$) |
| Secret reconstruction | Never happens explicitly |