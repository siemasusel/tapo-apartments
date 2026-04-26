<script>
  import ErrorState from "$lib/components/ErrorState.svelte";
</script>

<svelte:head>
  <base href="/" />
  <title>404 | TAPO Apartamenty Krynica-Zdrój</title>
  <meta name="robots" content="noindex, nofollow" />
</svelte:head>

<ErrorState
  status={404}
  message="Strona, której szukasz, mogła zostać usunięta, zmienić nazwę lub jest tymczasowo niedostępna."
/>
