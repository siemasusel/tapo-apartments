<script lang="ts">
  import ApartmentListing from "$lib/components/ApartmentListing.svelte";

  import type { PageProps } from "./$types";

  let { data }: PageProps = $props();
</script>

<main class="container mx-auto py-12">
  <h1 class="text-4xl font-bold text-center mb-12">Nasze Apartamenty</h1>

  <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 xl:gap-12">
    {#each data.apartments as apartment}
      <ApartmentListing {apartment} />
    {/each}
  </div>
</main>
