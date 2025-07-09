<script>
  import { page } from "$app/state";
  import { ArrowRight } from "@lucide/svelte";

  let errorMessage = "Wystąpił nieoczekiwany błąd.";

  if (page.error && page.error.message) {
    errorMessage = page.error.message;
  } else if (page.status === 404) {
    errorMessage = "Strona nie znaleziona.";
  }
</script>

<div class="flex flex-col items-center justify-center text-gray-800 font-sans p-4">
  <div class="text-center">
    <h1 class="text-8xl font-bold text-gray-800 mb-4">
      {page.status}
    </h1>
    {#if page.status === 404}
      <p class="text-lg md:text-xl text-gray-600 mb-8">
        Strona, której szukasz, mogła zostać usunięta, zmienić nazwę lub jest tymczasowo niedostępna.
      </p>
    {:else}
      <p class="text-lg md:text-xl text-gray-600 mb-8">Coś poszło nie tak po naszej stronie. Pracujemy nad naprawą!</p>
    {/if}
    <a
      href="/"
      class="inline-flex items-center px-6 py-3 rounded-full border border-transparent text-base font-medium
      text-white bg-primary hover:bg-primary-dark transition-colors duration-200"
    >
      Wróć do Strony Głównej
      <ArrowRight class="ml-1 w-5 h-5" />
    </a>
  </div>
</div>
