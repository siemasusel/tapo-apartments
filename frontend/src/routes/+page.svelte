<script lang="ts">
  import Header from "$lib/components/Header.svelte";
  import Amenities from "$lib/components/Amenities.svelte";
  import ApartmentCard from "$lib/components/ApartmentCard.svelte";
  import Contact from "$lib/components/Contact.svelte";

  import type { PageProps } from "./$types";

  let { data }: PageProps = $props();

  import { onMount } from "svelte";

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
</script>

<Header />
<Amenities />

<section id="apartments">
  <div class="container mx-auto bg-grey px-18 py-12 rounded-2xl">
    <h1 class="text-3xl text-center font-bold mb-12">Nasze apartamenty</h1>
    <div class="space-y-16">
      {#each data.apartments as apartment, index}
        <ApartmentCard {apartment} isEven={index % 2 === 1} />
      {/each}
    </div>
  </div>
</section>

<section id="contact">
  <Contact />
</section>
