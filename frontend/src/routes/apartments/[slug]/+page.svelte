<script lang="ts">
  import ApartmentHero from "$lib/components/ApartmentHero.svelte";
  import ApartmentInfo from "$lib/components/ApartmentInfo.svelte";
  import { page } from "$app/state";

  import type { PageData } from "./$types";

  let { data }: { data: PageData } = $props();
  const { apartment } = data;

  const apartmentName = apartment.slug.charAt(0).toUpperCase() + apartment.slug.slice(1);
  const metaDescription = `Komfortowy apartament ${apartmentName} w Krynicy-Zdroju. Idealny na wakacje lub weekend.`;
  const canonicalUrl = page.url.href;
  const ogImageUrl = `${page.url.origin}/images/og-${apartment.slug}.jpg`;
</script>

<svelte:head>
  <title>{apartment.title} - Krynica-Zdrój | TAPO Apartamenty</title>

  <meta
    name="description"
    content="Wynajmij apartament '{apartmentName}' w TAPO Apartamenty, Krynica-Zdrój. {metaDescription} Zarezerwuj online!"
  />

  <meta property="og:title" content="{apartment.title} | TAPO Apartamenty Krynica-Zdrój" />
  <meta property="og:description" content={metaDescription} />
  <meta property="og:type" content="article" />
  <meta property="og:url" content={canonicalUrl} />

  <meta property="og:image" content={ogImageUrl} />
  <meta property="og:image:width" content="1200" />
  <meta property="og:image:height" content="630" />

  <link rel="canonical" href={canonicalUrl} />
</svelte:head>

<div class="bg-grey px-2.5">
  <div class="container mx-auto">
    <ApartmentHero {apartment} />
  </div>
</div>
<div class="container mx-auto px-2.5">
  <ApartmentInfo {apartment} />
</div>
