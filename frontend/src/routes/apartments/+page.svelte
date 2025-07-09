<script lang="ts">
  import { page } from "$app/state";
  import ApartmentListing from "$lib/components/ApartmentListing.svelte";
  import SectionTitle from "$lib/components/SectionTitle.svelte";

  import type { PageProps } from "./$types";

  let { data }: PageProps = $props();

  const metaDescription = `Komfortowe apartamenty w Krynicy-Zdroju. Idealny na wakacje lub weekend.`;
  const canonicalUrl = page.url.href;
  const ogImageUrl = `${page.url.origin}/images/og-main.jpg`;
</script>

<svelte:head>
  <title>Apartamenty w Krynicy-Zdroju | TAPO Apartamenty</title>

  <meta
    name="description"
    content="Wynajmij apartament w TAPO Apartamenty, Krynica-Zdrój. {metaDescription} Zarezerwuj online!"
  />
  <meta property="og:title" content="Apartamenty | TAPO Apartamenty Krynica-Zdrój" />
  <meta property="og:description" content={metaDescription} />
  <meta property="og:type" content="article" />
  <meta property="og:url" content={canonicalUrl} />

  <meta property="og:image" content={ogImageUrl} />
  <meta property="og:image:width" content="1200" />
  <meta property="og:image:height" content="630" />
  <meta name="robots" content="noindex, nofollow" />

  <link rel="canonical" href={canonicalUrl} />
</svelte:head>

<div class="container mx-auto py-8">
  <SectionTitle text="Nasze apartamenty" size="4xl" />

  <div class="px-2.5 grid grid-cols-1 lg:grid-cols-2 gap-6 xl:gap-12">
    {#each data.apartments as apartment}
      <ApartmentListing {apartment} />
    {/each}
  </div>
</div>
