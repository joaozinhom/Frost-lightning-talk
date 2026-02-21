---
theme: default
background: ./images/cover.png
class: text-center
highlighter: shiki
lineNumbers: false
transition: slide-left
title: FROST
---

# FROST: Flexible Round-Optimized Schnorr Threshold Signatures

**Another crazy way to use Schnoor**

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
      Open sats grante working on krux-installer, and studying in 42 school.
    </p>
  </div>

</div>

---

<div class="grid grid-cols-2 h-full">

  <div class="flex flex-col justify-center px-12 border-r border-gray-700">
    <h2 class="text-2xl font-bold mb-6 text-blue-400">Por que FROST?</h2>
    <ul class="text-sm leading-loose text-gray-200 space-y-3">
      <li>• ponto 1 — diferença de outras implementações</li>
      <li>• ponto 2 — limitação dos esquemas anteriores</li>
      <li>• ponto 3 — o problema de paralelismo</li>
      <li>• ponto 4 — o ataque de Drijvers</li>
    </ul>
  </div>

  <div class="flex items-center justify-center px-8">
    <img src="./images/intro1.png" class="max-h-80 object-contain" />
  </div>

</div>

---

<div class="grid grid-cols-2 h-full">

  <div class="flex flex-col justify-center px-12 border-r border-gray-700">
    <h2 class="text-2xl font-bold mb-6 text-green-400">Como funciona conceitualmente</h2>
    <ul class="text-sm leading-loose text-gray-200 space-y-3">
      <li>• ponto 1 — threshold e secret sharing</li>
      <li>• ponto 2 — polinômio e shares</li>
      <li>• ponto 3 — ninguém tem a chave completa</li>
      <li>• ponto 4 — assinatura indistinguível de single-signer</li>
    </ul>
  </div>

  <div class="flex items-center justify-center px-8">
    <img src="./images/intro2.png" class="max-h-80 object-contain" />
  </div>

</div>

---

<div class="flex flex-col h-full justify-center items-center px-8">

  <h2 class="text-xl font-bold mb-6 text-blue-300 self-start">Notations</h2>

  <img src="./images_for_slides/notations.png" class="max-h-96 object-contain border border-gray-700 rounded" />

  <p class="mt-6 text-gray-400 text-sm text-center max-w-2xl">
    legenda / comentário sobre esse bloco de fórmulas
  </p>

</div>



---

<div class="flex flex-col h-full justify-center items-center px-8">

  <h2 class="text-xl font-bold mb-6 text-blue-300 self-start">KeyGen — Round 1</h2>

  <img src="./images_for_slides/keygen1.png" class="max-h-96 object-contain border border-gray-700 rounded" />

  <p class="mt-6 text-gray-400 text-sm text-center max-w-2xl">
    legenda / comentário sobre esse bloco de fórmulas
  </p>

</div>

---

<div class="flex flex-col h-full justify-center items-center px-8">

  <h2 class="text-xl font-bold mb-6 text-green-300 self-start">KeyGen — Round 2</h2>

  <img src="./images_for_slides/keygen2.png" class="max-h-96 object-contain border border-gray-700 rounded" />

  <p class="mt-6 text-gray-400 text-sm text-center max-w-2xl">
    legenda / comentário sobre esse bloco de fórmulas
  </p>

</div>

---

<div class="flex flex-col h-full justify-center items-center px-8">

  <h2 class="text-xl font-bold mb-6 text-red-300 self-start">Sign(m) → (m, σ)</h2>

  <img src="./images_for_slides/sign.png" class="max-h-96 object-contain border border-gray-700 rounded" />

  <p class="mt-6 text-gray-400 text-sm text-center max-w-2xl">
    legenda / comentário sobre esse bloco de fórmulas
  </p>

</div>

---

<div class="absolute inset-0">
  <img src="./images_for_slides/finish.png" class="w-full h-full object-cover" />
</div>
