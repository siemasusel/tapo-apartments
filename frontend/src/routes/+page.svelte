<script lang="ts">
  import Header from "$lib/components/Header.svelte";
  import Amenities from "$lib/components/Amenities.svelte";
  import ApartmentCard from "$lib/components/ApartmentCard.svelte";
  import Contact from "$lib/components/Contact.svelte";

  import type { PageProps } from "./$types";

  let { data }: PageProps = $props();
</script>

<Header />
<Amenities />

<div class="container mx-auto bg-grey px-18 py-12 rounded-2xl">
  <h1 class="text-3xl text-center font-bold mb-12">Nasze apartamenty</h1>
  <div class="space-y-16">
    {#each data.apartments as apartment, index}
      <ApartmentCard {apartment} isEven={index % 2 === 1} />
    {/each}
  </div>
</div>

<Contact />
