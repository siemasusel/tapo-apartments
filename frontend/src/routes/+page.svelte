<script lang="ts">
  import Header from "$lib/components/Header.svelte";
  import Amenities from "$lib/components/Amenities.svelte";
  import ApartmentCard from "$lib/components/ApartmentCard.svelte";
  import Contact from "$lib/components/Contact.svelte";

  import type { PageProps } from "./$types";

  let { data }: PageProps = $props();
  let { contactInformation, apartments } = data;

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
  <div class="container mx-auto lg:bg-grey lg:px-9 lg:py-6 xl:px-18 xl:py-12 rounded-2xl">
    <h1 class="text-3xl text-center font-bold mb-6 xl:mb-12">Nasze apartamenty</h1>
    <div class="space-y-16">
      {#each apartments as apartment, index}
        <ApartmentCard {apartment} isEven={index % 2 === 1} />
      {/each}
    </div>
  </div>
</section>

<section id="contact">
  <Contact {contactInformation} />
</section>
