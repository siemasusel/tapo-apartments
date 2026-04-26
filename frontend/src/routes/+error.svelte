<script>
  import { page } from "$app/state";
  import ErrorState from "$lib/components/ErrorState.svelte";

  let errorMessage = "Wystąpił nieoczekiwany błąd.";

  if (page.error && page.error.message) {
    errorMessage = page.error.message;
  } else if (page.status === 404) {
    errorMessage = "Strona nie znaleziona.";
  }
</script>

<ErrorState
  status={page.status}
  message={page.status === 404
    ? "Strona, której szukasz, mogła zostać usunięta, zmienić nazwę lub jest tymczasowo niedostępna."
    : errorMessage}
/>
