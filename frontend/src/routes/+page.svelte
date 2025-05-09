<script lang="ts">
  import Header from "$lib/components/Header.svelte";
  import Amenities from "$lib/components/Amenities.svelte";
  import ApartmentCard from "$lib/components/ApartmentCard.svelte";
  import Contact from "$lib/components/Contact.svelte";

  import type { PageProps } from "./$types";

  let { data }: PageProps = $props();
  let { contactInformation, apartments } = data;

  import { onMount } from "svelte";
  import SectionTitle from "$lib/components/SectionTitle.svelte";
  import { page } from "$app/state";

  onMount(() => {
    const hash = window.location.hash.replace("#", "");

    if (hash) {
      const section = document.getElementById(hash);
      setTimeout(() => {
        section?.scrollIntoView({ behavior: "smooth" });
      }, 100);
    } else if (window.location.hash === "#") {
      // Handle direct "/#" links
      window.scrollTo({ top: 0, behavior: "smooth" });
      history.replaceState({}, "", "/"); // Clean URL
    }
  });

  const canonicalUrl = page.url.href;
  const ogImageUrl = `${page.url.origin}/images/og-main.jpg`;
</script>

<svelte:head>
  <title>TAPO Apartamenty - Wynajem Noclegów w Krynicy-Zdroju</title>

  <meta
    name="description"
    content="Odkryj komfortowe apartamenty TAPO w Krynicy-Zdroju. Idealne noclegi blisko atrakcji. Nowoczesne wnętrza, pełne wyposażenie. Sprawdź i rezerwuj online!"
  />
  <meta property="og:title" content="TAPO Apartamenty - Wynajem Noclegów w Krynicy-Zdroju" />
  <meta
    property="og:description"
    content="Odkryj komfortowe apartamenty TAPO w Krynicy-Zdroju. Idealne noclegi blisko atrakcji. Nowoczesne wnętrza, pełne wyposażenie."
  />
  <meta property="og:type" content="website" />
  <meta property="og:url" content={canonicalUrl} />

  <meta property="og:image" content={ogImageUrl} />
  <meta property="og:image:width" content="1200" />
  <meta property="og:image:height" content="630" />

  <link rel="canonical" href={canonicalUrl} />
</svelte:head>

<div class="px-2.5">
  <Header />
  <Amenities />

  <section id="apartments">
    <div class="container mx-auto lg:bg-grey lg:px-9 lg:py-6 xl:px-18 xl:py-12 rounded-2xl">
      <SectionTitle text="Nasze apartamenty" />
      <div class="space-y-8 lg:space-y-16">
        {#each apartments as apartment, index}
          <ApartmentCard {apartment} isEven={index % 2 === 1} />
        {/each}
      </div>
    </div>
  </section>

  <section>
    <Contact {contactInformation} />
  </section>
</div>
