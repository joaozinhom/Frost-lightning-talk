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

<div class="flex flex-col h-full items-center justify-center px-20">

  <h2 class="text-4xl font-bold mb-10 text-green-400 self-start">What is this FROST?</h2>

  <ul class="text-xl leading-relaxed text-gray-200 space-y-8">
    <li>• Its a Schnorr scheme that uses to have multisigs n-of-m</li>
    <li>• Its different from Nunchuck scheme that uses Taproot, and its different from simple Musigs</li>
    <li>• Like simple Musigs and Nunchuck schemes its not possible to an external observer know how many participants are in this contract and even how many sign</li>
  </ul>

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