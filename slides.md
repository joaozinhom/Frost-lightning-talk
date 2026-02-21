---
theme: default
background: ./images_for_slides/cover.png
class: text-center
highlighter: shiki
lineNumbers: false
transition: slide-left
title: FROST
---

# FROST: Flexible Round-Optimized Schnorr Threshold Signatures

**Another crazy way to use Schnorr**

<div class="pt-12 text-gray-400 text-sm">
  joaozinhom
</div>

---

<div class="absolute inset-0 bg-black/90" />

<div class="relative z-10 h-full flex flex-col justify-center px-16">

  <div class="flex gap-12 items-center justify-center mb-10">
    <img src="./images_for_slides/eu.jpeg" class="w-40 h-40 rounded-full object-cover border-2 border-white/30" />
  </div>

  <div class="text-white text-center max-w-2xl mx-auto leading-relaxed">
    <h2 class="text-2xl font-bold mb-4">Joãozinho</h2>
    <p class="text-gray-300 text-base">
      Open sats grant working on krux-installer, and studying in 42 school.
    </p>
  </div>

</div>

---

<div class="flex flex-col h-full items-start justify-center px-20 gap-8">

  <h2 class="text-4xl font-bold text-green-400">Schnorr Multisig landscape</h2>

  <div class="grid grid-cols-3 gap-6 w-full text-sm">

  <div class="bg-white/5 rounded-xl p-5 border border-white/10">
    <div class="text-blue-300 font-bold text-base mb-3">MuSig2</div>
    <ul class="text-gray-300 space-y-2">
      <li>• n-of-n only</li>
      <li>• 2 rounds of communication</li>
      <li>• No threshold — everyone signs</li>
    </ul>
  </div>

  <div class="bg-white/5 rounded-xl p-5 border border-white/10">
    <div class="text-purple-300 font-bold text-base mb-3">Taproot / FROST-like via script</div>
    <ul class="text-gray-300 space-y-2">
      <li>• t-of-n via script path</li>
      <li>• Reveals the policy on-chain</li>
      <li>• Each key stays independent</li>
      <li>• Nunchuck uses this model</li>
    </ul>
  </div>

  <div class="bg-white/5 rounded-xl p-5 border border-green-400/30 border-2">
    <div class="text-green-300 font-bold text-base mb-3">FROST ✦</div>
    <ul class="text-gray-300 space-y-2">
      <li>• True t-of-n threshold</li>
      <li>• Offline signers allowed</li>
      <li>• Single round after preprocess</li>
      <li>• Looks like one Schnorr sig</li>
    </ul>
  </div>

  </div>

  <p class="text-gray-500 text-sm italic">All three produce a valid Schnorr signature — an outside observer cannot tell them apart</p>

</div>

---

<div class="flex flex-col h-full items-start justify-center px-20 gap-8">

  <h2 class="text-4xl font-bold text-green-400">The intuition behind FROST</h2>

  <div class="flex flex-col gap-6 max-w-3xl">

  <div class="flex items-start gap-4">
    <span class="text-2xl mt-1">🔪</span>
    <div>
      <div class="text-white font-semibold text-lg">The private key is split, never assembled</div>
      <div class="text-gray-400">During KeyGen, the secret key is broken into <span class="text-green-300">n shares</span> using a polynomial. No single participant ever holds the full key — not even temporarily.</div>
    </div>
  </div>

  <div class="flex items-start gap-4">
    <span class="text-2xl mt-1">📐</span>
    <div>
      <div class="text-white font-semibold text-lg">The threshold comes from the polynomial degree</div>
      <div class="text-gray-400">A polynomial of degree <span class="text-yellow-300">t−1</span> needs exactly <span class="text-yellow-300">t points</span> to be reconstructed. Each participant holds one point. Fewer than t participants? The secret stays hidden.</div>
    </div>
  </div>

  <div class="flex items-start gap-4">
    <span class="text-2xl mt-1">✍️</span>
    <div>
      <div class="text-white font-semibold text-lg">Signing happens in the exponent — the key never comes back</div>
      <div class="text-gray-400">Each of the t signers produces a <span class="text-red-300">partial signature</span> using only their share. These partials are aggregated into one valid Schnorr signature — the secret was never reconstructed.</div>
    </div>
  </div>

  </div>

</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-blue-400">Why FROST?</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/advantages.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---
layout: center
class: text-center
---

<div class="flex flex-col items-center justify-center h-full gap-6">
  <div class="text-6xl">📖</div>
  <h2 class="text-5xl font-bold text-yellow-300">Notations</h2>
  <p class="text-gray-400 text-lg">Variables and symbols used throughout the protocol</p>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-yellow-300">Notations</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/notations1.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-yellow-300">Notations</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/notations2.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---
layout: center
class: text-center
---

<div class="flex flex-col items-center justify-center h-full gap-6">
  <div class="text-6xl">🔑</div>
  <h2 class="text-5xl font-bold text-blue-300">KeyGen</h2>
  <p class="text-gray-400 text-lg">Distributed key generation — no trusted dealer</p>
</div>

---
layout: center
class: text-center
---

<div class="flex flex-col items-center justify-center h-full gap-4">
  <h2 class="text-4xl font-bold text-blue-300">KeyGen — Round 1</h2>
  <p class="text-gray-400 text-base max-w-xl">Each participant generates their own polynomial and broadcasts commitments</p>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-blue-300">KeyGen — Round 1</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/keygen1_1.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-blue-300">KeyGen — Round 1</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/keygen1_2.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-blue-300">KeyGen — Round 1</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/keygen1_3.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-blue-300">KeyGen — Round 1</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/keygen1_4.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-blue-300">KeyGen — Round 1</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/keygen1_5.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---
layout: center
class: text-center
---

<div class="flex flex-col items-center justify-center h-full gap-4">
  <h2 class="text-4xl font-bold text-green-300">KeyGen — Round 2</h2>
  <p class="text-gray-400 text-base max-w-xl">Each participant assembles their secret share — nobody ever holds the full key</p>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-green-300">KeyGen — Round 2</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/keygen2_1.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-green-300">KeyGen — Round 2</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/keygen2_2.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-green-300">KeyGen — Round 2</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/keygen2_3.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-green-300">KeyGen — Round 2</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/keygen2_4.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---
layout: center
class: text-center
---

<div class="flex flex-col items-center justify-center h-full gap-6">
  <div class="text-6xl">⚙️</div>
  <h2 class="text-5xl font-bold text-orange-300">Preprocess</h2>
  <p class="text-gray-400 text-lg">Generating one-time nonces before signing</p>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-orange-300">Preprocess</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/preprocess1.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-orange-300">Preprocess</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/preprocess2.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-orange-300">Preprocess</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/preprocess3.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---
layout: center
class: text-center
---

<div class="flex flex-col items-center justify-center h-full gap-6">
  <div class="text-6xl">✍️</div>
  <h2 class="text-5xl font-bold text-red-300">Signing</h2>
  <p class="text-gray-400 text-lg">Single-round threshold signing — indistinguishable from single-signer Schnorr</p>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-red-300">Sign(m) → (m, σ)</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/sign1.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-red-300">Sign(m) → (m, σ)</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/sign2.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-red-300">Sign(m) → (m, σ)</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/sign3.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-red-300">Sign(m) → (m, σ)</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/sign4.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-red-300">Sign(m) → (m, σ)</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/sign5.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-red-300">Sign(m) → (m, σ)</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/sign6.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-red-300">Sign(m) → (m, σ)</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/sign7.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---

<div class="flex flex-col h-full">
  <h2 class="text-2xl font-bold pt-10 px-12 text-red-300">Sign(m) → (m, σ)</h2>
  <div class="flex-1 flex items-center justify-center px-8 pb-8">
    <img src="./images_for_slides/sign8.png" class="max-h-full max-w-full object-contain" />
  </div>
</div>

---
  
<div class="absolute inset-0">
  <img src="./images_for_slides/finish.png" class="w-full h-full object-cover" />
</div>