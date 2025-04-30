<script lang="ts">
  import ApartmentListing from "$lib/components/ApartmentListing.svelte";
  import SectionTitle from "$lib/components/SectionTitle.svelte";

  import type { PageProps } from "./$types";

  let { data }: PageProps = $props();
</script>

<div class="container mx-auto py-8">
  <SectionTitle text="Nasze apartamenty" size="4xl" />

  <div class="px-2.5 grid grid-cols-1 lg:grid-cols-2 gap-6 xl:gap-12">
    {#each data.apartments as apartment}
      <ApartmentListing {apartment} />
    {/each}
  </div>
</div>
