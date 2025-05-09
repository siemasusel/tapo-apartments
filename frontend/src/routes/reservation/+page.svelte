<script lang="ts">
  import { page } from "$app/state";
  import Reservation from "$lib/components/Reservation.svelte";

  import type { PageProps } from "./$types";

  let { data }: PageProps = $props();
  let { contactInformation } = data;

  const canonicalUrl = page.url.href;
  const ogImageUrl = `${page.url.origin}/images/og-main.jpg`;
</script>

<svelte:head>
  <title>Rezerwacja Online Apartamentów | TAPO Apartamenty Krynica-Zdrój</title>

  <meta
    name="description"
    content="Zarezerwuj swój pobyt w TAPO Apartamenty w Krynicy-Zdroju. Wypełnij formularz rezerwacji online, sprawdź dostępność i wybierz idealny apartament dla siebie."
  />
  />

  <meta property="og:title" content="Rezerwacja Online | TAPO Apartamenty Krynica-Zdrój" />
  <meta
    property="og:description"
    content="Łatwa rezerwacja apartamentów w Krynicy-Zdroju online. Sprawdź terminy i zarezerwuj nocleg w TAPO Apartamenty."
  />
  <meta property="og:type" content="website" />
  <meta property="og:url" content={canonicalUrl} />

  <meta property="og:image" content={ogImageUrl} />
  <meta property="og:image:width" content="1200" />
  <meta property="og:image:height" content="630" />

  <link rel="canonical" href={canonicalUrl} />
</svelte:head>

<div class="container px-2.5 text-center mx-auto py-12">
  <Reservation {contactInformation} />
</div>
