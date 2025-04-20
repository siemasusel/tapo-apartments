<script lang="ts">
  import type { ContactInformation } from "$lib/types";
  export let contactInformation: ContactInformation;
</script>

<div class="max-w-xl mx-auto px-6 py-5 rounded-xl bg-primary-superlight shadow-lg animate-fade-in">
  <h2 class="text-2xl mb-3">Rezerwacja apartamentu</h2>
  <p class="text-lg leading-relaxed">
    Aby zarezerwować apartament, prosimy o kontakt przez email
    <a href={`mailto:${contactInformation.email}`} class="text-blue-600 hover:underline font-semibold">
      {contactInformation.email}
    </a>
    lub telefonicznie pod numerem
    <a href={`tel:${contactInformation.phone}`} class="text-blue-600 hover:underline font-semibold">
      {contactInformation.phone}
    </a>.
  </p>
</div>

<style>
  @keyframes fade-in {
    from {
      opacity: 0;
      transform: translateY(10px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
  .animate-fade-in {
    animation: fade-in 0.5s ease-out both;
  }
</style>
